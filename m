Return-Path: <linux-kernel+bounces-815430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3939B56421
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 03:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D537424D30
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 01:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15351DF248;
	Sun, 14 Sep 2025 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX9DDF9B"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713C1D9324
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811804; cv=none; b=tkmAN6h6YyR6eJfOl0gfozuc0fZ+rRemzRiKKvJVJXGZNAXmHMa2xuibrbRxxUxu9/JDt0l3meXgVyrvz+9hbp72wuiD4CPckbpJPj8cC2qCTEdLaJQiutUcfmECvRqscEawjEMj89AtcLucNIduf6Rcva1erfPVCloJFA9R5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811804; c=relaxed/simple;
	bh=+9K+/N5C7IlS+WITWDJ3HV0SDwHHeeqn4hn1ZxnOHWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlJ25dz18UQgS89D9RY1xER2Um4ijQYHNLvQ0CPrcXiKMaMFyj2KSSx6uRG+3R3aehHFnwO4jz/ZOtYvaFF2auheRLJ8Jpi5P++VZqSdnaLcFiP6m/oYxIARaHMVINMBoW4lOQsnj3jCbu27wJcyhEYv9cdQEl4LkCJYxM0RejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX9DDF9B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26488308cf5so1031565ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 18:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757811800; x=1758416600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLYD3TrJnWWZ1Mr9VGKhucjc/Qr0LcMf32NCeLETcbE=;
        b=UX9DDF9B9bcdO56T4FuROtNHOVlFTEHVyjX53Vun94RC+NrjUauKPQLJ66ppA6kFFu
         yMr77nP2Ur9ntia8orUl2B0qgBb3X2gMfSAM62UZuQJt5KPbcStS0pYXh7DryL0i1rRe
         BlUrikm4JSLhO19hdaGivlMQAN+cmtJqgXKugIAyJ39NjEj8VF5vW0O4bKalXWP5bzpk
         siYekAot2WVv/ruouLs0CTYN3XQdzECCu+XnG5He9XHD7Buq7oC0ZeVvyisGVZm6I6W5
         mRYNaZt12i1IDgcitt75qsAw//QW1izMfvwE8l8tVIqpuX/QwPNZNfbOcCXFZKRCUyAv
         VzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757811800; x=1758416600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLYD3TrJnWWZ1Mr9VGKhucjc/Qr0LcMf32NCeLETcbE=;
        b=fd6MuXQDJCVBS4nIelYv5NJb+9vNf2+VKHngRz9xt/hZoIf2dAdy+i1phGrSQiOnki
         YlZ3gDtJaT8J+YLaKh+iCo1rsLbifm0+eiSnZ1NphNtgXYoQoIs0jeuhyJekOfkyHsAd
         qbN5jo4kZeDp+6CbVyYTEa1m1V/YQe9u36CeJXPdSbYCjvdbA43HF0fZDblw+cw/MmOo
         bEqyq/fUboZLEuvpIjPa9w1UOpsUlokrxbams8oFPrsUMlgVUoay9XZSO0tg3pR76VTf
         Ig8cftBU9OXjnqyqTpRVQu0+zAR2JNebFd31j1aaJX5R9tm3mBCLX2MGX8eMgPwPvGM+
         bLpw==
X-Forwarded-Encrypted: i=1; AJvYcCU5GD5WxF6d3Wl/Z0GtqSvooeRB9DvTxfgL8dRY9J4x5c4leHcdf9E8gLW1KypN9XA4TCWI+tr+N2nikkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPllm5kN9KyW1+y3maNeNuRtkuf/C58FLP/rL0hFZbCcg3ZxS
	t4uUFqRRLmd3GWGELotS7g9DJHFSfY8eGTlqVb6bPeaKoiI0HmmGieHL
X-Gm-Gg: ASbGncvnfuSpAx7zmOcftWhwob58JW1Fi7qI505QC0c4U/pfyy8dbOG444v0Clug054
	Taf7q35kI3gxTmuz2wfD47bY3soTMa8AqM23iAOAsbLQnZZycAMBthx00Q68wn59cOMqz6ihg9i
	28CnKVJlinIuQAWlh1xZxVIQVzsqZv9emdlwU86JD3cHHSJB5mLYAxzmTkGyUwClBRyZC4ogvIJ
	mscL1UP9NYXNZfFr8OQiyqSdXm0yflFnbCiKADKCuhvl91Du6HvJ0xoyPCrU4VCBCAc81UUs+nn
	+NRjmp59/ggKgPtLYZ6j+f9uNXaSY4fYe+DyZ8gndj19hK2M7JtL9jjASKXyBZrCh86KB28qX/R
	tGZSSwYNsz20m5TwW0T7f03gno7g6u9il
X-Google-Smtp-Source: AGHT+IHef74nom+ELoom0lADVTCoVjWhPLP1BEyC3csZHK36zDpwc7vILMBEnxkgb1pVFxMxGbrb8w==
X-Received: by 2002:a17:902:ce89:b0:25c:5747:4491 with SMTP id d9443c01a7336-25d26c4ab81mr99312055ad.46.1757811800323;
        Sat, 13 Sep 2025 18:03:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:81bf:abc:6590:f690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2609445f906sm33275305ad.65.2025.09.13.18.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 18:03:19 -0700 (PDT)
Date: Sat, 13 Sep 2025 18:03:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	Sean O'Brien <seobrien@google.com>
Subject: Re: [PATCH v3 03/11] Input: add INPUT_PROP_HAPTIC_TOUCHPAD
Message-ID: <h43gwyrhmyftfzhyylexxujt2w6roa6dcvd3flei2owstk5f7k@qaix7m36aahu>
References: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
 <20250818-support-forcepads-v3-3-e4f9ab0add84@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-support-forcepads-v3-3-e4f9ab0add84@google.com>

On Mon, Aug 18, 2025 at 11:08:44PM +0000, Jonathan Denose wrote:
> From: Angela Czubak <aczubak@google.com>
> 
> INPUT_PROP_HAPTIC_TOUCHPAD property is to be set for a device with simple
> haptic capabilities.
> 
> Signed-off-by: Angela Czubak <aczubak@google.com>
> Co-developed-by: Jonathan Denose <jdenose@google.com>
> Signed-off-by: Jonathan Denose <jdenose@google.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

