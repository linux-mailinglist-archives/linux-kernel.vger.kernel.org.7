Return-Path: <linux-kernel+bounces-760330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B428AB1E9A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327F0AA0868
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F481732;
	Fri,  8 Aug 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcQRiSTS"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852AB13A3F7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661285; cv=none; b=MlF5usz5FUeUb0zAYPZQFlW1nNDG9B/CKZfCC2HvOyvnaPlIbAfRxLZ/cZH0qrxnFxyN6GlJ3KXQ2QjKHM4Gzjua4nD4z8NK4XMWRE4myBQDok8ydKs5xfxVbNJYrf5hWFwMp+TLwyX4UNNfBKQf39mjofPw75jdktqKm84UHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661285; c=relaxed/simple;
	bh=o+KLbLYuZJ7+bIILdO9pY6vQHMLbC/SzrM/4WRI7UUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEEAmspQoSGV0hGRGzEhXqg80RnLFiatJ4hmD0CZtW0PTueML4pGUhboqXjzpEJtzDR4vlx9iI0DaDBtAfv4zJMVMRsfVQfycxRMURe9JoD8Z49C8XtILY836qajOa3ZAhwreKZ4X/9inYO9xmLa9vlL6uPGpFhzq6IrluFWLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GcQRiSTS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78315ff04so1784939f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754661281; x=1755266081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=moUCs0yDM2TAbGC1DYve6KzheacI5lUjhzwM2sT6dYU=;
        b=GcQRiSTSSUwX9NrIOElnIdAiYUb5WJ/VgSgAgwgr4HnXYqKhsR+s3o3rKeeJ/Y5frd
         NepFW331OYJGPCf97buQ4I+UZhZxUunLKBxqRBi/5VEFbXuHAhM2fwn7PAooNW9cHju9
         zBl57mIDspWVKeHZAuOrOf5XIYvGxf+orvb7AkdvRzbjFvDfsqW+swpNqpMfdnoLqd05
         jz6z761K2U0yH5pS1qX1qC+IDJpUZE5BP/9PcmBCb+KO6hKHfsBJfJ+IGXkZh7rfCdXZ
         dZtK7XRcNnGY37Wz59l/82CjRinhNBA2eRo9O8KrV9mmDmpK1zBa4xejaA7tYFDhFa4f
         ENxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661281; x=1755266081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moUCs0yDM2TAbGC1DYve6KzheacI5lUjhzwM2sT6dYU=;
        b=AbOC8JVPYgp+X9mHpApBosOvupvVEbgfldQtcvz/MKBq7iX+FyMeSBxVLBguLmCirK
         HuHAK507kbMfU+8Mut6EOhkshEcxkTG9kErM6yulA5wrwCmRT/01ZA4+zDTEO8cD2EgB
         mNHP2937FMFkbCy6CcoET1ltpueeXhmOSAtqqHI/5P88KuSNzTR8zOoGuol56zJ9tC7B
         KsmTHS+yUDyqhDvQFLiCnqlOoXQ4qpost9nhLtr+PUZHwulr9OMvKeDU2lMM812CCs0R
         TfUOYnpn/NiOA6rPAa3twde1c50xS/F3IluoME2fW+NS1Cz1sADaFEZp9I3Kbe+R+edN
         DMjg==
X-Forwarded-Encrypted: i=1; AJvYcCUOCbXayruy0+Mnb60MVb33l0hockST1CBiQknJfhiSl7EfLasZe4abAqvpsRC/T1LHGD0B8tksunD1aak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxckEipECn6xTksd9jjK90ZkoU5XKMJApviKL1h+tZJVzY/WRd/
	nHvsapHpWIunEYmEFIITi8wtwSNIx9qNgYgXfRdGOyMgqSZXl+VdyjB8FOMkQBY30C8=
X-Gm-Gg: ASbGnctNN7Z78wlsPWtP2i5ecgT+aHHrjzSug/YDbC9N8SZj5FV2Di1vx9/P0LSgrD3
	xgndPBWjhavKZ3/J9TTHo9w/m+7rPs2DU8SAU+CcxdWtBFZyoCZFClzbdvsVLUoEIUF1ceRRIBc
	NuLMQ98hJuquhz9P4p4S0iCj4yg/fDnkExY0CN8uJ1bx7zeqBq7mYfgblNxpvwSTROhQGtkH60W
	KkePPZRJA5vjVU8LCvwGXz6sGKk5iwm1pUA/RED9xsjw4WQhazBG+ihNOQL5+Y6r6+wa91QwAdT
	HlBV7YVJNaic4dfTvE7i9/6yYYxb1rn8XNQ8H6vbP+asFvCC2rgluwgVrEZPBq2Ifs4j0qOqiu0
	XNwA8uwsGfu6owJ1+0bHFVdVBoj4=
X-Google-Smtp-Source: AGHT+IHVsSJcpEnemEjHp7IGPVJBlggfM4sjR5uv5Ni77q0DabV1OzZ+8lZwWPntSJgVoUciTeN9AA==
X-Received: by 2002:a05:6000:1445:b0:3b7:8412:4540 with SMTP id ffacd0b85a97d-3b900b72d33mr2075950f8f.27.1754661280768;
        Fri, 08 Aug 2025 06:54:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b8e0846777sm20539318f8f.48.2025.08.08.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 06:54:40 -0700 (PDT)
Date: Fri, 8 Aug 2025 16:54:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-subdev: Fix alloc failure check in
 v4l2_subdev_call_state_try()
Message-ID: <aJYBnGXMYOzhgRPh@stanley.mountain>
References: <20250808-fix-subdev-call-state-try-v1-1-000676e46754@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-fix-subdev-call-state-try-v1-1-000676e46754@ideasonboard.com>

On Fri, Aug 08, 2025 at 11:59:15AM +0300, Tomi Valkeinen wrote:
> v4l2_subdev_call_state_try() macro allocates a subdev state with
> __v4l2_subdev_state_alloc(), but does not check the returned value. If
> __v4l2_subdev_state_alloc fails, it returns an ERR_PTR, and that would
> cause v4l2_subdev_call_state_try() to crash.
> 
> Add proper error handling to v4l2_subdev_call_state_try().
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Fixes: 982c0487185b ("media: subdev: Add v4l2_subdev_call_state_try() macro")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aJTNtpDUbTz7eyJc%40stanley.mountain/
> Cc: stable@vger.kernel.org

Looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


