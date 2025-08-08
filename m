Return-Path: <linux-kernel+bounces-760707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F3DB1EF1F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798D6586BA4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9051DF75A;
	Fri,  8 Aug 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="GAk34wAd"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA82264AD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683217; cv=none; b=AW7EHjWTbPqXcJKhwywxX1dZ1Wx4xN7BPPats0FplIi+qxAJbq/zg73GUMAdajWPFQnowZy7qlm9f13qBZ+s7CcOY/5Sue0WNBNjkhKiZJtf+yibOLAcket5bg6XSz5aYkw2ZYV+KE7zMbwSuQlq7+NGpbfQ7m7awo/D6J3MrCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683217; c=relaxed/simple;
	bh=RWDwk0BY7eOJgisTFF323CK4CoriZrYqRhbPhfprwns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEV2Msk9JwwoQDTBZbi6gNUl8UcrI5bbuM/nhpjeoWRXnzpLeF3SKOaa3Az6BzCirZUlrpTtwutHge0yxuwSraXSQpXYiAbBS2z3Es4XiOpJBirdwDD/HTemkma5VHh7UnMdy38Dy3BaSTT5NDTDSgrkH5FVAg+hEIA1EJ3a6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=GAk34wAd; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8bbb605530so2966197276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1754683213; x=1755288013; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cD+w3Sh+2S44SMVOER8I05sh4nXsPIdsd0bU2FXoVsQ=;
        b=GAk34wAd4BKltLX31cwbsmwM0ra9+F5AQY9jpP/ihTIfek97vp7137jDmZB47W+hYC
         DGWtfOe7X5iOJKLpt6jH4xKZHPX1IWwqzIacG8txPnMkbBW+dMOS3f8CWCWeZm6jNY61
         eR7stxEveoTjKiaNNkYerdRXsedkekx23HhT17qFQNkub0nDveYuFYkNw0ejt6sc7c4o
         HJI0BrkBu17dAFPb361oIKpBA0+lSFbw3E04wrE+YqwFr+j3DS6Q30LzZd1fEV0XFRi4
         LzSLrxqs6lorx+0UActD5ukvBMEysRtjEz+3YVf7xH6hw2vpLtSiB0TAbDf/J3qgMOJo
         rSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754683213; x=1755288013;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cD+w3Sh+2S44SMVOER8I05sh4nXsPIdsd0bU2FXoVsQ=;
        b=cQBJqYnnADPLeg+JBLzNtj390iVAdMOoHlK+v4jd2vzIG3VTqVDj6XwXoaqiRPLffd
         38LLVcLp19TPZqjvsJj16ODcMRIZPPTEEkc6GrQV5YrN2bng5bOEdfRmg24IFf8IsO0J
         cHINjwcAqwEy4LPY1tL8HyN7C5TjNv84F9D4sPi0voM1niNsCAN9CdCH1D81r3nVu1CE
         8zXm4T5VYqAbb7HIrFo7iqZD6X/fP2VfxwcyZgSSg36NaKMrg5tTeLmsgkUmRISxRL7j
         bLa5E748nXI2ceIedz8mbFKxcC9STx1WkdGz+H8pmciHGOfsMWbTkZADbuygFmr6yEe3
         WfTw==
X-Forwarded-Encrypted: i=1; AJvYcCXqjpJZLB9zCy5P9H1Lo7rH0M1D53RIgfXnMjETZD/eVn22XMpkFr6QQXehwNEbBYZN1oRXZOnwPYt7Lc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxlHBXNfb2cfGYOXWm16Pg9YvXNYsRNOaNel16QiW2HvA8d/0L
	RAAJcxGzKFYMGYq2hS2fqzZdfxff55VOu4xeb9mCl/Fo+IhOD/NH+2/FxLjl00onoZppNC3gJsq
	QIy9rFrveHA==
X-Gm-Gg: ASbGncvChrKNyLVKZTbaasNbhN+Y0Ap8I7E92NJtKNbiBxvvMHF5V9KMVqy6lw4lX5v
	L3LhnwLHeLGsTWZP8QcKIUA1ZIuxa+bYCCcxyOT7ABdWWFMlNdgU57XThyKC6Vy4/O8Zi3/zvz3
	7uRv+ae0ifhgXLrs4/nZT+cZMxhhiPmorM5CNHNX5P63+HlWhrjvRxCQdb42E76Ex8OjWFHqUKx
	/MryI3nUwri9301ICJ8XwMeouG4BC5MxceU+AG6bBNKWtOUuB9eKKdb8a7hu+CqKUkI0PenWJaq
	QYvjPhte6VibDz2SzoJ+a3zGgeV2pyF90TX1YeTfomSr27OjF7c1w2rF9QnYLQ+AwFJUPIHTPpN
	l6ijjPAfKGpdqcNx91NvopZVLHmY=
X-Google-Smtp-Source: AGHT+IFoJTX9kfiGv4lM2ds4K/HFAMaq5RqmEjdrWOre+bvGD6l9I8cbO0SRkLCd/9IBVh08c4Gbbg==
X-Received: by 2002:a05:690c:640c:b0:71a:2130:a90c with SMTP id 00721157ae682-71bf1c66996mr51303567b3.12.1754683213283;
        Fri, 08 Aug 2025 13:00:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::3d? ([2600:1700:6476:1430::3d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71bd5a3bcd5sm16496237b3.66.2025.08.08.13.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:00:12 -0700 (PDT)
Message-ID: <852f5f06eaa3c41e9f940defb3563e24087451ba.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: return EIO when type of hidden directory
 mismatch in hfsplus_fill_super()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 13:00:11 -0700
In-Reply-To: <20250805165905.3390154-1-frank.li@vivo.com>
References: <20250805165905.3390154-1-frank.li@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-05 at 10:58 -0600, Yangtao Li wrote:
> If Catalog File contains corrupted record for the case of
> hidden directory's type, regard it as I/O error instead of
> Invalid argument.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> =C2=A0fs/hfsplus/super.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 86351bdc8985..55f42b349a5e 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -524,7 +524,7 @@ static int hfsplus_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> =C2=A0		hfs_find_exit(&fd);
> =C2=A0		if (entry.type !=3D cpu_to_be16(HFSPLUS_FOLDER)) {
> -			err =3D -EINVAL;
> +			err =3D -EIO;

Potentially, we could consider to add an error or warning message that
informs a user about file system corruption.

> =C2=A0			goto out_put_root;
> =C2=A0		}
> =C2=A0		inode =3D hfsplus_iget(sb,
> be32_to_cpu(entry.folder.id));

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


