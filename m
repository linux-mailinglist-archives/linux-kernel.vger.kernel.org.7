Return-Path: <linux-kernel+bounces-762481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9375B2074F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980EA1744BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B72BE7DF;
	Mon, 11 Aug 2025 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ie2Ki29U"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDDE20DD4D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911018; cv=none; b=Zq+PrOCEncD0qFJwbxi6X+ShYw67VRSn4i/uA0qBZnIEqyujsH0okBXaReHK30qa+0Wl5zk4YA+1+GqW4YMyTQRY9YahZoc7KN1yIq9kMhA8xnaVMsLYcfiKQXcDYN+zLgofXmNHdSy8oXbrgTgH4jhe0ZUVX2REOhYWTRgYUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911018; c=relaxed/simple;
	bh=fVZLP2Zj4ccR6/cCGHppFuE/fV/LboeSr7GALEvFaCQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=GU1RYCWmIGm5ejsXgOFoKhwkk++urDpANUwMmVfkpo73OmCGTXKpWn8prVaRFasHChs+hbsagpUgGFLZusV7GOkXXJfZUYNuxvKVpIyhvLtc5TXQfRiF5+h2Jt+CakLbWwaUkdf0kuoQ7vFFBQVZLIah+FmQD/bHV8QieHTcWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ie2Ki29U; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=YKW7bBIKX6ZuJ6HUUMQ9KJeDqD0jx0+jAw3RBOFJvcc=; b=ie2Ki29Unx89ymvVOkrrrW8NRQ
	stor4kcy9yLikRKW3xdqsmSYcXAslq1/ya20Rd9hQ/8qhKp0ZlqAIvBQ9H95IFOv8LOIASOXZZJVF
	Z6VOxFRTNWcA8CO3MoARAMFDNO8sz+l3vaeezqf4CYjA8zHP9qx1VA0coOqGGspZVIkiRn4sytM5E
	bxZd8HcunuZMo4XBH3MfpqHxo1jAnVxpOTyAPXzh9sR8GO817ZQdChccKDN9tSnh/OkQjW7b+Gq7D
	YuuzKBFM9RaL8vWlB8cRhnzSvUgsNo/2mQgrVQW1R9EqFDGVkE/YhaULPl0aKG6fUaEHebfax+/ti
	iHfOVCLg==;
Received: from [54.239.6.186] (helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulQWA-00000004alF-35a3;
	Mon, 11 Aug 2025 11:16:43 +0000
Message-ID: <98dd43553b2d63edd3d994816f378985d1a19d72.camel@infradead.org>
Subject: [RFC PATCH] x86/bhyve: Detect FreeBSD Bhyve hypervisor
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse
 <dwmw@amazon.co.uk>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Konstantin Belousov <kib@kib.kiev.ua>, John Baldwin <jhb@freebsd.org>
Date: Mon, 11 Aug 2025 13:16:42 +0200
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-aDAhUdYX9XhUP2oJ3Mys"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-aDAhUdYX9XhUP2oJ3Mys
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

This detects the Bhyve hypervisor and enables 15-bit MSI support if
available.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
RFC because the CPUID_BHYVE_FEATURES leaf is submitted to FreeBSD in
https://github.com/freebsd/freebsd-src/pull/1797 and not yet merged.
And because I haven't tested this patch at all other than building it.

It's tiny so I didn't put it behind a separate CONFIG_BHYVE_GUEST.
Should I?

 arch/x86/include/asm/hypervisor.h |  2 +
 arch/x86/kernel/cpu/Makefile      |  2 +-
 arch/x86/kernel/cpu/bhyve.c       | 62 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c  |  1 +
 4 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/bhyve.c

diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hyper=
visor.h
index e41cbf2ec41d..9ad86a7d13f6 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -30,6 +30,7 @@ enum x86_hypervisor_type {
 	X86_HYPER_KVM,
 	X86_HYPER_JAILHOUSE,
 	X86_HYPER_ACRN,
+	X86_HYPER_BHYVE,
 };
=20
 #ifdef CONFIG_HYPERVISOR_GUEST
@@ -64,6 +65,7 @@ extern const struct hypervisor_x86 x86_hyper_xen_pv;
 extern const struct hypervisor_x86 x86_hyper_kvm;
 extern const struct hypervisor_x86 x86_hyper_jailhouse;
 extern const struct hypervisor_x86 x86_hyper_acrn;
+extern const struct hypervisor_x86 x86_hyper_bhyve;
 extern struct hypervisor_x86 x86_hyper_xen_hvm;
=20
 extern bool nopv;
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 1e26179ff18c..d4cb04edbacf 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -57,7 +57,7 @@ obj-$(CONFIG_X86_SGX)			+=3D sgx/
=20
 obj-$(CONFIG_X86_LOCAL_APIC)		+=3D perfctr-watchdog.o
=20
-obj-$(CONFIG_HYPERVISOR_GUEST)		+=3D vmware.o hypervisor.o mshyperv.o
+obj-$(CONFIG_HYPERVISOR_GUEST)		+=3D vmware.o hypervisor.o mshyperv.o bhyv=
e.o
 obj-$(CONFIG_ACRN_GUEST)		+=3D acrn.o
=20
 obj-$(CONFIG_DEBUG_FS)			+=3D debugfs.o
diff --git a/arch/x86/kernel/cpu/bhyve.c b/arch/x86/kernel/cpu/bhyve.c
new file mode 100644
index 000000000000..6d8d6ba458ef
--- /dev/null
+++ b/arch/x86/kernel/cpu/bhyve.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FreeBSD Bhyve guest enlightenments
+ *
+ * Copyright =C2=A9 2025 Amazon.com, Inc. or its affiliates.
+ *
+ * Author: David Woodhouse <dwmw2@infradead.org>
+ */
+
+#include <linux/init.h>
+#include <linux/export.h>
+#include <asm/processor.h>
+#include <asm/hypervisor.h>
+
+static uint32_t bhyve_cpuid_base;
+static uint32_t bhyve_cpuid_max;
+
+#define CPUID_BHYVE_FEATURES		1
+
+/* Features advertised in CPUID_BHYVE_FEATURES %eax */
+#define CPUID_BHYVE_FEAT_EXT_DEST_ID	(1UL << 0) /* MSI Extended Dest ID */
+
+static uint32_t __init bhyve_detect(void)
+{
+	if (boot_cpu_data.cpuid_level < 0 ||
+            !boot_cpu_has(X86_FEATURE_HYPERVISOR))
+                return 0;
+
+	bhyve_cpuid_base =3D cpuid_base_hypervisor("bhyve bhyve ", 0);
+	if (!bhyve_cpuid_base)
+		return 0;
+
+	bhyve_cpuid_max =3D cpuid_eax(bhyve_cpuid_max);
+	return bhyve_cpuid_max;
+}
+
+static uint32_t bhyve_features(void)
+{
+	if (bhyve_cpuid_max < bhyve_cpuid_base + CPUID_BHYVE_FEATURES)
+		return 0;
+
+	return cpuid_eax(bhyve_cpuid_base + CPUID_BHYVE_FEATURES);
+}
+
+static bool __init bhyve_ext_dest_id(void)
+{
+	return !!(bhyve_features() & CPUID_BHYVE_FEAT_EXT_DEST_ID);
+}
+
+static bool __init bhyve_x2apic_available(void)
+{
+	/* Bhyve has always supported x2apic */
+	return true;
+}
+
+const struct hypervisor_x86 x86_hyper_bhyve __refconst =3D {
+	.name			=3D "Bhyve",
+	.detect			=3D bhyve_detect,
+	.init.init_platform	=3D x86_init_noop,
+	.init.x2apic_available	=3D bhyve_x2apic_available,
+	.init.msi_ext_dest_id	=3D bhyve_ext_dest_id,
+};
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervi=
sor.c
index 553bfbfc3a1b..157cf9edeb35 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -36,6 +36,7 @@ static const __initconst struct hypervisor_x86 * const hy=
pervisors[] =3D
 #endif
 	&x86_hyper_vmware,
 	&x86_hyper_ms_hyperv,
+	&x86_hyper_bhyve,
 #ifdef CONFIG_KVM_GUEST
 	&x86_hyper_kvm,
 #endif
--=20
2.49.0



--=-aDAhUdYX9XhUP2oJ3Mys
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgxMTExMTY0
MlowLwYJKoZIhvcNAQkEMSIEIC5/pkKywWECArc8T/6DoT+2yINs2YGV4UoSa9Gr3eXqMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAD9be4HO1M5Yx
ba/5Ab6CBiPbGag5/MVSjJu9plQjPHBPZ2ZmmVL9B2ssztNGwBxvyJ3EpaEQi6DHdtC3dSAkrDdd
imHyOyeOixu90XFf5mp4r4h6gxANdo0ZwZPoWk/V+4MfBTP8xdUa1RKZZb4UOqbDllnLejWpQqEe
tVUo52ZQ+FMt4itLeA5UuEOoHrsJi0r375mo5nKsbIk/cOYHbnHpwB20NWuQI0D1gLQ5cT/Clbu9
L0pgizfoReq2DVKErPlfsrZBPFxWB0+R8AV3Z+Zd/H8U1rJy4zjqdsNVxqfWd43rFU/jtvGC79Fk
jsnbukaSKAriRoyPJeveFh6F+yqkFbZaIuwOCtJlkwaPOXsd0ONIO6NUxRECxfRsw+P5LE3MZOGc
EX15e6N21GqmWGHwlfmhkJUFmasQXYFx/KxkPeErOnApwNJJDAh3ibN6Bey72mOXKwj4afUJE+Ff
5xUKg5KWWfO8YF6lhe58cW0fz0JLU3wNGMlHut27nCkDWpTZPsrNeVa+O5IRX460JTW/JP19GHrT
JXmOn0fO6nImP94fa8ESLso7f9bCLDJV4Wg0BZbClAx/O6aJjF0ssJIxFJbAFuHzOAoNlhs+aVI7
SQUlCDIDSjMhitisIVSYx8oR0v74Rm8uUVP76YlJbzPNY7cOga38Y2ArEstNBjEAAAAAAAA=


--=-aDAhUdYX9XhUP2oJ3Mys--

