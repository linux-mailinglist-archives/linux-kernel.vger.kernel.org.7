Return-Path: <linux-kernel+bounces-758204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBA5B1CC69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6C916B7CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1168482EB;
	Wed,  6 Aug 2025 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WD3oCPdd"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4E846C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507784; cv=none; b=Uk0yPG3rvtF6j1UYYjpnYB+uNzLnZHGm84Ip/G3ECEkz3IdzOUcb5KVaBG87n4cWV8rWExzf/S0aXrqsW5qA3mMI04kNbHlt3mfYzum2ocLDgJgEVzg+1tO5yCZb2ntPC3HIrQq1RoYmQnPfU2PnZn2nderEwFhi/Yo9wx2G7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507784; c=relaxed/simple;
	bh=oNbyEfZIdTDFuQQeL5ckkb6NBBY4mwEJW9bc2dFC7ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ioq0PmOcmlEmO8fC6Xmex6yf+YXhGOJuC3TsOW3WS1ct8hxYmIohhaqs0zwNhZvzVZ5sKawQM4Fj/E9XeqjISEc5UDxmwzaN54c9JEnQOaLtevbasnhDomZiJx7L+s9Z2DKbFD8iwNpW9FKNU5MUJOO73zUFsu5/vBMWJONY5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WD3oCPdd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso317027a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754507781; x=1755112581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AOOuysiVblCpCWEtiHdEgOl0B+zKp/TnfDsb9f53Zf0=;
        b=WD3oCPdd8TpLrj4LY5X6CO2+RAxpVV9fJBGviTQUkmGwnwkWoxaGDIjBjULzvrhASr
         xJSwMbyfR0ay0NACcCJQUVvqoCxGpQMCNwkPXJOFGJ1adyd/uMrgj1KS0G171J/nLwtn
         TLmw+z9nfT9uPy2q0FN0TniCRL/IpiOdb4ZFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754507781; x=1755112581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOOuysiVblCpCWEtiHdEgOl0B+zKp/TnfDsb9f53Zf0=;
        b=DUxGQ5JPdzbPexxAfXgdIEzoCbv6TIFwoR7PcTQ0fJw9lypJleBFVnZCfR3zs/+1hU
         /YJS9etpwt4OVpkN2ZydEhtRR3rgFrlKULJwq3lQYv+LQhCgovR7eBzgA6GAVAGlO88a
         cSc/LD3HaGTxosODi0Mi7JU9KWW0kJs7vg4UZswgRGf6D30BtYLRS3b7LPfh9D4Smb1P
         xMHk4ft5swvHNXwnJX8I8w27XzAtGD1Z3pE5I5xKcFepuHmI4kR+hR3czckXbYzdj2rI
         ulPkgWZdET+naIVwkCgyvGMJS6EENBArIlP6H2smNuBRDGitxKOYGnSdOm5Q//6oygPf
         x2HA==
X-Forwarded-Encrypted: i=1; AJvYcCUCmywRYf6em5MeFnmU+fln2uO80xDJufJfW0vrdXGmv8TOEaWVnaExpNSY9qqmRzuUH8UpGxw67HH2DDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQU7dwhV2xT2ZQAWZ9A2KgrEKtmw1GShl5GyvNM7cpsQqMGpWd
	cHuuko+IF8RdZzc54JohvHGsJDUpH5Ku4bbsgLzvo3/6IZA2mvm6kMSgfzbD0m+ZLKOUrBS+y0h
	KS8vXdN259Kiamrmv3rdipeiJ+sTEMzcHglGohQAD
X-Gm-Gg: ASbGncuGG2dfnOz6ulXTRtRJ69YOlOUg586QzOPwMm0ZShlLnwprDROzLvP0jTR3TLb
	tOyyYA4Y9PoA0R9B0fTxDk4zUU1JFG48wpo9S39FoyBKLhNcEaPgJ+M1NRHZW5+5mlLtYpKpbGD
	bFs92WBJ8zN1iHjk4/N2hxBlto2zDAXXHEaaz0+81nfKYWMbqmBhhCDMPxfajMuWveQFEFGoO3+
	hByEkz9
X-Google-Smtp-Source: AGHT+IG5PgMiPi5vTsTJMpsSD9exe2HPclqAjzu7clyfZBo+ywIxmAmWVqAXxbQw2TJXnXncFsVAt6+lEBs9JVJhcuY=
X-Received: by 2002:a17:907:6096:b0:af4:148:e51f with SMTP id
 a640c23a62f3a-af992a37d1fmr341409266b.2.1754507781367; Wed, 06 Aug 2025
 12:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-6iNzq_BV_fK9T4LK0ncZuufqp9E9+DUyFU3jKCnSCjN8n-w@mail.gmail.com>
 <20250806185051.GA10150@bhelgaas>
In-Reply-To: <20250806185051.GA10150@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 6 Aug 2025 15:16:07 -0400
X-Gm-Features: Ac12FXyBLfo1yVe-yTHEhU5KFOqY5PdlkvhxinBq3xRZvzWmEfqkV1u6Ov1u_vQ
Message-ID: <CA+-6iNzAUpMfP8z=zXbQsz=4=YMYgxdSbpDucchECieqpzAzwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Add panic/die handler to driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000180545063bb72d1a"

--000000000000180545063bb72d1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:50=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Aug 06, 2025 at 02:38:12PM -0400, Jim Quinlan wrote:
> > On Wed, Aug 6, 2025 at 2:15=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > >
> > > On Fri, Jun 13, 2025 at 06:08:43PM -0400, Jim Quinlan wrote:
> > > > Whereas most PCIe HW returns 0xffffffff on illegal accesses and the=
 like,
> > > > by default Broadcom's STB PCIe controller effects an abort.  Some S=
oCs --
> > > > 7216 and its descendants -- have new HW that identifies error detai=
ls.
> > >
> > > What's the long term plan for this?  This abort is a huge problem tha=
t
> > > we're seeing across arm64 platforms.  Forcing a panic and reboot for
> > > every uncorrectable error is pretty hard to deal with.
> >
> > Are you referring to STB/CM systems, Rpi, or something else altogether?
>
> Just in general.  I saw this recently with a Nuvoton NPCM8xx PCIe
> controller.  I'm not an arm64 guy, but I've been told that these
> aborts are basically unrecoverable from a kernel perspective.  For
> some reason several PCIe controllers intended for arm64 seem to raise
> aborts on PCIe errors.  At the moment, that means we can't recover
> from errors like surprise unplugs and other things that *should* be
> recoverable (perhaps at the cost of resetting or disabling a PCIe
> device).
FWIW, our original RC controller was paired with MIPs, so it could be
that a number of non-x86 camps just went with the panic-y behavior.

I believe that the PCIe spec allows this rude behavior, or doesn't
specifically disallow it.  I also remember that there is an ARM
standard initiative for ARM-based systems that requires the PCIe
error-gets-0xffffffff behavior.  We obviously don't conform.   At any
rate, I will send an email now to the HW folks I know to remind them
that we need this behavior, at least as a configurable option.

Regards,
Jim Quinlan
Broadcom STB/CM
>
> > > Is there a plan to someday recover from these aborts?  Or change the
> > > hardware so it can at least be configured to return ~0 data after
> > > logging the error in the hardware registers?
> >
> > Some of our upcoming chips will have the ability to do nothing on
> > errant PCIe writes and return 0xffffffff on errant PCIe reads.   But
> > none of our STB/CM chips do this currently.   I've been asking for
> > this behavior for years but I have limited influence on what happens
> > in HW.
>
> Fingers crossed for either that or some other way to make these things
> recoverable.
>
> > > > This simple handler determines if the PCIe controller was the
> > > > cause of the abort and if so, prints out diagnostic info.
> > > > Unfortunately, an abort still occurs.
> > > >
> > > > Care is taken to read the error registers only when the PCIe
> > > > bridge is active and the PCIe registers are acceptable.
> > > > Otherwise, a "die" event caused by something other than the PCIe
> > > > could cause an abort if the PCIe "die" handler tried to access
> > > > registers when the bridge is off.
> > >
> > > Checking whether the bridge is active is a "mostly-works"
> > > situation since it's always racy.
> >
> > I'm not sure I understand the "racy" comment.  If the PCIe bridge is
> > off, we do not read the PCIe error registers.  In this case, PCIe is
> > probably not the cause of the panic.   In the rare case the PCIe
> > bridge is off  and it was the PCIe that caused the panic, nothing
> > gets reported, and this is where we are without this commit.
> > Perhaps this is what you mean by "mostly-works".  But this is the
> > best that can be done with SW given our HW.
>
> Right, my fault.  The error report registers don't look like standard
> PCIe things, so I suppose they are on the host side, not the PCIe
> side, so they're probably guaranteed to be accessible and non-racy
> unless the bridge is in reset.
>
> Bjorn

--000000000000180545063bb72d1a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICYDCC
AlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCkGeYeIHmyIv+2G9CO8ooLbCNTgqYA
UtRwlgVUD/MWyTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA4
MDYxOTE2MjFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQAEAI1ZkIT6Lu5PsxJrIWKb/MLYzg2fXvl3fDLACcuGtYg5EQFMpBkPNWxqya3bfOw8
wyIUWatND/rQRjFBzXNeQzF9LwdqnbEhYdX4tClJh1Ysh+EBDwsfUPnXX0W4pbWNkfEDN8vz7LkU
sJAkkgurBOAe2uBizQSx76zwFZEcwRvPUhkAwfABi9G3qstpTRe7+yavpCMuu2iC3/MuFGlaFlmu
AXo9o8yYJ4M5QHdM7cJlOBb1FmpZ/XSK+Pz55JqBDa5hHe23YD2Hog8zHbzkLUlczlcEnfIWtZmn
xDnc2R4SKzoObQIB3RmKeexewUbm8NaouI4Nq2HnUrgUZ1JX
--000000000000180545063bb72d1a--

