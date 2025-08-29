Return-Path: <linux-kernel+bounces-792539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5BBB3C55A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEBDA6722C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40792D8776;
	Fri, 29 Aug 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anS9D1Ex"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A122C11F5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507522; cv=none; b=H59LxcUBgeolY/h7V+c2M55JIiA1PS/oQqY+uY+EUhmWf2ncBGi9vvGfdkC9MgyQkjpUdiuw+G9vFMuvUvfGeU8SKcIz5GwiMQUtF0QSIJXXxNjDE0760R25h9jd/9DXNgLwO8O2AjvAYs8iGnuqYMPVCZmZ0JlF/ed1NJNX4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507522; c=relaxed/simple;
	bh=muc8ttMxCb3VH+bbm06wDGwRDA+GrhPM9zHAl1Wx1qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sujbLMJE0HRTAiYPhA1xogJ4p35gtga0UcMadFEgRBQS05IesEbH3Y1dlmFmZBgFIiqP5Ei86yR+fOYqVGLtrgPdMFCGd+j+4JY+S+7i55x+rVSxQ7CLeTrdOKL2ubKAQYMusFQwPPOcxW30mekQcVg7CrFT7LB4OuMxQxCFsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anS9D1Ex; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323266cdf64so2244147a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756507520; x=1757112320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hnmRiKmnO8mRXq2kpOADUt72izimXKC3eq1pY7iLk2I=;
        b=anS9D1Ex5ljrDP3AkaORJ9dUvff85fLPgf2Es+OwxZJTd7WAwEOuBg+LRSvqVkLxmy
         vYdmaTOwzv2nCvbLJrIqPBcJ5oBE9GekXTgSVRA1Y5eXwF65QEcXKWHpCCk92tDlJlSx
         bnmgnjNJutoTpov+hwP/VZgpZNMvfc7vYzRN0TKsLYDeFyxBmgUvEk8U/dKCJQPB6k3/
         5itNkhKS0Sh2ncEIbsgGyg6KNvO5/x38Zsbrgbq24a+VcUSiINoBLMv09Zc4t6uFmMq2
         Rqr+lTgQnUlqIWtZ5ahL5GffUVve4Ro7J4ggtuVEq9/2m5NLlSvPbebCgrgTVMxwfJ1f
         v42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756507520; x=1757112320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnmRiKmnO8mRXq2kpOADUt72izimXKC3eq1pY7iLk2I=;
        b=s6xquJribC2xHkxJEVeSaJWEtg6JxVsot+LZO2qef/1edXeJY0j/M5HTZ+KIalXCx9
         IKp8QxFwSF4P7/1L2vBrMZ15/97HWdUIqapOJBx+o4Xi78lXozNpTQSXjcK5jbnHJXAI
         /ZDkfE4GmoTG5GN5g6wBpDnt1fDHDjCmthuZyK2PQ93hiurcjDdhoDHRQE0Fd3eaXcCS
         9FyY2ZqZ3L4Z60vDq1I5qKV7A90i9r7pjAPexpe3VfyDsUNB2lrek10CssY+un/5suct
         fA3jK9LL2dxaSYE1T+hLkqeQLSKa2KR5iwFWcsuJS3yUos0OJXyZYxf3Lkhx9NEbRiAg
         +YGA==
X-Forwarded-Encrypted: i=1; AJvYcCXTJZuPs9mfPCQaOZ8hnsAccEVrGPyqQLlhVY1hmCrvqsIyHTDVnAhRSQMWWgPK+1XRrdthTjomNYkY8X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpLnJGA+0h0qvMrIY+eSYHbT28cNwZUGqssjqYDe1mRGCyvN1
	bJcZ6w1rZiC54vMZr9f0I9dBThRloyBQWiieSpLBTzUDQARObVXmPE6o
X-Gm-Gg: ASbGncv3S2I2Ad233SNGY8IZ5YafMgIXf0dlShqtfqfUsSdkBq/727ncN7dRKAe0kLF
	nqQ1FeHF9audx74vVV5lyIbO1mkBVu0eptgmBIIBHzxNR6qGiDBwuvQUgyXh/rikT1IvoaoFhj3
	ih3yfPyZKQdjdbGmKDLjw+XH+bRze6WY7XYAFLY5U4NfaWjc+KmdsFZsRXw+cO1imUtyj/9KV65
	dUBfl5g6ZCeKcXb48KIIbaPa2vuBoV//Bnwk143huRLX3+/l2qn4Qg+cKc56C9pB2DQAweUqenl
	GzJXsKXOR9nnw0e9PYsBOdqoZCkCyz5OBLgp6fPFZDc8P4DxVEqGTpcWtMG+q/0jUYvZ8IdXk6L
	bukHAsdoyIFrXfq4oH1lXdMeL+8x7fL73F7YF1PcyNcxl1XNKbhIdFSL8KgQJWMIy
X-Google-Smtp-Source: AGHT+IH/XyNiqyFvV9G2vg1MeM+kl/ZTomOhVw22QI/u4Pt0TfDvevpMigq7Bp7n6YjaCOuhx3U/hg==
X-Received: by 2002:a17:90b:1848:b0:327:96dd:6293 with SMTP id 98e67ed59e1d1-328156cb806mr430413a91.26.1756507520240;
        Fri, 29 Aug 2025 15:45:20 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327daeee5dcsm3750565a91.29.2025.08.29.15.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 15:45:19 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:45:16 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 01/12] mm/shmem: add `const` to lots of pointer parameters
Message-ID: <aLItfFlYHFouVt31@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-2-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-2-max.kellermann@ionos.com>

On Fri, Aug 29, 2025 at 08:31:48PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

