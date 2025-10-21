Return-Path: <linux-kernel+bounces-862754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01998BF6151
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D5E3A3365
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3F32D0C2;
	Tue, 21 Oct 2025 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsoM/dak"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8028CF4A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046551; cv=none; b=i3jeVpwI/A9vPZLPooSCf5qC6/IkIBiOq0YkRUCoc0fsWf22EdoRmNulQnpF9GyPOCOJEjP3KKQh/6DJDtnXIGahKBWHXJOnEXQYhUyIi6FX2P1z1o7A9q4UvTwTuMWUDgj9l5OH38JWV0aNoqylw/mGIwmEgz57iWVUIpMMVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046551; c=relaxed/simple;
	bh=v8WyGo3Y4RxKHGp7InCl285b0hOGchUITJMGf5WZlts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umLnar1XgrnribbVHOlrPJ283KeBBjTYapO+onqa17DWy85Wqc+HtmvkuYzOgrexKTDyx+XvFb/SZGLmzZJkv96MXUG4eow7gK62oJj8KnHhHrF7R8tN7h7WhTeZbPNV8Duficr0Hg4xLfDod4mPKxYKWctFOz8TLznt4l46Gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsoM/dak; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3b27b50090so1000925566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761046548; x=1761651348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kFKTQ9xP8P9jiFFOLe7mCIkwuW/VAdG24z5AEwC9Qyw=;
        b=IsoM/dakSF9Siyn3NdoIjc15KG9GAJ2231BPGLOfiHnJz/XFnB1b50CbqT+8vupnu5
         qHCsBPgkB6Eoi1tZvnJ7Lnn16ZSSerOrETJZXoFE2jQt+sCsP1XVuj2GY5Rr25jZDAl1
         CFvWR1uDLbvYFzeAYkuHgiDUd0z7vp7G3dTkGEX4joiSPEqLYE7UrsGd19yXdW2c+T6t
         D/whHYC41t2VZcGicMdi71/NiUUzFr8fj2Qxig9M7T6OrJttXnbDDix7x0pVIZH/QFto
         +sAPWF4m32PhM+sSpv9w6iE3BKb6jSl9zTEEzaHYhdagCvxfvvSnRwoM/iHPyImSdfMe
         tVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046548; x=1761651348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFKTQ9xP8P9jiFFOLe7mCIkwuW/VAdG24z5AEwC9Qyw=;
        b=Il8nc+4C+Wc6sIc/fMRY6SXENEJ8EgQr+Mm37HFdr0LahzsU1APA9UbaGplMVyNzuq
         Td9iDaHs64F/VdfW4SyoQA/+ezLLKNNia5XUJMbNwj+995Vl7nSkGCs36DnN0WZyVoZY
         XzNZ3ljeGyXMF5+YjcedftoFW9Kau91HdTJEafw8JclIMf3ZbDzkDx9hm+SF9tNFh4+g
         PBbIjfi7x7sAP0cOsv8Siebd/ACJ71em9XBE2XqqnvzDInaK8njvq+Ow/BOG9W2uagET
         +I19cSpI1NiIoQdmOP+SzgJVwNjg1eNBbb5GvQ8L13IfddSLNVBV2XSKy1HojzFjzFwc
         CieA==
X-Forwarded-Encrypted: i=1; AJvYcCWqelTClrwBetHuLqmJ294YK4g+1QJ4CgZJ9wgAdQi+8Y4pUuI3zNILcj6CTTTQcgIGteRUU/IMUXtgXzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZgd9rTWEiNkGWL2QNDBjIaWTFcaMsMJsrnMXnQ7E8Q1cEI99
	qtlDJi0xezisYPbdiIE6omLW3C9r0JZBtcuaXNyHeVLRa+vSdD+6t2aW
X-Gm-Gg: ASbGncsYQHajjqkvLRtKG+369WpbHFBdkxIBx9QClwmCAv7jYfXAJEWeuMvXskYY7RQ
	IMhiK/8cGPNiZWI0OHnUXthk07cPiexvyF98joRbr1i1zQOqx4tTQS+fE8PJKZIk5PPLKAceBqc
	58UIMFbXg0N2+pwYxeMC1g5T7yZWFmNG33yDzsEj8wEcZl6AuOb6u/gEbR/CbaQ2TGIDsK0X5CI
	zPKeGg0Xsjp93sUdAhigcL//0wVVrx83w9y1t6UGwqo0RJnzR5tAm2tuZviPLDRQm7kDINGl8Hn
	7VCz9zYePX+DjkBAjnWvnzNKozXuuYGeYl6hx/9z946fttU2XipslSmNYdkAO3f8erNayMrXL1J
	V8zeI1vIeWMu6hffsq5ppPzZebNsqRUODrUxxd0ARyyiueIMVlo2o+Xxu6HtL63ICU66MuZucex
	x4+A8Y09y5Ievbk+HGty3Xhw==
X-Google-Smtp-Source: AGHT+IGK/mt9+RIXmJq5VxepoL8ZFZHiH/fhHgPGfPvqe5SfNcjEj67rA0t+4faUs1kLVBLk/wIUjg==
X-Received: by 2002:a17:907:d0d:b0:b41:873d:e226 with SMTP id a640c23a62f3a-b6472d5bbcfmr1809122166b.1.1761046547869;
        Tue, 21 Oct 2025 04:35:47 -0700 (PDT)
Received: from ctocxl9700.cto.st.com ([37.162.48.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e838b946sm1038119066b.19.2025.10.21.04.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:35:47 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:35:44 +0200
From: Mario Tesi <martepisa@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: st_lsm6dsx: Fixed calibrated timestamp calculation
Message-ID: <20251021113544.GA256337@ctocxl9700.cto.st.com>
References: <20251015161619.GA87736@ctocxl9700.cto.st.com>
 <aO_e2DEGsO-kJQFx@lore-desk>
 <20251018202301.2680cc79@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251018202301.2680cc79@jic23-huawei>

On Sat, Oct 18, 2025 at 08:23:01PM +0100, Jonathan Cameron wrote:
> On Wed, 15 Oct 2025 19:50:16 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> 
> > > The calibrated timestamp is calculated from the nominal value using the
> > > formula:
> > >   ts_gain[ns] ≈ ts_sensitivity - (ts_trim_coeff * val) / 1000.
> > > 
> > > The values of ts_sensitivity and ts_trim_coeff are not the same for all
> > > devices, so it is necessary to differentiate them based on the part name.
> > > For the correct values please consult the relevant AN.
> > > 
> > > Signed-off-by: Mario Tesi <mario.tesi@st.com>  
> > 
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Fixes tag?  Just reply to this thread with one and I'll pick it up from here.
> No need for a new version.
> 
> Otherwise seems fine to me.
> 
> Thanks,
> 
> Jonathan
> 
Fixes: cb3b6b8e1bc0 ("iio: imu: st_lsm6dsx: add odr calibration feature")

Thanks,
Mario

