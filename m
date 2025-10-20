Return-Path: <linux-kernel+bounces-860276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F425BEFBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC89F1894955
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E4E2DF133;
	Mon, 20 Oct 2025 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7s9h8RG"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05661A76BC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946432; cv=none; b=ihS65siAFT1COJ2aOGKIuhg7UTErOWszoecjfB2s1pFtgwN6ST5idLiBf11Kjzd5AVrBwf240tFjbYGTRMYJj0LyBgchv5IbA/P90zVwRf6z8gw9HhGVS2moCwS3JkSuBMRY0GMfnDlfNtTvmj+Op8UvyoBoiGSlAYzx6RgmOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946432; c=relaxed/simple;
	bh=W+ylqzQuo2ib5xe8ttVsSyJYGNvN42BnhUnPMTjp0ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/7A/vdO1Ns00LSSQv7D/QCTSboFj58bx+nuyf/a+SQdoab+Yuca63u1qwfw56W94yatex2fH148ZMb6Bp6GpcLzd4GeK/BGk1GeloPJHf/AQBBw3jE0sFRF9O/AZY76624kMrwzW0VnIBKicBG01ssPxxFiA1vmqNACP+hfV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7s9h8RG; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6317348fa4fso681203a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760946428; x=1761551228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Go4Asv7YwLv33nHUULAGfMoh2O4c1Ds20DzwpeLzbGA=;
        b=S7s9h8RGtLygp1GWwjad+Cg5Y92pGfHbw5jaZLL6oWeJXhYv3VIOtEAGmUdLow/o/8
         gBnHPSpbnigOVJObZz0kFno6YMESBsK8PuV/EGIgFAMI/Z2yrbIivrCTDhrxMi+VJ5Yf
         rJd4eFS111lfkeZmqYtMF6jOGIAcK98UEa7ZBKEC6JPtKipnxQ1X5SmgELgZkG2lwiZv
         phmMLTNCyddV3yFBZBQ/i659Bu/JoASlSXMxaOrkbacjvkay6AyrW9b01L15k0tm8A9T
         MP7Jh28++oHLR0XBnVdLTEXEwHgoaRY6vCCMYtq3PMQm9xRar/tutsVatNj1G8E9fsHJ
         k1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946428; x=1761551228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Go4Asv7YwLv33nHUULAGfMoh2O4c1Ds20DzwpeLzbGA=;
        b=MvfdLAQn39B5Nfw+hcnfkLprZbs+xr+U0k7kyujSY1hVsxIutM3o8BhApN4LSOYAkT
         SbnZkwd4UJa2+oiQ4eX22ezUQh4z+xbREzp9SDEihezpYEDL7T6vXXo57G7yEgKIiPVF
         87eutFsDMccwA+cTxPG3+5GlbRwGpxOK+5nGcJlW3HJ65HinIIY8vGr8Qisx7DTjyN7u
         9T/AuBedGJxkFKUWyfzJ3TuzMlB3+XN0ia+lRiZapUhz0Ahxdv+hhrlylstdl55xWKsW
         fwnawcPlZa0P3CUEoJ8I4je6xAfoje/B0sY9xZ0wIBjNBOsjuZQK+cYboy76ufK9ecT7
         kqzw==
X-Gm-Message-State: AOJu0Yx0wOxmFxfeqEaFOyscP9AiEKypfkvQ/CJ+PTOCug1PDhYxbeww
	qEmSE7uJQZT+dyZVpJhiIIIPkcgfGbN8vVZd15iPLYBthWi2fqctX3IFFDrS8J3AHWlKx6iJOZ0
	tomH9x0rinGTth3mu7zXh2CtgK19FAR8=
X-Gm-Gg: ASbGncuc8ZXHCzHYWGS/wBzZvkUzNzEd3bXHSvF8/TnXEdRo5Lu7XD4pvvKhnLgsDsE
	zYC7P5ajqEpVbjoVMVtZIzPHH4baiqGMeFN9bjkK99VJe91qoxA5bE5PHUUzBICuptRxxCgfGWG
	+vx8E7mCcogLhqjUNGErwHnYOTpTEd3ZvIsRiZpqSzLvFaIgCCXzWTsyKWEbnSwoAY9AjYF6S9K
	EfNDUSxiA+Ol06yRlDgdhcthsaVh9oDc/za/0CIJlNDWuKMEAAuOo7b6Uk=
X-Google-Smtp-Source: AGHT+IH2uihxq+af0Bw4QSg6xcu+H0UnlX9S7oDFhMzkHKjD6Ht/uNLkfyPQdOpfHjEdrX20JeRGkBMtlyWgD5Dx2ig=
X-Received: by 2002:a05:6402:2751:b0:634:4e0:8377 with SMTP id
 4fb4d7f45d1cf-63c1f634390mr6353105a12.2.1760946427768; Mon, 20 Oct 2025
 00:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH0PR04MB7349DA5D7A7A7FBEA8601353FCF5A@PH0PR04MB7349.namprd04.prod.outlook.com>
 <68f5e662.050a0220.91a22.0440.GAE@google.com>
In-Reply-To: <68f5e662.050a0220.91a22.0440.GAE@google.com>
From: clingfei <clf700383@gmail.com>
Date: Mon, 20 Oct 2025 15:46:56 +0800
X-Gm-Features: AS18NWA1W2hA8oKfxYYuirea0ldpm8dxKYsV0v0lAHCbktgEDiYetiMLMWsbylQ
Message-ID: <CADPKJ-60g+BtaE47GysMGQzAz9K3mMhUkzqRT-zFrnCRdFktHQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
To: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
=E4=BA=8E2025=E5=B9=B410=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 15:36=E5=86=
=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file net/key/af_key.c
> patch: **** unexpected end of file in patch
>
>
>
> Tested on:
>
> commit:         7361c864 selftests/bpf: Fix list_del() in arena list
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9ad7b090a1865=
4a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbe97dd4da14ae88=
b6ba4
> compiler:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D104b5de258=
0000
>

Hi syzbot,

Please test the following patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git m=
aster

Thanks.

From 6dc2deb09faf7d53707cc9e75e175b09644fd181 Mon Sep 17 00:00:00 2001
From: clingfei <clf700383@gmail.com>
Date: Mon, 20 Oct 2025 13:48:54 +0800
Subject: [PATCH] fix integer overflow in set_ipsecrequest

syzbot reported a kernel BUG in set_ipsecrequest() due to an skb_over_panic=
.

The mp->new_family and mp->old_family is u16, while set_ipsecrequest receiv=
es
family as uint8_t,  causing a integer overflow and the later size_req
calculation
error, which exceeds the size used in alloc_skb, and ultimately triggered t=
he
kernel bug in skb_put.

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dbe97dd4da14ae88b6ba4
Signed-off-by: Cheng Lingfei <clf700383@gmail.com>
---
 net/key/af_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..08f4cde01994 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3518,7 +3518,7 @@ static int set_sadb_kmaddress(struct sk_buff
*skb, const struct xfrm_kmaddress *

 static int set_ipsecrequest(struct sk_buff *skb,
                uint8_t proto, uint8_t mode, int level,
-               uint32_t reqid, uint8_t family,
+               uint32_t reqid, uint16_t family,
                const xfrm_address_t *src, const xfrm_address_t *dst)
 {
    struct sadb_x_ipsecrequest *rq;
--=20
2.34.1

