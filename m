Return-Path: <linux-kernel+bounces-645109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ECCAB4915
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 04:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A22467EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 02:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0513A86C;
	Tue, 13 May 2025 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aWIgb3w2"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25133139D
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101756; cv=none; b=OwDsgi9vQTMuxpWv5WVxDHUmCOGTrpjsD/CvdrreucN71ySnMzV9aWZ6YHgrcoz1QNGdiPqpMVinE0ARNRDQXLWnJSMBXLW6aQZ5dgZv8uiR1rRoDd8GHjK8+sQTy5R4cjMaPpeKYUUctFTNo/b01UdXsuj8gLRKyqRSIAPcf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101756; c=relaxed/simple;
	bh=2TmfNFs04Ogur8mrq/ZrjevwQaQZjMnQRw0yERFTJCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoS7lvoncOHj1QPDH4OKnLcSxak5aNeTsUXikuhIMjm/zDrxZtoz3Zye/Wf4fGyfGkI1wG9yG0TzA2exr7XYycQ8DS9jbfMfeZ8S5eGfuLl80chq2UluP8p+FU+n6fKQUM/LY+rYf34kQJbniS5dFX/ccmlhnDzQEJrqOgr8JBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aWIgb3w2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2TmfNFs04Ogur8mrq/ZrjevwQaQZjMnQRw0yERFTJCA=; b=aWIgb3w2oekMYsag+jcwETow8b
	ec0wJEZEz04nKXBBrSSfdgM8Y4R1HJVt6NDEu0piFqW4M6ZTeKzYWVF5TlgQZdMcepk/S/s94oxwZ
	lTl5HSA41EuizkM6yZmsMEUDeiF8pgfcsi9G4WSjH0d27BJlX7pNOZ2VrPS/GCoYsEOokGEOlCsF/
	CwiaCafQXqr98crMAqUsooKrHVDPR8+DLu/+t2xYaIQSIuvCx3fkIYMSGEoI0SP8woscwRFqh06GU
	q6+KkcWLoSgkeGlT6DocXvUplg6gDeqb8mpY8bZmHs6cyufS/O8W4/BTeiX4R1ltMYj0T/LPX0mw4
	7r1ULfOA==;
Received: from [15.248.7.68] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uEeyN-0000000Grok-0Heh;
	Tue, 13 May 2025 02:02:24 +0000
Message-ID: <35f818e2cf3f15b7dc7028f543e0eea94c799efd.camel@infradead.org>
Subject: Re: [PATCH] kexec: Enable CMA based contiguous allocation
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf
 <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Baoquan He
	 <bhe@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	nh-open-source@amazon.com
Date: Mon, 12 May 2025 19:02:20 -0700
In-Reply-To: <20250512165933.ad1dc7ec5872284b4b59f544@linux-foundation.org>
References: <20250512225752.11687-1-graf@amazon.com>
	 <20250512165933.ad1dc7ec5872284b4b59f544@linux-foundation.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-DYmg+yixTeFbvwsoR1H8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-DYmg+yixTeFbvwsoR1H8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-05-12 at 16:59 -0700, Andrew Morton wrote:
> On Mon, 12 May 2025 22:57:52 +0000 Alexander Graf <graf@amazon.com> wrote=
:
>=20
> > When booting a new kernel with kexec_file, the kernel picks a target
> > location that the kernel should live at, then allocates random pages,
> > checks whether any of those patches magically happens to coincide with
> > a target address range and if so, uses them for that range.
> >=20
> > For every page allocated this way, it then creates a page list that the
> > relocation code - code that executes while all CPUs are off and we are
> > just about to jump into the new kernel - copies to their final memory
> > location. We can not put them there before, because chances are pretty
> > good that at least some page in the target range is already in use by
> > the currently running Linux environment.
> >=20
> > All of this is inefficient.
> >=20
> > Since kexec got introduced, Linux has gained the CMA framework which
> > can perform physically contiguous memory mappings, while keeping that
> > memory available for movable memory when it is not needed for contiguou=
s
> > allocations. The default CMA allocator is for DMA allocations.
> >=20
> > This patch adds logic to the kexec file loader to attempt to place the
> > target payload at a location allocated from CMA. If successful, it uses
> > that memory range directly instead of creating copy instructions during
> > the hot phase. To ensure that there is a safety net in case anything go=
es
> > wrong with the CMA allocation, it also adds a flag for user space to fo=
rce
> > disable CMA allocations.
> >=20
> > Using CMA allocations has two advantages:
> >=20
> > =C2=A0 1) Faster. There is no more need to copy in the hot phase.
>=20
> How much faster?=C2=A0 Kinda matters as "fast" is the whole point of the =
patch!
>=20
> > =C2=A0 2) More robust. Even if by accident some page is still in use fo=
r DMA,
> > =C2=A0=C2=A0=C2=A0=C2=A0 the new kernel image will be safe from that ac=
cess because it resides
> > =C2=A0=C2=A0=C2=A0=C2=A0 in a memory region that is considered allocate=
d in the old kernel and
> > =C2=A0=C2=A0=C2=A0=C2=A0 has a chance to reinitialize that component.
>=20
>=20
https://lore.kernel.org/all/20250512140909.3464-1-dssauerw@amazon.de/> Is t=
his known to be a problem in current code?

Oh $DEITY yes. The Arm Generic Interrupt Controller is, to quote a dear
friend, "a cautionary tale of how not to approach a hardware design".

It does a whole bunch of arbitrary DMA all over the place, and doesn't
even live behind an IOMMU. And doesn't *stop* doing DMA unless you ask
it *really* nicely; merely shutting down the offending high-level
components isn't always enough, because they might still to write back
some caches.

Here's one of the latest examples (not actually the one which has been
breaking kexec for us, as far as we know, but an example of the genre):
https://lore.kernel.org/all/20250512140909.3464-1-dssauerw@amazon.de/

So putting the new kernel into a physical memory region which was
considered 'free' by the previous kernel, as Alex explains, is actually
a very good defence-in-depth mechanism to protect against such issues.


--=-DYmg+yixTeFbvwsoR1H8
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUxMzAyMDIy
MFowLwYJKoZIhvcNAQkEMSIEIA0kx49HEWJra7gY3HPrKISt2JQnnhCxMtPKAym9EeEuMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAA+BpSxf1tcTT
uTD8CxX9vxLTxQzqbNt1Z7ag3kQpN3ZyyVogqCH7xWGU/PimDoH/YHj6uEYk7NxldWkd1mFo5k/z
Ujk7xhfHvsp2j7prKPTIyoOeRAfht+OkN+c0/Ef+D4gXlJNbWVA4NBNHBspauKzRtPOCG6xrCFqm
C7CZ0vOJ2V/1F9Cf/orLGTr49RWFdwYzfSYNQo8Hqsu/oLGFXwMeH7Js7FR0dtK4usAEu3IZenM6
PnK6xJbaVZSibPn2MaNUOPit17sKRGlkQwr+byYWDgn0Jtyi0ser7pka1OOfQm+LvIgctOvuZY9Y
kx08IN62DExW9drvcNnUk/pmnYnFjt7eMJ4M4lKAOJ3VQn6P40xU8mC8ailaT7iWZV2SRTco0NvK
TZrIIvDH4jqRITWQooYJdHqvesBiK+ESjsz5RdTsAduhvLkKMnB0ZXbe4bkTsz36YfouivVofEJ6
iAdH+QravFRwYxh0LfMz2WJDkP/wqEBADVjCJFm5pyVCkkwak/FgvtI+q2MBtOMnwkrgeqDQxyXY
Gmt+7VLHjFLm6tccHqgYhOuSKRchZIoqM3eJO4ni31YWsUdk2qYpJvlxg9mc8hnxpnPAi2vzvsxY
K3TrH6JLyOEaZSi1Lpuc76ajoLlIOxtWSpuT9ii9jfVRxkaMblV0/7vOchA8X6YAAAAAAAA=


--=-DYmg+yixTeFbvwsoR1H8--

