Return-Path: <linux-kernel+bounces-838698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEADBAFF45
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6D81C71A3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E817029BDA5;
	Wed,  1 Oct 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB7v0DbX"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C223956E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759313210; cv=none; b=JswhNpJpJxVg8pZeZqdfkfvYmZaInk6i2RzHMetMzbNcxk7zMk8coRG74sGYSGtc9oi38nCXuLGbg1XUUq472NSCE1CEENwPm5UhNPxOCCE2rVg1MhKxsYts0CKcgv/Z7RFaaT3C3wkOe7edX1ntvMeRhSX9qpwXOQlqoHGkrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759313210; c=relaxed/simple;
	bh=A0eAlzP0wEzz3JaHuHwIONKkmOFLGajjE164BPl8f2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWcRjVp44q8Oxy8is6fbc3/hGJSJRCWu3tYiEQ5tGrS9ZfMSASq8NyQpkYmY2UKWYauX3/5DMx2LsrusacZahcQqaO+WQNjQEDVSiz0oJGQEZP7dPx5wlzlGC28l00fU1haVSlqppeSPDw9WZHlbgfPHpj+cjNqrRidkPicvZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB7v0DbX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso9681084a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759313206; x=1759918006; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbDcfF/tWRYRAvRnclyW01Dt986wLv4qAlsrqnAXbAc=;
        b=DB7v0DbXW0rPDXMzw/nAwWqMt27mw0e0zs848mAqlUdzexdLk0bKhW2IGmS6WqxA2G
         6sH3O53NO/Xo2Z6U1q+CohhbkHfih11wZIIVICxB4OciefEcHzsHCkUbGzIRneT3/tI3
         FT91EaPaRE4Uygu7v1U5gt3hXD0k5sp3ZNj9+wRmOcPWF/gp84scLkGaf3SYYmX+3JI4
         lSvkSmV4o8J9sZqVD8UA+MTFt5yZ1Ua6e/F4gmchK+OUkAGpPDMZAaaKvmA8yLauYf+x
         ibivHbV8djiT/E80lSuJbVpdXsy9W1kKZym6UvGVYXPlE3OTyjgn1Xzqf5f8ipafEVxo
         O39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759313206; x=1759918006;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EbDcfF/tWRYRAvRnclyW01Dt986wLv4qAlsrqnAXbAc=;
        b=LLY/vU+mSC5ZnGdCFGXgkFPdannZFVYwPMKv1wBX7jKkNtLJmMfApdDFi7xaOxGp9s
         dB+pPBoS1QyKhAHcmO8j4BeoVt7sl6/ij6iact6sxi6ey7G2YWFpxSSma3VSW/49cdi4
         YjJiTlKKlTm9T+IWR2V7cAYCxtX3UDoC2jB3xoPkFGyzl/7hzWr0d1RasafBFTSEEhys
         EoYFN4BXNUEiZXvSBCSg/EzleltdPbRBdK4dnRDpHsBYHHGLPWn8r6mfyWo7ry0QMJoX
         kHiURTSW2hNJD/SYm206T5BbeQFX+DReJLiX1UW1zAtd3KD6G6Am5Ma5scpjPK8yVhTr
         p22Q==
X-Forwarded-Encrypted: i=1; AJvYcCXz6ihc7PcmVWz7M0KiiQWVG/3wI+MRJGa+1kQs0gMmib+Nxbt+YlDqYQBgjw7OcFneDMuXyNYzwYGrBAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfIHVl8KgumpLbltgICsB2xMclKJ5/bm1DQhv1vkXREgIjwKB
	TT5tpldVrt0+1qDqsj17FPJAyXO+dXPoTQe4JpGlf2G35xoRuaiYaUPI
X-Gm-Gg: ASbGncugPsuDaOZjTZYGNxY14r7VwTaQRRLONYHp0y/PcicLaqORtr6mcA/pjwZnguA
	FYjy7+r+8BvfEm9cZHbw5/nflFgEnGrj5dWMJYniyITF3pmwQ4162fn7sUwaivWrC/OG/jWyDGu
	+o6YKgDJNibqr5Zh7Kc0c8osyv0YERM3S/hL68dfTp3uR5inO2vu7L+qAKB1DbErv08Z9bH12+P
	eHvqQPd+QVNUsoTN9ICRkNx/cYB6UWSlcTsXeWzKDHG+C3ZCigOso/KTLpPdPJNG7rFvykjbr3N
	DSZVC8sY6teiFW+40Qs2pmwmvUbZd207rJzFxkAN1wN/qsMAGJrGEd8X0+KH0oWy5otzxlab2du
	fZB+qKmvfxjqRuo6ISsy+elEupGiIRkqCv7RhasvcWQW1YgBiSQ==
X-Google-Smtp-Source: AGHT+IGrELtWLU6PTGhg3W2iwc3fKSBGaVmLRs+pgMuO0Eh+bXb/OHBCIhInrKG21q3n+g69bj+6ZQ==
X-Received: by 2002:a05:6402:280a:b0:634:ce70:7c5 with SMTP id 4fb4d7f45d1cf-63678ca6454mr3279676a12.17.1759313205885;
        Wed, 01 Oct 2025 03:06:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629cb2sm11304707a12.11.2025.10.01.03.06.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Oct 2025 03:06:45 -0700 (PDT)
Date: Wed, 1 Oct 2025 10:06:44 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: Drop follow_devmap_pmd() default stub
Message-ID: <20251001100644.rkdaojjer52tcudi@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250929104643.1100421-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929104643.1100421-1-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Sep 29, 2025 at 11:46:43AM +0100, Anshuman Khandual wrote:
>follow_devmap_pmd() has already been dropped by the commit fd2825b0760a
>("mm/gup: remove pXX_devmap usage from get_user_pages()"). The fallback
>stub in the header which is now redundant, can be dropped off as well.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: David Hildenbrand <david@redhat.com>
>Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Cc: Zi Yan <ziy@nvidia.com>
>Cc: linux-mm@kvack.org
>Cc: linux-kernel@vger.kernel.org
>Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

