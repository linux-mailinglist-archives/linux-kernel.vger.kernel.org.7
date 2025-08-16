Return-Path: <linux-kernel+bounces-771898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D656B28CA9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A2C1C87D40
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1B12DDA1;
	Sat, 16 Aug 2025 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fQw4VX/O"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB52309B9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755338803; cv=none; b=rwTo7cyT5eZJInxG2S65V5oXXMHUeGUKVZlkTCt5Bq1OCresFQNVGlYeHSvRV3nPMhQfkitllbbh76/GNWllo2UfNy8ZfzuMIdq2KgK69iVITtcFXTLjH8pMHuitT+i2XdrPlPSobeooStOeUKlhwr4DJrcuZEOXdgBfC5wZqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755338803; c=relaxed/simple;
	bh=pKLucIckndNzKKQXHFLnJLSHDR036aYSVfqixTbK0sE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=ZTv4vyTISX5jVB0FK58OngFCNMS7NdLMkwTG2F//vSwQ98PV8yMyF74LInW8UDVqe/I1miw8kwbxvJ6fADyxeV0x7G04Uc80vkZsNlKxWcvv4YwIcQGne8qzAX1C7ZhJWejfj0jlBIpNG/D01BEl67gt6omaUF8BMZesYDvuu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fQw4VX/O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=LJrlyQJfYPERmzZ1AFuTpR5/mtRo1GlxPkfREsjbVXs=; b=fQw4VX/Olk8OBeMDqMuTMgCC7G
	0PKEQ07BkhEi1er3rSs0fQpVhnB5rCLt9ZefbbUw6AIQJGD1Y/6zDASy2GF2ilb+u72ZBwDXa4req
	eJUijncT2Gk2JCMvbKUakTm9KTkcUjEanf77fZlUcBNxUKhIwTV4A1K7ENdAUAwHCDe4M2rwkl/qx
	mNPMpCoaR+u10cPN/aggi04SqRZaNYbl6NbM82D0I3+uPo3RQtMfI9b1lDUs+iGFrf0WxR+N7Galq
	c99O/oXIW4hZ3wqSKke0azEj7mvfi1Qy8fBai+k9SDyahjYSXVzh+kzhL00qTGWj1X7TQRXo5ZAAt
	6AiTBFoA==;
Received: from 54-240-197-233.amazon.com ([54.240.197.233] helo=edge-lb-102.e-fra50.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unDo1-00000007ktq-0N0W;
	Sat, 16 Aug 2025 10:06:33 +0000
Message-ID: <03802f6f7f5b5cf8c5e8adfe123c397ca8e21093.camel@infradead.org>
Subject: [PATCH v4] x86/bhyve: Detect FreeBSD Bhyve hypervisor
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse
 <dwmw@amazon.co.uk>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Konstantin Belousov <kib@kib.kiev.ua>, John Baldwin <jhb@freebsd.org>, 
 "<cperciva@tarsnap.com>"
	 <cperciva@tarsnap.com>
Date: Sat, 16 Aug 2025 11:06:32 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-kd6xMOAnEW03w5kUxCbe"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-kd6xMOAnEW03w5kUxCbe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

This detects the Bhyve hypervisor and enables 15-bit MSI support if
available.

Detecting Bhyve used to be a purely cosmetic issue, of the kernel printing
'Hypervisor detected: Bhyve' at boot time.

But FreeBSD 15.0 will support=C2=B9 the 15-bit MSI enlightenment to support
more than 255 vCPUs (http://david.woodhou.se/ExtDestId.pdf) which means
there's now actually some functional reason to do so.

=C2=B9 https://github.com/freebsd/freebsd-src/commit/313a68ea20b4

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
Wheee, now actually tested under Bhyve.

[    0.000000] Hypervisor detected: Bhyve

v4:
 =E2=80=A2 Add missing parens around (bhyve_cpuid_base | CPUID_BHYVE_FEATUR=
ES)
 =E2=80=A2 Drop unneeded comment about x2apic support

v3:
 =E2=80=A2 Drop the cpuid_level check
 =E2=80=A2 Define and use BHYVE_SIGNATURE
 =E2=80=A2 Use the actual definition of CPUID_BHYVE_FEATURES and logical OR
   instead of adding, as we do for other hypervisor leaves elsewhere
 =E2=80=A2 Fix bhyve_cpuid_max miscalculation mistake

v2:
 =E2=80=A2 Make it optional with CONFIG_BHYVE_GUEST
 =E2=80=A2 Use cpu_feature_enabled()

 arch/x86/Kconfig                  |  9 +++++
 arch/x86/include/asm/hypervisor.h |  2 +
 arch/x86/kernel/cpu/Makefile      |  1 +
 arch/x86/kernel/cpu/bhyve.c       | 63 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c  |  3 ++
 5 files changed, 78 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/bhyve.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..ac1c6df44212 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -879,6 +879,15 @@ config ACRN_GUEST
 	  IOT with small footprint and real-time features. More details can be
 	  found in https://projectacrn.org/.
=20
+config BHYVE_GUEST
+	bool "Bhyve (BSD Hypervisor) Guest support"
+	depends on X86_64
+	help
+	  This option allows to run Linux to recognise when it is running as a
+	  guest in the Bhyve hypervisor, and to support more than 255 vCPUs when
+	  when doing so. More details about Bhyve can be found at https://bhyve.o=
rg
+	  and https://wiki.freebsd.org/bhyve/.
+
 config INTEL_TDX_GUEST
 	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
 	depends on X86_64 && CPU_SUP_INTEL
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
index 1e26179ff18c..2f8a58ef690e 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_X86_SGX)			+=3D sgx/
 obj-$(CONFIG_X86_LOCAL_APIC)		+=3D perfctr-watchdog.o
=20
 obj-$(CONFIG_HYPERVISOR_GUEST)		+=3D vmware.o hypervisor.o mshyperv.o
+obj-$(CONFIG_BHYVE_GUEST)		+=3D bhyve.o
 obj-$(CONFIG_ACRN_GUEST)		+=3D acrn.o
=20
 obj-$(CONFIG_DEBUG_FS)			+=3D debugfs.o
diff --git a/arch/x86/kernel/cpu/bhyve.c b/arch/x86/kernel/cpu/bhyve.c
new file mode 100644
index 000000000000..a628482dd441
--- /dev/null
+++ b/arch/x86/kernel/cpu/bhyve.c
@@ -0,0 +1,63 @@
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
+#define BHYVE_SIGNATURE			"bhyve bhyve "
+
+#define CPUID_BHYVE_FEATURES		0x40000001
+
+/* Features advertised in CPUID_BHYVE_FEATURES %eax */
+#define CPUID_BHYVE_FEAT_EXT_DEST_ID	(1UL << 0) /* MSI Extended Dest ID */
+
+static uint32_t __init bhyve_detect(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+                return 0;
+
+	bhyve_cpuid_base =3D cpuid_base_hypervisor(BHYVE_SIGNATURE, 0);
+	if (!bhyve_cpuid_base)
+		return 0;
+
+	bhyve_cpuid_max =3D cpuid_eax(bhyve_cpuid_base);
+	return bhyve_cpuid_max;
+}
+
+static uint32_t bhyve_features(void)
+{
+	if (bhyve_cpuid_max < bhyve_cpuid_base | CPUID_BHYVE_FEATURES)
+		return 0;
+
+	return cpuid_eax(bhyve_cpuid_base | CPUID_BHYVE_FEATURES);
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
index 553bfbfc3a1b..f3e9219845e8 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -45,6 +45,9 @@ static const __initconst struct hypervisor_x86 * const hy=
pervisors[] =3D
 #ifdef CONFIG_ACRN_GUEST
 	&x86_hyper_acrn,
 #endif
+#ifdef CONFIG_BHYVE_GUEST
+	&x86_hyper_bhyve,
+#endif
 };
=20
 enum x86_hypervisor_type x86_hyper_type;
--=20
2.49.0



--=-kd6xMOAnEW03w5kUxCbe
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgxNjEwMDYz
MlowLwYJKoZIhvcNAQkEMSIEIPD+4pinuVp7WgWLkM6u4hfKO6pYS0i+cJILPsL/sdtMMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAdWDT1f0naut1
VbAANgmy7OMcqC4j8TeJKfNFzLZOQOq9t37+1Mg3LW3X26ib8gn7KV4ZQjByMXcLtPucI7nyLfTM
uU4HZJV9lXoiIRzYn4T+6vNSSU+dvtCMRsIZ1/kmOpt9+gvOnofnRdY41Tx02gjfDGvX9o5bkkpn
8C8gdrQ4VaPHKG/0XhsaLK45WGRpn5nvX4ify3nCvZzMXgGEPJoThWATxENbV71aMuU2ypAArCYI
x+0vqAfpCTcOP5V8Jc3Ot1ltJUwZo+RdGYarHKgpavZ/Hddx87IfQlE5oJ1RV9JSMDxtiHbGA4I1
ZW8c87Xuo4J2bbJnawAVG3mOztU4RLGwZbv/ZxbUouzTmvAme7f+uz+IqJz3IeBS/5vzdRRsDmye
q0nX0wZpO2lOvz59ZrO1BEh3PRSdkfZElv1/dkJqpbIRq08hL/QZk4VYSP4BmHAhbaoHdBzCeBA1
Vbwf/K503hxbUvX5UkB4j1CgOQKWOXNfdfZTFMPS64haHuIjbvSctQscBMFU/vCsndLftbm8VhXn
5OPRqAbTaB9bj8YSf4+FIDpcyCCzBlEnZtgUV0OBw5a4IE5rmnIcPRVPRGa8TBxcp9EnGdx5EQ8N
fbgAoyLVyinyeUx9zvhUgN8IJQYEqVSeZJvVawK5fJjdfBmHAo+cbkj3An+Ufj8AAAAAAAA=


--=-kd6xMOAnEW03w5kUxCbe--

