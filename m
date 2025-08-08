Return-Path: <linux-kernel+bounces-760365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B11B1EA35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C5C1AA6E17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA152566F7;
	Fri,  8 Aug 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFxKlQmX"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8D27702B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662681; cv=none; b=ZPMkkbojSurFYidTOWN+Ot1xzJp0tH2aQ7wM5WLSapGqD8vXZ0qp/C3RFFvx+I12uX3ayShMcunpcDJLINM5GBCeddFJC5ECwd6hf6WdpX9gWWMs7uLUIMQcRo1GJlogwIpZ28vo4n7DeVtO7y4gxvVHJgKOOPCOSBeP0/jiwSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662681; c=relaxed/simple;
	bh=daIX4JK8NK3VHE7qAVQNF+gGHWpHY0OS4ETmy5cXu7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WklX9grjLCATOzhml1D/LjhrC5TuabPkKqzzfTJzTtXH+tmdz4ZwWr0Oa9yTVLBs/CEkk3lT8vHVxoIyV4JUs/xvHUoV6ANJnyyqvzkRLz3BwqMXJRq9M/OOKsh1ep2O2ejmfDNLQydi+8KBLXls+pb/jg4YtWJjcb7iIGthtRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tFxKlQmX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b8de193b60so1283832f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754662677; x=1755267477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWZABYiSs8SrBKzKqRb40mOmDVtsHcPHk62yBk6hQeY=;
        b=tFxKlQmXUPooHogoQUErjPnOEGbqw3bFXRjp5x8iPYfWJRbQ3DolIZXfX6NuHhT8tJ
         RhctZ36i3WJZt6V8Z2ChaviRmPMGow39uHNOgK6snsFx5B/SVqvx/Y55VmTy8IkBKN4I
         FDVbPEAUJIqID0MkGkgFS0hvWwg0kW8pjneyYi8fF1YqAtgjLln1M/4f93/n7QIma4E9
         JjfNnJWUqGFzOkHEiXN+7JCwhbWl2OIM0D+a2OhU3LC4NYQz+8UGMujqaL5yiLhoetqx
         OopfLoC9vNbVH9Q4MU24sVY59UMhO8nMBhbkRDkT4x4Xgp9MupVgwMCJsm+nv2rbvE+A
         uGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754662677; x=1755267477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWZABYiSs8SrBKzKqRb40mOmDVtsHcPHk62yBk6hQeY=;
        b=dL3ZoD6/t9yrGyhtvcVra2VCHFnwDmdqYnGNM3w4hclUMJOgS2+b1cRyxOiOuUulER
         /5joEbBMDvWzPJ+5eoo5z/vQnas/aU1CUG+8iGQMZEuZoPZfeeChbo+UCmy9Sz7r6zif
         TMHx/RoMzGwS67rx1/KaH1fh87g81nAQRwoXPZe2ylLaWCJGkJSekLw4uj5QRxTvjHBL
         WbnE88c9rE3KRBJYOJ7hFt7Psf8jfFw3fJukxUu+TPUIWEGm8mgyyvgctu22Qy2cQvB3
         q4OfsSen4+oKd+lJpotfoei5aaR1Atf0DsE5wSLiBvJuT0BdXU9PFoj8DJG6bfKXkrPA
         9/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCX0C2ZIGyHx+H3uKk+DeoWuZud+cSV1lJTSJFZ8I/u+DVDtmpijxifsdxJNkaTIYIyjMC7+7NUEWPwG++w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbO0bev4ErjY2edShIzRvnwygtFmLes77yt5uKYmpbKnoAfZnW
	hZS6ySn8jMA3pQ2Gu1PoEPgn5CKJbA0L3+2Ea2AGFZdX4kCEeq706nJcT9pDIFTNtfI=
X-Gm-Gg: ASbGncsYJgjScCPGly8Ic2EkGNevpQELMthI7eFarz9Vi+rCyWWP94YI8+mb4azX8q4
	CS7tAADCzjskp3rpVpGQ6Q5UXkNt8VpM0e1p5BwxfeA6EQz+QomNlFZPphn/BK9PUKTdsewe09y
	QhDl4nq7XL8AZMl+yUhvzkddAqlc/AkDIFZDTnshS53icNxzIhKjz/rb+L3GWhMR8ZU3Ai+PRWB
	ghEIBF0l0vf0Uwjob2e6loH1K8UdVHT7gJri2etT63Is+orZfLNOa41DUEQS+FjFoRseWC3d8W8
	epxsK4wb9dc6SsEmhjQEV/quqnAkMh0oEBGhF+v2loxDZdjogujegGjTvz/ssxLL7qONT9gxgA6
	uh7xFFmrQ9AvfIy1Bk0FMy2UHNq8=
X-Google-Smtp-Source: AGHT+IFPPfJMbG/l0hwg3hY9KzR9hWEGIjCDtVw/Wfa9LU/nZh+B3l1yZ8BOL2K2cF+u/tp52PSl0g==
X-Received: by 2002:a05:6000:2308:b0:3a6:d92d:9f7c with SMTP id ffacd0b85a97d-3b9009298a6mr3071537f8f.9.1754662676678;
        Fri, 08 Aug 2025 07:17:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4a2848sm30099218f8f.71.2025.08.08.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:17:56 -0700 (PDT)
Date: Fri, 8 Aug 2025 17:17:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Yong Zhi <yong.zhi@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"mailing list: linux-media" <linux-media@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: media: staging/intel-ipu3: css - possible typo in array being
 assigned
Message-ID: <aJYHECY1gjZ2xsSP@stanley.mountain>
References: <9b3313da-9cc3-4d3e-b271-05ee36736e4f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b3313da-9cc3-4d3e-b271-05ee36736e4f@gmail.com>

Yeah...  It probably should be the below patch.  The commit message would
say something like:

Subject: Fix copy and paste bug.

This code is copy and pasted from earlier in the function and the NULL
check should be if (p_pl) instead of if (p_tr).  Except that p_pl is
never NULL and the check can be removed.

The impact of this bug is that for several callers the
"p_pl[pl_idx].cfg_set = pl_cfg_set" value is never set.  (I wonder why
this didn't show up in testing?)"

regards,
dan carpenter

diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
index 2c48d57a3180..2d1c38119258 100644
--- a/drivers/staging/media/ipu3/ipu3-css-params.c
+++ b/drivers/staging/media/ipu3/ipu3-css-params.c
@@ -1617,10 +1617,9 @@ imgu_css_acc_process_lines(const struct process_lines *pl,
 				/* Inside the grid */
 				p_pl[pl_idx].lines = process_lines;
 
-			if (p_tr) {
-				p_pl[pl_idx].cfg_set = pl_cfg_set;
-				pl_cfg_set = 1 - pl_cfg_set;
-			}
+			p_pl[pl_idx].cfg_set = pl_cfg_set;
+			pl_cfg_set = 1 - pl_cfg_set;
+
 			pl_idx++;
 		}
 	}

