Return-Path: <linux-kernel+bounces-797200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96481B40D45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D311B6606A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291434574E;
	Tue,  2 Sep 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSHBAPEa"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F77A95E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838319; cv=none; b=OCqc+oAJMgwE208qvqMG8lbpXoI1KUIfif3gT2TOfXfZZHco5mhbP1tNa7vVz1I+DiyR++d7SttTt6WolK4eGE1f0810RrSXJveF0/Q8Dc06YM6O32TngMEwqFDyD/Lodi7s9lvx7m43ulyk2/7NzlHOnQVthYLgYJapPa36IyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838319; c=relaxed/simple;
	bh=v548S0d/xPO5C2+As6FEXaIbPCftKbrXlzxHb8LWVbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spvqAlUIyeVXtvY/Vb1/RTwfU+RFDoWywezeahEtCM4etLxTybGqiSHVEahQBe4VBpfeL0qXYguxUWVu5tA3UyZFXUDDFCbG9t+LYzflrGd3xWBb/3GOa9Xk+ausy4aj2zUwH5YD+101TOIuMkpK1p/3Wx4VS56ljfG9B8zLNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSHBAPEa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b87bc67a4so21290755e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756838316; x=1757443116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtIfgKLp3NVc3pSHlMfWF5VgNgJuRmHDA2CEfhOQ8+E=;
        b=BSHBAPEaZ2HXZJ3QA5adsiOWU1sEZKHJjdjTBGceq/Zv/N3tpQiN/QT/WN4Dl3xlV4
         AcOlIykCKY8Q1iw3hwPjHIfNRU6kxnuBzIphFiihyoc/riDdrODa0xmuj0bNQA76w42P
         0kP7HGzCzN4uvbZ3xdAQxFz4IO0tJr/T31YpkuYrp2K0mCRj8u3FmWwCD7MvndJ1pL1d
         0P9/eh51z9cRV/Bg/Cw+sZIONF3DKpDCGaPj0Y6EE687h3sB1NTuizE+ZMIhHjyZDNg/
         J9qNQYxQBSD2B9PBnMFSr6TSEe1MJ1hgui1X7E0feeiSRfSyrS7vseHROX5KiCBRA5G5
         fE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838316; x=1757443116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtIfgKLp3NVc3pSHlMfWF5VgNgJuRmHDA2CEfhOQ8+E=;
        b=PR2cMYtLK15Dp+WTUjLvmV4qAMkj46AC934pYxbRSk/IihQ3S0NXgwyvc46jU5DnMy
         LpG06BzCzTJ/hU0wiXOQe5QRbjTBKiEanqwnFWbjil8ai4yF/h9GvP1QNoIQplQigJe/
         /00IhtyJW0eVkH0ROsAcoIicU6bf37BYGafDZKqa1mHgqF8dXDrRpGnljGpsSGM46fyb
         x3DXWs0q8pc+4EUYwzP8XUqjla1gya9s2OJWnGIXIRAhZjvD9DZR7t52jZuisTsOvl0r
         Yg7BLMp7SLgDNhY/iR5nO2/VpR6YqBqKZKJNh3eKn5KGxUeGaaTYG47zdsWzSlZqnSJ5
         lbfA==
X-Forwarded-Encrypted: i=1; AJvYcCXWiBfTau94KOtkiaMcabjbofH5tM16EZGjJHfgCEZ0ezHJxJ5mJzhH9vIlTvDCIEHoJj9i/uCcOc+SnCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztAFzfXFkPHdyzSBhu3SHJcOZ72DIQEp3tjQPauwPyvOHay28u
	dWAa9zlidPDpbsajMbtQ6JhznGw4pXI679LJzW6O0u5VBiHnFAJu80Ab
X-Gm-Gg: ASbGncsqRv7LHph3u69E7xoNwt0IhBf2HwFgluqD3M2j50wywzdQxxB+PdGq6p4AmGR
	ao1CSu8O6ZycJHU5QVbSLChl47DYvzqp1CGa5iJ3G090zmP3DlY1rS4XnzdOtqk279P8d1/vwsL
	QlINAhx1FF3xOGXGFjwelO2WFWRLsUxBZuHwVQVMghFOoKszW6Gat/n2AgVa39gwzedigp1ReXp
	z77jm8L7kcGPq4VrZW+CxDSBZmoAnRtPoOxKWmnCOUp07qF98BBJcsGRfOi9Lckd4EikYBudMaV
	drQmkony07f+XboLO+Yf6KLmJkrEdeaCTfVox4sfEAzWH1fJeH36x7FMhssBXAJDIBSW9pG5F4u
	RzVjD4lL8vEsrYHwYqnm8gG48S+m7AuYwZVMVHQ==
X-Google-Smtp-Source: AGHT+IFZOtGXHRvSGQGMQlxqtMFkysWL1TKTqsEmVYhRZ84LZTFvZGmQrrRX0tM8g8SIZ1TNTU5eUQ==
X-Received: by 2002:a05:600c:46c3:b0:458:c059:7db1 with SMTP id 5b1f17b1804b1-45b8557f254mr116499635e9.30.1756838315255;
        Tue, 02 Sep 2025 11:38:35 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.80.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b85090262sm157641835e9.17.2025.09.02.11.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:38:34 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	flaviu.nistor@gmail.com
Subject: Re: [PATCH] mtd: spi-nor: issi: Add support for is25wx01g
Date: Tue,  2 Sep 2025 21:38:18 +0300
Message-ID: <20250902183818.17415-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mafs0cy8aw0yf.fsf@kernel.org>
References: <mafs0cy8aw0yf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi Flaviu,=0D
>=0D
> On Mon, Sep 01 2025, Flaviu Nistor wrote:=0D
>=0D
>> Add support for the IS25WX01G 128MB (1Gb) ISSI Serial Flash Memory.=0D
>>=0D
>> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>=0D
>> ---=0D
>>  drivers/mtd/spi-nor/issi.c | 3 +++=0D
>>  1 file changed, 3 insertions(+)=0D
>>=0D
>> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c=0D
>> index 18d9a00aa22e..e4997f9bd557 100644=0D
>> --- a/drivers/mtd/spi-nor/issi.c=0D
>> +++ b/drivers/mtd/spi-nor/issi.c=0D
>> @@ -126,6 +126,9 @@ static const struct flash_info issi_nor_parts[] =3D =
{=0D
>>  		.flags =3D SPI_NOR_QUAD_PP,=0D
>>  		.fixups =3D &is25lp256_fixups,=0D
>>  		.fixup_flags =3D SPI_NOR_4B_OPCODES,=0D
>> +	}, {=0D
>> +		/* IS25WX01G */=0D
>> +		.id =3D SNOR_ID(0x9d, 0x5b, 0x1b),=0D
>=0D
> It seems the flash needs no special configuration. IIUC it can be driven=
=0D
> entirely based on SFDP data. In that case, I don't think there is a need=
=0D
> for an entry at all. The generic SFDP-based driver should already be=0D
> enough for your flash. Just add a "jedec,spi-nor" node to your DT and it=
=0D
> should work.=0D
=0D
Thanks for the review and the explanation. I now see in=0D
the core driver that spi_nor_check_sfdp_signature() is=0D
used if spi_nor_match_id() does not find a valid entry.=0D
=0D
>=0D
>>  	}=0D
>>  };=0D

