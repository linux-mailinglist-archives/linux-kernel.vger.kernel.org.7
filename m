Return-Path: <linux-kernel+bounces-843266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC1BBECAA
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22164EF5B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5952223FC49;
	Mon,  6 Oct 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byGj7G1Q"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48623F421
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771287; cv=none; b=MGRYXd6V+5y5N9TOC8rE9lGp7FBdscbgRDx6o6fpMGzXmmtuvQd5wmk09eLODDENahZVjrj0n8k2vkZQUrdICgN7AoRw8yjdNzX34xarJRxir+JbQDtcwDz3KOPuE9Mus99hP7YT6e9sgaBVkhW1+X44FRzOR6aApjNpSt6d1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771287; c=relaxed/simple;
	bh=GxwecgAhCYFKHy6xZibUthnIopksHNXHtVkNOvFiti0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wea4Cq59yRTOb+7hNERDWD5lOwZZGyXuklBN7jpwWc8I8MdkjQ2LExKBWvJniixV7OxqCt7jkde41FwOLZTOD7Uyq5C2RpFqg2DKoIZBiHnqODZwT2Mc3m7kkIqrgcacVn/KgaoJsdstA9gouunqxfpRZPpLHDu19/bgTh2HgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byGj7G1Q; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso5710605e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759771284; x=1760376084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se0cxel0Jn3xk+mIGXRSV6/sl49L1oxhQS5tH5NnoTM=;
        b=byGj7G1Qa4FCkz+78deE88Ce+mrTahHdS4rEONfUdODOMII3dtKiatuwxlxOtrbsjc
         MWrRtbG34jfgKH07xkI3Ib8i8Pa8xJfSZ/Dn/MP8xbWeXWzO5DOLGaLPFJOKgHs3EZgv
         sxxsricaBvjzw78rm5CijlK4iL0o/uCdixz/5Evnn+61y8n7dVcDxVrOLdhD7okfS2Yw
         tsvhbtcQH/KtmPhksNMrl57pSOd4SeFj7xgY1JtwUDGssu8x6+euG3LjEpWcYM0z5auw
         FX+Rw7PjHAIXYNx8MiFFLwVvGF31bCDXR6NQvUTO4yM3KQsKAWzhXCsgO2jYwEIezu87
         mCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771284; x=1760376084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Se0cxel0Jn3xk+mIGXRSV6/sl49L1oxhQS5tH5NnoTM=;
        b=BPEvoe8ccdm275MJpvXDrYMJ/x5kZWgHpdhoAozpAPe3DJuZ6VsQP0ZvoWKMDIxbKb
         uGR28K/9y89frFK6rNNpJR7fxLss+8Y3uwRP6mQjsyv8338GmCyjRiq07XmaKLe0my68
         +HddctAMwZLjEX6a6MQVIFF4Yz1OqUszpT0BdN17Lho9xJqzFatHfeVR2w5vcVuEDeBs
         TjOrqeZRulpNLhfn0PqR2QjHyUdWVTss+zCuZR3yOCisjsVdApRUCr8dWxEyZCcn8rln
         05/hseSpkovV/iEsK63ObJgn5GJaLYbOuB1Juxl2PBbqEiACVv3IsECXW/rrXLPUPpqc
         gYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3gIaxAzooOsWCq3u94OtUkBJ/hqMIl/m0+X6NdBiij+wCSFvEOlRoUH4nfHzUg2JxKgSOhTU0yxskXQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPGLWhIV1RKjsK8B8RwfVuDEqSzhsehV6c5zC2j7yfebqKKldq
	n3AR/9SLR5G/gI2Cw3Lvf1Ag8lJSZJXH5C7eWWJLB09PMDMWT99U7hfASr2/KvKoGyJY7WTzBSg
	0gErIiyJoLPogAmlUNvKUITJHitGCBE37v86v
X-Gm-Gg: ASbGncsFF29PljfDMO9Pz9PXtYUm28Rh0hwxsJs3mEy5zqpPTObYWLTyq7qL1hUnsS9
	3DrBtaxGZRioXklLzcKhzAco3TgFjC2ry067bfd4MNhmUUA9YAU4mZ5cgKwxt8KTFeVjyO0OJ23
	FM5WV5oHT4MXMZDp/5AdExI0ua87P8qxCUc+/Vcpjy6J7h/TS6e3IBKEJX1ZC5sc7yvBK7OyAvw
	RD0ulDg/q0xavnINqvWd47uLghUGdHs7ICud0Ml
X-Google-Smtp-Source: AGHT+IE1iXszFPocGfX7qXHVJT5YVBxPcMPiwoag2yynKKs8nHxqcOtoAdp0YPRayW+7Uew9/xRJq589UqWPgfxUMVw=
X-Received: by 2002:a2e:bc12:0:b0:36c:47c8:b61c with SMTP id
 38308e7fff4ca-374c38704a4mr36772641fa.34.1759771283500; Mon, 06 Oct 2025
 10:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003205837.10748-1-pascal.giard@etsmtl.ca>
In-Reply-To: <20251003205837.10748-1-pascal.giard@etsmtl.ca>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Oct 2025 13:21:07 -0400
X-Gm-Features: AS18NWAO9zoHMAD2MKmfqNz5oZt9LQCbRQbrV_fdxB9ddan3XJEslyqug-Mo_i0
Message-ID: <CABBYNZJVUoVnJPdOXARvk7T_9EsvomJ_oe_ZZ_QZMTQBVjNDHw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add filter for Qualcomm debug packets
To: Pascal Giard <evilynux@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Giard <pascal.giard@etsmtl.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pascal,

On Fri, Oct 3, 2025 at 4:59=E2=80=AFPM Pascal Giard <evilynux@gmail.com> wr=
ote:
>
> Some Qualcomm Bluetooth controllers, e.g., QCNFA765 send debug packets
> as ACL frames with header 0x2EDC. The kernel misinterprets these as
> malformed ACL packets, causing repeated errors:
>
>   Bluetooth: hci0: ACL packet for unknown connection handle 3804
>
> This can occur hundreds of times per minute, greatly cluttering logs.
> On my computer, I am observing approximately 7 messages per second
> when streaming audio to a speaker.
>
> For Qualcomm controllers exchanging over UART, hci_qca.c already
> filters out these debug packets. This patch is for controllers
> not going through UART, but USB.
>
> This patch filters these packets in btusb_recv_acl() before they reach
> the HCI layer, redirecting them to hci_recv_diag().
>
> Tested on: Thinkpad T14 gen2 (AMD) with QCNFA765, kernel 6.16.9
>
> Signed-off-by: Pascal Giard <pascal.giard@etsmtl.ca>
> ---
>  drivers/bluetooth/btusb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5e9ebf0c5312..900400646315 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -68,6 +68,9 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_ACTIONS_SEMI             BIT(27)
>  #define BTUSB_BARROT                   BIT(28)
>
> +/* Qualcomm firmware debug packets header */
> +#define QCA_DEBUG_HEADER       0x2EDC
> +
>  static const struct usb_device_id btusb_table[] =3D {
>         /* Generic Bluetooth USB device */
>         { USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> @@ -1229,6 +1232,12 @@ static int btusb_recv_intr(struct btusb_data *data=
, void *buffer, int count)
>
>  static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
>  {
> +       /* Drop QCA firmware debug packets sent as ACL frames */
> +       if (skb->len >=3D 2) {
> +               if (get_unaligned_le16(skb->data) =3D=3D QCA_DEBUG_HEADER=
)
> +                       return hci_recv_diag(data->hdev, skb);
> +       }

Well it turns out that handle 0x2EDC is actually a valid handle, so we
can't just reclassify these packets just because Qualcomm thinks that
it could reserve it for its own, so this needs to be using
classify_pkt_type to reclassify the packets to the handle 0x2EDC to
HCI_DIAG_PKT for the models affected.

>         /* Only queue ACL packet if intr_interval is set as it means
>          * force_poll_sync has been enabled.
>          */
> --
> 2.51.0
>


--=20
Luiz Augusto von Dentz

