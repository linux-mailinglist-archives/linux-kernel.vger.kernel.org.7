Return-Path: <linux-kernel+bounces-844388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C8BC1C97
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E0F1886A79
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598102E1C54;
	Tue,  7 Oct 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heddi06A"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E534BA33
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848363; cv=none; b=eJvK1VAT6UWtoyqMndKX2rJQHtu9mDC0ZxaocdIUh12gHqFdkLG2YJFAmpPm7//e8QCiNsth0v82esKQeBdQLwnhap3JMhKrH/MUJDZ7WWsH8GMdFIWNIv7EN0w16AKg2SyGdPDEDbaXlefeFmGimmiVfP3+vXuXsXHV68E72Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848363; c=relaxed/simple;
	bh=RTcwYRPZvw3SDmP+5PcjoYNa9roPiYW1GnGbWahR/Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vA/AX6/5h9J7uNbNmS2Tc7I1824/JrJFQsxuv/JdoP4XVx2r+ntbHENas6Nx6uurLZeEu8rqclCCiXJlXwwo1Upl9ZqHNiJR3S7hBO+mA31KM0bsuDkrW9/qsq5HaEZwbVQPsYBndbTc2Oo/Pc/IgxTzGEM7omlhSAxfWhH6fgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heddi06A; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3682ac7f33fso68143621fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848360; x=1760453160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fSwjUGERTx2lcqSxjMgAgWVuDWSGgn494UNFqTz9XA=;
        b=heddi06ArnbU6U5/R5FwZV4I1bq+vpPJZBXMyLKzh11AuWVC1mscMG8H9UkSPEQ2Pv
         3BNvF38XO/S+r8trv3vnQVDTax00rG9NTydnYYR0i6f9WZQLRT9Y5SJAOQqI5VP5TMQF
         NAghuC4uhsEk/hjOueurfyoW92+Oumu/qTZAFybjO88IhoANswIz/XybqF8A9+Cesri9
         jV9N88UodANcU9lrBOJ1UOicmE+iQ/J5w7tUBCI7DsQOFbwbd6j3Pi5KoHIYUOjdnTTr
         tS2mTBrWpN6SRW9g8mmdeZBwgWao4hF8inSUoAgEU+SkGs4j/BuMaK1kY+2N/tL+mrhK
         Pr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848360; x=1760453160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fSwjUGERTx2lcqSxjMgAgWVuDWSGgn494UNFqTz9XA=;
        b=TWS3nCLdsiuGGz4UmBDR4nXxR3M7zDlWOcd98ykHPLqk2m/d6VMnuvRbpYbEUjs97v
         sh7qQyP1XS2QCZjZUTBFUkN/nS9HxvaEva4XHe4RPNGNbAxgytFD2zy+V+DzgyTfQQPy
         pYErgO4nNd/Dgsp8CtKWJbitJ1OMD0N1gmNF849vYV80s4+c4UvMHhFTmdCll7d1dzFN
         0revRQPva1SeAIQL1AjhjhRM0Vq3FJL24dB2xoBuiDZYmhBThMSAgxqVHFnh9tJOrZmN
         GUXnp9et6LRhM2Mnh6jfhID/OdOCxEbZk3UrNhMT+PlRkCLXSKi/ovYvk4MvGEpcI+dA
         NzXA==
X-Forwarded-Encrypted: i=1; AJvYcCXn85GrUhGtSpq5ijZGZpGVbP5cR7RJHkDw5OFK82pKYbr0vcdF+ZnLRncLzNCddQ7eyDNOSDXKl9112aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyB0aDhUtO4+FUooGccO8X9P36WnTvSnpwbkPnTzzOjtrX62uE
	g9Y9gaccuiyeWmE8zOOY+xTzv1dn1XRrEZeqqxf54jqpzjnxmFz/nej0a4jzEb3UrMJt47vfpTt
	XScuM69SnW0leXYM87OlsS4/QQ1eyUPA=
X-Gm-Gg: ASbGncuyCKnTFCvz/L//b+sAj97J2mgmxP9z6pHwBgeAumSj7jtyDwXPljjXwNdk4Fx
	ZO40M3069C3FqiBS5KyVB3Bpke+KQHpHS0AK7Dq42eoWG3E0l/RFVmIyGOVeXsh/guPCyTMIhUH
	WF49QCsiL67pHGwZ53dphap5J7LXFfx4/3GoiMXLb6V2gV43f3sCmI61zKrzfiwKgzEIjBjf2iy
	G6yiuNRCi3tR/TQlGJ7gV4e04q9+Q==
X-Google-Smtp-Source: AGHT+IHFWHX250RArTGOyBCS9CbkbXTaQRMu6fYlrtC/TuA5ZXhBnSSuI8qWzqhsLnIS7hqnd8vdq2GosveaG1Gf+AA=
X-Received: by 2002:a05:651c:546:b0:373:a93d:5b4d with SMTP id
 38308e7fff4ca-375f519f397mr11161261fa.14.1759848359590; Tue, 07 Oct 2025
 07:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003205837.10748-1-pascal.giard@etsmtl.ca>
 <CABBYNZJVUoVnJPdOXARvk7T_9EsvomJ_oe_ZZ_QZMTQBVjNDHw@mail.gmail.com> <CAJNNDmm-sBv4Qz9J+bFGWmmQ8jdOKQtRr9xDcwAsDYQQMm0Uxw@mail.gmail.com>
In-Reply-To: <CAJNNDmm-sBv4Qz9J+bFGWmmQ8jdOKQtRr9xDcwAsDYQQMm0Uxw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Oct 2025 10:45:46 -0400
X-Gm-Features: AS18NWDICPYJQh8jAOZU-6p7MFtj8ye0iDygHsNeCffSyKdwOOET5pOUur_f0cE
Message-ID: <CABBYNZ+0W5Aaq1BfzMc1fcQGCUFrDfQcDyffaG=+0LE0=G-wug@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add filter for Qualcomm debug packets
To: Pascal Giard <evilynux@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Giard <pascal.giard@etsmtl.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pascal,

On Tue, Oct 7, 2025 at 10:16=E2=80=AFAM Pascal Giard <evilynux@gmail.com> w=
rote:
>
> Dear Luiz,
>
> Le lun. 6 oct. 2025, =C3=A0 13 h 21, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> a =C3=A9crit :
> >
> > Hi Pascal,
> >
> > On Fri, Oct 3, 2025 at 4:59=E2=80=AFPM Pascal Giard <evilynux@gmail.com=
> wrote:
> > >
> > > Some Qualcomm Bluetooth controllers, e.g., QCNFA765 send debug packet=
s
> > > as ACL frames with header 0x2EDC. The kernel misinterprets these as
> > > malformed ACL packets, causing repeated errors:
> > >
> > >   Bluetooth: hci0: ACL packet for unknown connection handle 3804
> > >
> > > This can occur hundreds of times per minute, greatly cluttering logs.
> > > On my computer, I am observing approximately 7 messages per second
> > > when streaming audio to a speaker.
> > >
> > > For Qualcomm controllers exchanging over UART, hci_qca.c already
> > > filters out these debug packets. This patch is for controllers
> > > not going through UART, but USB.
> > >
> > > This patch filters these packets in btusb_recv_acl() before they reac=
h
> > > the HCI layer, redirecting them to hci_recv_diag().
> > >
> > > Tested on: Thinkpad T14 gen2 (AMD) with QCNFA765, kernel 6.16.9
> > >
> > > Signed-off-by: Pascal Giard <pascal.giard@etsmtl.ca>
> > > ---
> > >  drivers/bluetooth/btusb.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 5e9ebf0c5312..900400646315 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -68,6 +68,9 @@ static struct usb_driver btusb_driver;
> > >  #define BTUSB_ACTIONS_SEMI             BIT(27)
> > >  #define BTUSB_BARROT                   BIT(28)
> > >
> > > +/* Qualcomm firmware debug packets header */
> > > +#define QCA_DEBUG_HEADER       0x2EDC
> > > +
> > >  static const struct usb_device_id btusb_table[] =3D {
> > >         /* Generic Bluetooth USB device */
> > >         { USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> > > @@ -1229,6 +1232,12 @@ static int btusb_recv_intr(struct btusb_data *=
data, void *buffer, int count)
> > >
> > >  static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *s=
kb)
> > >  {
> > > +       /* Drop QCA firmware debug packets sent as ACL frames */
> > > +       if (skb->len >=3D 2) {
> > > +               if (get_unaligned_le16(skb->data) =3D=3D QCA_DEBUG_HE=
ADER)
> > > +                       return hci_recv_diag(data->hdev, skb);
> > > +       }
> >
> > Well it turns out that handle 0x2EDC is actually a valid handle, so we
> > can't just reclassify these packets just because Qualcomm thinks that
> > it could reserve it for its own, so this needs to be using
> > classify_pkt_type to reclassify the packets to the handle 0x2EDC to
> > HCI_DIAG_PKT for the models affected.
>
> Thank you for considering my patch. Based on your comment, I had a
> look at how btintel.c uses classify_pkt_type, and I think I understand
> what you are expecting of me.
>
> Before I submit a new version, should I go very narrow (just the
> VID:PID=3D0x0489:0xe0d0 I know for certain has the issue) or should I
> lump in all modules with the WCN6855 chip? The latter seems somewhat
> reasonable to me given how hci_qca.c does it (even broader).
> Therefore, I'm thinking of reusing BTUSB_QCA_WCN6855.

I'm afraid you will need to figure it out, probably only qualcomm
folks can tell which chips use this logic, also is it always enabled
to send debug information or that requires a vendor command to enable
debug traces to be sent using that handle?

> Thanks,
>
> -Pascal
> --
> Homepage (http://pascal.giard.info)
> =C3=89cole de technologie sup=C3=A9rieure (http://etsmtl.ca)



--=20
Luiz Augusto von Dentz

