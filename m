Return-Path: <linux-kernel+bounces-816545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E1B57537
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883DE169C02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F92EFDBD;
	Mon, 15 Sep 2025 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4LuR0YO"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A952E6127
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929716; cv=none; b=hwmv64h/rEjEeFZJsrby4faGNAPieaGGleLM0X/m3KpNsq5qB4OawnACALwF09FyYqEjq18DklSy0Z2l9zkkkPB7LJq7CvfTn7IdiWIJ39o1FzilTR8qCLXqYX9tthtA7Gi9D2bqD5aGHWxbSdtFOMf8mC3zOXYj24kzYVOrOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929716; c=relaxed/simple;
	bh=/LYSOpOOPqvNcXEEZn5XwCOqw0wWb07v6/+f7MdgBos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqTt+zlgT9nA5yEunMHau9tCc8vb622ogRYx3M+i1n6OjJnzhEnR+kbFJ6KHrIAFtE4kStlhJTIwwMeycnw2TEZNUTCytMRlOuTCutzgFlPgHamm3kGXQqZZhIcOrm9tRM3QERxx868IAcikIjt4LXrGVh4pFtRpQPQg2DjZ5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f4LuR0YO; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-62f1987d44fso2126499a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757929713; x=1758534513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fGusVWyXCqe6ZR64zsDRe9g6dv6szqe6e9/gXZqBwGw=;
        b=f4LuR0YO7vpmUv708BOaG0ruD191kjv3oOC9g7Zqr+w7AOuwrbBhxohMys+MjIP9ok
         TRfGr/sOvanku/o7em1flBmtgpfoWNqY5sOTy/dNVapCsu0Hr+Ph0LNh7gJJaNa9Xrzk
         ZM5ioFO1kl/auUYaJGV+l+KJHl7Ost1cozUJnHhRcpSwUIQsdLZbtRH/4H70BFq4oWff
         v7u6RJen4atF8wIz/Yh1UIoKXARzT+xZ/dEfZfTv1QNbeweavsFqjhBV4r6KuLO2VaFl
         iunXrMgXAzFQ+wqnabUsHL4w0oynz0tfEEaoEF99131Gmh913EGkHjRknykKVWErJ7xW
         3Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757929713; x=1758534513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGusVWyXCqe6ZR64zsDRe9g6dv6szqe6e9/gXZqBwGw=;
        b=vspOUDj5O8mdMpaEht4GWSbGw6QEUQ/s/fH8lqPGSFPigHNAW8Nfp8mN2CsMk6NooH
         ArYu3lCsLgMbc01bw5+Tozl37G6EE40i0J0I41poqeO2uD/YT5h93+4jgTNv0v858UV+
         inlz3QoH4OY3h0TH83Gz9N/5NMat9b6qpyvON8HU5WG/NHGM6+ZKLoli3+C2CfySrr7Q
         O/zMvJ7YFkeCF6GZ/dVaZPnkqCCYQm4ifuNTjQI8Co9rN8aTg7hXs46a3JQMTZ8yRwRa
         Y4d23ZdckDfBGpARRPeOcT0JriCwwFlRxPY6I5anB70nsKpKfJrnBbXMc89koriGJ0/W
         APDw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1vmvVYEuOUfPsQQy15mlgJdMLJHYIJ5DyU9wpKHqA79UBp+fHI9p83bto4SR8DQc9nUBkxTrecmWHnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQe1NHLKDSXmw5Fze9dA0YsgsRcw++cN6PoEDuqcmzkxCWJxZ
	+SsSsE/qyV5w6784kiiQRevSd2KTi3+PaLhIjmr8O9njbjM/Kd5qwJXlQ+1vHgMEVX0=
X-Gm-Gg: ASbGnctezRF9P/TSWxgOdpec6l/yWJRuDIVEUnqWa30AJ49v8zH3P5UlmiwrGiphg6A
	8AkQ36B1M5bBR3wLlFhk1pduF25vkcrVV8CJ7Ze+4hUJrXewvf3nN/zq7mhCtzd11IzL++jR3Nm
	XT+LRLeNUF/Ufyj545kdosuYE82W1hQN/ejDt6vyU6gkzHqb6Ry/Zn9App38ZYb5AJ5TYXhHAdY
	IuI8tbZX4BMP8xPe22G+E960AaF9G/F+zmRkDruMudykjoyWBGpsbjhGHVp+9BD1a+QSKLiE2P/
	DH8+OM9JqVhiRT2Sv1qzaBX29xwRyhCR3R4ly1dearJIZCJ0sUn9sg7QfeUqyyviJ+VQj5cnkKK
	Nflbf/pns36I8nQRBw0ebwlkxSMbsFLrHkBa4Ad3RzBs=
X-Google-Smtp-Source: AGHT+IF+NlznyOGggwQj3KyFsitg1+o/PgvLt2K+8mej1rfCe1KkaHTdY/LMOod7hUMEDatMyfUGkw==
X-Received: by 2002:a17:907:3c8e:b0:b04:6412:95ec with SMTP id a640c23a62f3a-b07c3554da5mr1217317266b.10.1757929713359;
        Mon, 15 Sep 2025 02:48:33 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:ab20:75dc:ab3e:bbb9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3333e81sm915322866b.94.2025.09.15.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:48:32 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:48:28 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
	David Collins <david.collins@oss.qualcomm.com>,
	=?iso-8859-1?Q?Gy=F6rgy?= Kurucz <me@kuruczgy.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/8] power: supply: qcom_battmgr: update compats for
 SM8550 and X1E80100
Message-ID: <aMfg7O2qmpKCiq18@linaro.org>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-5-6f6464a41afe@oss.qualcomm.com>
 <aMfWKobwM5bhJEAd@linaro.org>
 <3559cbe4-b2e2-42d4-85ad-554258fc9dec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3559cbe4-b2e2-42d4-85ad-554258fc9dec@oss.qualcomm.com>

On Mon, Sep 15, 2025 at 05:44:40PM +0800, Fenglin Wu wrote:
> 
> On 9/15/2025 5:02 PM, Stephan Gerhold wrote:
> > On Mon, Sep 15, 2025 at 04:49:57PM +0800, Fenglin Wu via B4 Relay wrote:
> > > From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> > > 
> > > Add variant definitions for SM8550 and X1E80100 platforms. Add a compat
> > > for SM8550 and update match data for X1E80100 specifically so that they
> > > could be handled differently in supporting charge control functionality.
> > > 
> > > Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> > > Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> > > ---
> > >   drivers/power/supply/qcom_battmgr.c | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> > > index 008e241e3eac3574a78459a2256e006e48c9f508..174d3f83ac2b070bb90c21a498686e91cc629ebe 100644
> > > --- a/drivers/power/supply/qcom_battmgr.c
> > > +++ b/drivers/power/supply/qcom_battmgr.c
> > > @@ -19,8 +19,10 @@
> > >   #define BATTMGR_STRING_LEN	128
> > >   enum qcom_battmgr_variant {
> > > -	QCOM_BATTMGR_SM8350,
> > >   	QCOM_BATTMGR_SC8280XP,
> > > +	QCOM_BATTMGR_SM8350,
> > > +	QCOM_BATTMGR_SM8550,
> > > +	QCOM_BATTMGR_X1E80100,
> > >   };
> > >   #define BATTMGR_BAT_STATUS		0x1
> > > @@ -1333,7 +1335,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
> > >   static const struct of_device_id qcom_battmgr_of_variants[] = {
> > >   	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> > >   	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> > > -	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> > > +	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
> > > +	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
> > >   	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
> > >   	{}
> > >   };
> > I think you need to squash this with "[PATCH 7/8] power: supply:
> > qcom_battmgr: Add charge control support", or move the modified checks
> > for
> > 
> > 	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
> > 	    battmgr->variant == QCOM_BATTMGR_X1E80100) {
> > 
> > into this patch.
> > 
> > With this patch right now, I would expect that your series is not
> > bisectable: The wrong code paths are chosen if you only apply this patch
> > because e.g. X1E doesn't use the QCOM_BATTMGR_SC8280XP code anymore.
> > 
> > Thanks,
> > Stephan
> 
> I see.
> 
> I was making it this way to address the review comment from Bryan in patch
> v2 about separating the compats change.�See here:
> https://lore.kernel.org/all/7f001134-e099-492d-8ce5-4122d83a3de3@linaro.org/
> 
> If I revise it according to your 2nd suggestion, would it conflict with
> Bryan's feedback?
> 

I would expect that Bryan had my second suggestion in mind - separating
the refactoring (without functional change) from the new feature
addition.

You need to add the new cases to the if statements in this patch, or you
will (temporarily) change and break functionality.

Thanks,
Stephan

