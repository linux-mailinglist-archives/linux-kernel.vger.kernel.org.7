Return-Path: <linux-kernel+bounces-755015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22271B1A011
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F33188DD13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495B023ABB9;
	Mon,  4 Aug 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rjPS2mn6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A4D24DCEC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304900; cv=none; b=VOnCO0XXXCYqRypuJMBR+pEH+r+NULM8UYyE9K+EeBN2+K1hM0i2zthZ71qD1+79FilQO+MAiqwoJzrFXgIdst/CFwmf6ZhQ0aG+OJy/hNXwIk1/wtwqR/ER1CvHsqL3EIwRtSPkvYJHLLlIGXSvDoJxQqzxAd3xMD4vMVbdSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304900; c=relaxed/simple;
	bh=GXUy9xrvJ71oXMX/QfVyvXOKSOpHMBuEGMnEaca3m/0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XaPvG3tieWgCuq42UL8FPXbZJ0VAivtYWEC4PvZm2KsOTVW+/OuGYd10tjzZUx/IiE/stm5wr2+QhXurpwlpTMx9Fo0xgyQDImC3p4/6G1HJaiQANuIjKLamXXlM2sg6B2Y/zR4sTJKAbPxXaz4sNeQ9AU9U5Y1o1whd5DC9zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rjPS2mn6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MXqH0ZjaSRycPKWc1JM2YcXmdmYh5Ohuz9GwdwoWnDs=; b=rjPS2mn6BzFmIBLdpsEPa3b9gS
	GGJWl9essQgbO3UKh9tkfSXw7jZOGglcvAodwJ64f/93Ov91o6+YpGXcsHp/QIH9PX2E7XgYA2pA1
	mFPVdUNiD6f9JJVSgM/LOlpq/iKLbdFgTF9YU2/in/q+mhDjMZDzZm680PpCe81dXuosdzN1xxphr
	WOfmEsC5yiggs4T05FaG0yfr7CZkvZt5OcjEQW7QAi+z/csiJIfbVISyvajwGmwZfngBHNRx7MQ9t
	Cy3HX1uzTIcJgy/RgRa6lh+88zDZVIcsFN6wv5fTUEOttoA5qyWzVZ7BHWhs+JQZiGT3QQfg1FxUR
	U0K4N52w==;
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uisq8-0000000F4Vi-0IiN;
	Mon, 04 Aug 2025 10:54:48 +0000
Message-ID: <6f3dbdc7368ba5d1bcc7bcf4e31a53b8b71904a4.camel@infradead.org>
Subject: Re: linux-6.16/fs/jffs2/readinode.c:189: loop can never finish
From: David Woodhouse <dwmw2@infradead.org>
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Zhihao Cheng
	 <chengzhihao1@huawei.com>, David Binderman <dcb314@hotmail.com>, 
 "richard@nod.at"
	 <richard@nod.at>, "linux-mtd@lists.infradead.org"
	 <linux-mtd@lists.infradead.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>
Date: Mon, 04 Aug 2025 11:54:47 +0100
In-Reply-To: <8114ae51-a238-40d3-9ecd-70e23abae28b@sigma-star.at>
References: 
	<AS8PR02MB10217F68E5D37ECD491495E669C23A@AS8PR02MB10217.eurprd02.prod.outlook.com>
	 <df923d94-92ee-f824-01e2-21e6ed3d593c@huawei.com>
	 <8114ae51-a238-40d3-9ecd-70e23abae28b@sigma-star.at>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-PY8X9KgAkwZG+EkHqeHX"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-PY8X9KgAkwZG+EkHqeHX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-08-04 at 09:30 +0200, David Oberhollenzer wrote:
> Hi,
>=20
> On 8/4/25 9:10 AM, Zhihao Cheng wrote:
> >=20
> > The 'next !=3D NULL' is also a condition for the loop, this snippet
> > of code finds a leaf node in 'tn_root'.
>=20
> Yes, this is a classic tree traversal. Assuming the tree isn't
> broken, the loop eventually terminates when it runs of a leaf.
>=20
> The real issue with this code is that this is the *only* exit
> condition of the loop. The traversal loop always branches until
> it hits a leaf and the function then returns NULL. I'm pretty
> sure this might not be the intended behavior.

It's going back almost two decades now but...

This function is used only during the file system scan, when we scan
the whole medium and initially fill a big bucket of data nodes to be
subsequently processed and (mostly) eliminated due to overlap. It's
allows for early elimination of completely overlapped nodes, to reduce
memory usage. See https://git.kernel.org/torvalds/c/df8e96f39103a for
more details.

The jffs2_add_tn_to_tree() function calls jffs2_lookup_tn() to get a
*starting* point, and then it backs up with rb_prev() until it finds
the *first* node which is part of the overlapping set.

Then, jffs2_add_tn_to_tree() iterates forward from that node until it
has passed the end point of the node being added, looking for nodes
which have been completely obsoleted and can be discarded early.

If jffs2_lookup_tn() *did* always return NULL, that wouldn't actually
cause a correctness problem, as all this is only an optimisation
anyway. But I don't believe it does =E2=80=94 it iterates until 'next' is N=
ULL,
but then returns the 'tn' whose left or right child was that 'next'.

I think there might be a missed optimisation here though. Instead of
using only the *starting* offset of the newly-added node, I think the
jffs2_lookup_fn() function should also use the *end* offset of the
newly-added node. And should only follow the tree down tn->rb.rb_right
if the current tn->fn->ofs is lower than *that*.

Otherwise I think we miss out on immediately discarding a newly-
discovered node which is already completely obsoleted by a node that
starts *earlier* than it.

There's absolutely no good reason why this tmp_dnode code couldn't have
fairly comprehensive unit and torture tests, and I think I'd want to
have those before trying to do something like this to improve the
optimisation...

--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -184,7 +184,7 @@ static struct jffs2_tmp_dnode_info
*jffs2_lookup_tn(struct rb_root *tn_root, uin
        while (next) {
                tn =3D rb_entry(next, struct jffs2_tmp_dnode_info, rb);
=20
-               if (tn->fn->ofs < offset)
+               if (tn->fn->ofs + tn->fn->size < offset)
                        next =3D tn->rb.rb_right;
                else if (tn->fn->ofs >=3D offset)
                        next =3D tn->rb.rb_left;


--=-PY8X9KgAkwZG+EkHqeHX
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgwNDEwNTQ0
N1owLwYJKoZIhvcNAQkEMSIEIIdkMV5tQRz1/XWe+N/lZ8stVkBjeojN4wjFWhfKX6ryMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAAIAd/gLZdGtZ
AQBFx/eFimNMCx8ffD7cxwojjdAtgTVaB7Sa973a6ypT3WLlQKxIhpTUKBnxkb5A1rSJqmUzjmHl
n/okHlLs0bycc2MB9rvCi3b4MdjxAT9YvCbiAkXIELhQfOz0cIl2fY5lctuCFyB7/ebsgAFohWnB
e0TpuMfjqOwMST/Wsljrbgqw8sOj6cScLPcdvM9/MlbhZTjEQPPw5v0dpdq2lVaDkFq+wKFsPgPT
xAmjol/2mRLnUoiYn1S17nqOk7rb0WHi9gIsM1YwTbKRLwcvml9aFzdOytt0ICDzleNw58Rp86UO
Z1lh31RSDNXIynYIOV21sIHZCwA8P02tKBatRbS5RXZbP8s1JxsBbAZWoTu4b7zf6+quP6fBuHNW
py7ExDsQg0DgPdfnmfgei/z1silX3qT+J1Qri1/zSRgCkgXhpS1s8CzjLE1fOXfrY2SHF19X8DU9
ChlGeSBDx8Y0ey95QaDL+2fjRWBFS12mBplrHUzlh1a8MNAfs6LkzpM24NZ7YOak1/VTvgu1Vhiu
8JylozFjEivO29xsTDgy8wqNjc/p8KCiVHGqOD8RCeqKdsgJJjYK9hWlhDtxB+cZuABFG8NFsAja
EigHywYvUc63THFoIfTMOff9GHETs+kakAlmI1q8AtoYWDAyhrg4ZJQ9eLBvjFAAAAAAAAA=


--=-PY8X9KgAkwZG+EkHqeHX--

