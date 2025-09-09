Return-Path: <linux-kernel+bounces-808509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB68B500B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A554E0483
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBBD350D6E;
	Tue,  9 Sep 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mgZLLAio"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C552797A7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430680; cv=none; b=NjutExJ7ZbN/pR3eOxSiWw3AmNcM3XOZF/jYg2D57rXnZwhLZMNuMHDYL+VwGTka+qTmimyl8wrAGaowpUIflAUNUCHm0Dsd4pqxN+rw/+DQsZk525icsL2R5dNYpOeXEcXkKjN3SM+NjtiWL82I4VNaAIfYUoaBKKTLzcX2OoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430680; c=relaxed/simple;
	bh=m6AyUSq0Z2h333bKtrZSF46HbwfNhZy6HLxgGTsSy8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edVgto8uaYWrLplAt4/K0I+Dcz0smuRWB4T7jZwYpkBPWebHaOsA3bC3zxEPpiPy2sEkzYqDZ1+fah5GqzHDYenAV9hxNz9zfeb8oZ57v8e6ZpK45uvRtv9VZO02ReKysYqf9EErzHt6P1Nw6wpq2erCsprla0EX9/QYOb0fFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mgZLLAio; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b38d4de61aso76194551cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757430676; x=1758035476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tURBG8J8o/qd06zK5K8bYxIL4Qoo/SPoLEPuSdcyLLo=;
        b=mgZLLAioYwYd77R2cxzFMKOg1+sHu70cO30HQFnBo5qtVH6BKlTmKghD2ZKZRodExo
         c0YpGSrwl9P3XGW9gCxZgV9OuxsrZDIeKDV4ek9BSL+bwctKqqU8lgxmrf8CdLvc22Kw
         5zyk/H3n0bg4Cv3rtcd+RCczUUyavSlD2SIWjYwLzO5JBXGT4NvfShT3SMsAFlxcX2lj
         3jk+jcApzcQ/B0i+FpgkrB+4+ymzo/gGoLKnrk+M8zfzABUl8p7DHJ5S8dSj0+S/bZDC
         GObASlySKO7tKz26ko24bqwmp3FgBTqRkFZeA8Gt87KUxyqLamuQF/wJbFypkoev0qFO
         IzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430676; x=1758035476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tURBG8J8o/qd06zK5K8bYxIL4Qoo/SPoLEPuSdcyLLo=;
        b=Bphpq+mUgBLUrtvEesWqpHOn4k5fRmNJiN5f+GjjrMIvguPZFveZLBnYcDhoJAJLU2
         fixpV/KD+kfvnhHvPqlqnIKAMi6LaPGlPdkIVP8fIym5juPRP45+IzWaIBC2VysQY+sS
         I8NGw7D/6W7E2doI7v4rgKuihBTrqI7Wo6f2vVWAHGJeat4jfA4lB0fwuB7zVSRgKYto
         +vatjPMuPUBTKNz5hEbCRwX+muyLnE7E9d+Q/wlM94HbatgGyA5juEFOVW0XJcqJ3IXW
         XZwkjO25/YJegEy28h/S0nyCbeVKPZdOEzAQOH8SoUs2zR+50qhF6g4JHAE4E9iSIp/V
         9WDw==
X-Forwarded-Encrypted: i=1; AJvYcCVRnOpUxkRQfQcTB8KEZlbyMA2LdiK7e4oIEGUr6s+mbPc+rPMWBPCl1Gs1ZAes97thi1VjRZf08YcZGrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSCFgW5MaaW7RPP7zkSDeFPK7cJM2VF0EUKzKll6zUnEiCYH9
	lmoTU25SHimOKPZJm8rF8fuqoN2XmyIf3Ll0RnAzurA0WJKnElUZ2dL0nPANnfbuCc4=
X-Gm-Gg: ASbGncud7I6VkUnL5b49JzDg6G11sNtu6TRdH6jjx2/p5klM0mZ4klhWR3EJJ9n2FcM
	bAztpby1HXhsomnwY/IvTJET7nVbzEsn922dsBna+ZmO6fOKNToXXdxg1hvScGSZZzL9r4G4P66
	vrCVup+0dbaea5hUrWR9I7E1rb37qabanI4s9nd32aWkPbkM5e4af3LSLu5iCH2eCltxYEoNNHq
	sY3zXGgGwtLNbHp+zd7oc0k2cwerH80y+4FdDGAw7cI42ji7xks8yuBQ5pNP1+fpowqfOdSV66w
	DP/SdC/+YBoVfqGA0IRTjqRbs5nF6Xpfn6FTyVAxbgoWTJyc9arVqtTqt9Vd174FocCRhz1tYd/
	guGgwTzeSniNF
X-Google-Smtp-Source: AGHT+IFKTzUCRKvQlrS8Ai0m7e/x5mKMWEsbS7AmLloMhvq2/uude/1VNVPNgbAgTYRvG0gKhgh+LQ==
X-Received: by 2002:a05:622a:1482:b0:4b3:bd5:e1c with SMTP id d75a77b69052e-4b5f84474f2mr123084661cf.53.1757430675099;
        Tue, 09 Sep 2025 08:11:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:600::c6db])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b61ba8719csm10336371cf.13.2025.09.09.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:11:14 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:11:13 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: zpdesc: minor naming and comment corrections
Message-ID: <20250909151113.GD1474@cmpxchg.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-4-hannes@cmpxchg.org>
 <mgt4ejjyz64ehnyskv24nzjllxxie4jvxb6i2dzlq43yev5dtu@sfltngevykts>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mgt4ejjyz64ehnyskv24nzjllxxie4jvxb6i2dzlq43yev5dtu@sfltngevykts>

On Fri, Sep 05, 2025 at 07:05:22PM +0000, Yosry Ahmed wrote:
> On Fri, Aug 29, 2025 at 05:15:28PM +0100, Johannes Weiner wrote:
> > zpdesc is the page descriptor used by the zsmalloc backend allocator,
> > which in turn is used by zswap and zram. The zpool layer is gone.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> 
> Why not rename zpdesc to zsdesc or zdesc while we're at it? It's a lot
> of noise but it's just this file and zsmalloc.c IIUC. Up to you.

I'm kind of fine with zpdesc and not sure the other names are this
much better to warrant the churn. So if you don't mind, I'd just leave
it alone for now.

> If it's just the comment changes I would squash it into the second
> patch, but not a big deal. Either way:
> 
> Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Thanks for your review!

