Return-Path: <linux-kernel+bounces-730624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8FCB04720
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB291A68198
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C603126CE03;
	Mon, 14 Jul 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVaYetOC"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22526C395
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516479; cv=none; b=WbkW6bdxXELbSwx0UCX4FkwByeCxCMLu0kRtpNRs+VaalIuGaq7ZJOAW+rasgEgPwa0uRCHWLRwWOS9bZ2QBXIcmgW44zDBDME2coN7SbpVGHdtnYqUybD9wzkJEDqqKEqQsuR+T2XPneeV5V7q5LMwltac5hEA+pHR/KTimKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516479; c=relaxed/simple;
	bh=4A6NEnLEDVYPdt7kptKVv8KoV4dKTNbBlfJrN4BTURI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wl4xi7LJrMfO7cvmJwT6M3QO+hhXFmgUTaKxkfPI/aU3m3bYbWN3JmfXIeqOO4wgJU+xFhlACdl55WlUd/vYvb91sr8XY9sb3roa5ju2U+R3dHvKSbsIU1kV1gkBfW7t9/TlUW6pQkB2ru7jA4mbmbzrAZxz1713iGscAwwohMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vVaYetOC; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so2569452fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752516477; x=1753121277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SkqPZJTfP/dXrtN6W5XHyA3cwGmH6cdb96S+qyDy9TA=;
        b=vVaYetOC5+3b5f2gBfpBJXEzj1MU4TY5MPOj7e9fyTXRIQvMG8NvjEKG/Js9ctjgjp
         OdYSZextreSbtAHpwp5XmM+mMn31mddi/irKpQzOLrf6hhT56ZrrX/FPVjJcUejhyEmZ
         m60CQ70v3iMq17x5fEsgWIYt8qLms0YUsR9huJ9gM36FRe23hjI0xt1n2zHfQcFcI+mt
         7au/fjk46QaCjNad/chpp73JeTsVT2m4hH7NRCgAg89S0BqZoVuhefWP8ihnsBiTO5ge
         rcRhPJO4Z5gA3gU3hYkiWFCutGKfsSBLOzDeo3d60bSDODTwD67SgkJZGkfBEuLfw1P6
         fBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516477; x=1753121277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkqPZJTfP/dXrtN6W5XHyA3cwGmH6cdb96S+qyDy9TA=;
        b=gFhI13EEmf0Zj09DTkZMI46ilFThZ3QZ+v8QjHXV4z2+/aAylD8ShMxIZGtL9bk8aL
         EamJ6aVVwHsfr4kmyn5YiBpKq381RYZZTuuaNKxGeewBHHlhYbPPm0N1uQ79g63yULQJ
         ja0mWwG+TrDd1S/67xtVtbBEBGwiUixf6QeP8nLh21XLVQgxUJ9LZpcmpSDqp/SQ3DpW
         3goTG+zarT0BOVLwJ+4N5okt31+JPj7kELPk/CJSfymJRM/qa3IGd8kkBqXrR2b050/A
         nX2nnz3eWUuKgtlZIqDJVTkKGhvGzTFehN4ssdRhCtbzUueNlKOeuqyK49T95ie5OoEz
         B/8A==
X-Forwarded-Encrypted: i=1; AJvYcCVlr6wi9z3h4dPyKCYKIBpHCQR+nSMIUBkrtetnGbiyI21O2JJB25utn6WRp8vtaXppcj5w4Mi+iuvjuVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5mBLAKnsAwRqWTdkPEKVSJ5F/mYUwLWDFSMSF4MuFmT12Bzu
	gg8jy0Xy1aLCvDvD9GzDAQ2acWA9i7NL+v45GEidCkF/znz5yFgOCZ8oQkZBVKoK1Rc=
X-Gm-Gg: ASbGnctQcz1Po5atAANnnX0qcgpB2Gn0owTMxjD5QZYFlLxcX7uEaGeksHWMn+n+A3Q
	fwpJcD/iAQsj8RQOrXJVZGbcjfJOUbHiMGBdFmxEe0kLAGayJo5btamGXRTkVo8oJP0OFlnn76j
	v/h2etc2m6TWn4owCPrG9tPGv0yd/vDwJC7YwiI/21OGu6OQcDDvz6guXebvWjwTtBklB0FCg3U
	I7YqIE/oCtKVasPsGbsdsN+oWV0A1xjV40ThwUbDvRgbk5tkizSEw/Um3Yveq6XPAkRIUCf0j0U
	9+odlUFNwN4crTYmuUFK/UynUZgDAWhvAOxG2RzxAnsu/vuxy8Sd0rCZCrYGjprgvIPqrh2ZvrM
	vuzNYDVkLMRyZ+YZx69YjbP35XXr0mg==
X-Google-Smtp-Source: AGHT+IHEpey/Ia+RCf0jqI32ZfN8fKiRgnukKmQ9MOBS/IEh6vRzjjE5dHNk9XWCsGIIN0hQXIQuqA==
X-Received: by 2002:a05:6870:6e0d:b0:29e:3c8d:61a0 with SMTP id 586e51a60fabf-2ff2670e0a4mr9867811fac.8.1752516476616;
        Mon, 14 Jul 2025 11:07:56 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf1272577sm1640198a34.43.2025.07.14.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:07:55 -0700 (PDT)
Date: Mon, 14 Jul 2025 21:07:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v8 1/3] staging: media: atomisp: fix indentation in aa
Message-ID: <1fabf80a-0172-4bcc-bfcb-96a7ab5f08be@suswa.mountain>
References: <20250704-new_atomisp-v8-0-2a8560cbd9be@gmail.com>
 <20250704-new_atomisp-v8-1-2a8560cbd9be@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-new_atomisp-v8-1-2a8560cbd9be@gmail.com>

In the subject "aa" is weird and confusing.  Say "ia_css_aa_config"
instead.

regards,
dan carpenter


