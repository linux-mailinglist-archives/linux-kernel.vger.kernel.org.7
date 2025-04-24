Return-Path: <linux-kernel+bounces-619116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0991A9B824
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 21:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DDE1BA0730
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3219928E5FB;
	Thu, 24 Apr 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="uzCRcGTQ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07BDDC1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522252; cv=none; b=l6x/tGJSqFRE6+auFkOeFetzNIVj/lS+JPo7RuxNEbCqGsuWVFAyFfB4e+2oh68R2c5sMbasyTm64rpM0OeijUNGQekpxeFIG3MdYi2PjWo1lDxfLE8HKCi1M8MChUTdi4Qt8WvzGtHIIkcfG3qFAfiP3+wI7VsrfsFGmvbxJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522252; c=relaxed/simple;
	bh=WgkJ7dNx72+BXbWCJgltCrdHxMR6F5quAng7bdlmKzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPxbDoB8yHv0cIrBYasWmVvPourH+/NcvORPWOZTuaPj3X4yQCFBhB+HR0yiIpx6y+YTa0P5u+AzFQtEdoYPKRd7JyEGSUBPDLdGTW+xpZ8vLvAnL0OXz2WveqTKtqZjCe0ZPL8eVDsH1livUCRfnGJibEY2HkI1TrVGgfXFQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=uzCRcGTQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476805acddaso16599251cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745522248; x=1746127048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgkJ7dNx72+BXbWCJgltCrdHxMR6F5quAng7bdlmKzE=;
        b=uzCRcGTQmyivph5nUnlqtY0g5AFI0S79Bczkp7Kf7zWw+5T5IjWwFNZZ2XAlZEN5cQ
         +v6uwj7XkdUBaZ4Wa3KizFAGX21T3AVgcigXgXzyepzd9ghM5dbzUWRK7Vgeql1M7BN9
         wZVMN060S6Rfv6Y9gkVyfVmBRvUH35hFxCC10/mk5msvR+p19saXdoUi0iwkx4qkz8o/
         BSrcR5/Z5UHCj5uI3GO+8Wz93VkuCT59/DSda3KqdGXxS9MNvAg7dxh59S5rSKzPUPgU
         pnrvtZpq4c+7Xu6l5JbCM+pQvb1vwuYm6NmrBJDd8+74P+IjzhFSyrUfmhR47wrGJg8y
         odoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745522248; x=1746127048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgkJ7dNx72+BXbWCJgltCrdHxMR6F5quAng7bdlmKzE=;
        b=Qi/EKx58CYY1lv5iJE/Muw+As2Nj1LyC6fKP/MO82DNgKpfk/a9EWmetPKtuU8GcZO
         VF9COf/lIK16AKmY7Ugmjeh+d+YTCVZZrjrhNdlXP5uxUpSXcJlbASBUAdCYRYA9mA5D
         RXXFNR3D1bx1cvatoDl84Q2ubCF5xMGgbXpCC3s6J0C6yjjKIcEetK8kFk70dCwOt3rM
         wOXRILceJD/tss0uAt09EWFH9beVi4oX/hAwnMDqXzn2MoCecUNypb5nyfh8wTF3H4Hv
         2DPXuBYfQQxMBHMu9EOC+bkJdnOhdRKFpoxXvDRii4yLmjkHsQ5aTCI1SpVit4Iesk2T
         Y4fw==
X-Forwarded-Encrypted: i=1; AJvYcCVgRGN2SRdsAbsAGZOL3c8nfJwoac6C27+Xfr0NDHXCSieERQc4WBgegjW/lRlU/PX6OHxnQiaotxhCzgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvmgX6Y9DaTuE93LuADRE/zOid/O4RXmW2Nf822ti3dQUk/88S
	FX6ghAptQ0rpOMtvOqHGc6WUfOQ76LolKDURKNupXpsQnqdWmHX9UP0qmlp/Y0A=
X-Gm-Gg: ASbGncvRqElBnJivWL56wL1hoi6YHMWk6EfN3bfcZjKLzUCLg0VVeDLKLGuMZo8wGaw
	ddZiejt++XoxKdNnydfw2XS2sUvZsyK9BtLrmFSd9h/OdvFJzhBASxfulPsH8wFRRd6uPlVgaLp
	f7k9Ca88f1G/1YJCCUD0yT0v/GDGIaPVSl4Pf4k5KbovfgjisQ5mxbaaua5THCNnuXX7CgZ+0mp
	zl/WIfFYcvLDXmIxFJtQ7EG2cUIf8XzUbXuQI+t2bSdjaF8wcKoOnP/5oxb94yit29XV14zKWDB
	EzIOJ3v8tkGVvz2A9pXXwVOgHJQEl0EVAztMjKc=
X-Google-Smtp-Source: AGHT+IHkyRBu9V6NCZ7c0WkZtU097BjmY/ViJB8SmesavAH39ZGN0trFmtrBbF9fZcBHK3K5PdeAnA==
X-Received: by 2002:a05:622a:1903:b0:476:850a:5b34 with SMTP id d75a77b69052e-47fba29aab6mr14594891cf.30.1745522246432;
        Thu, 24 Apr 2025 12:17:26 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47e9f7a8326sm15352661cf.37.2025.04.24.12.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:17:25 -0700 (PDT)
Date: Thu, 24 Apr 2025 15:17:22 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: workingset: Simplify lockdep check in update_node
Message-ID: <20250424191722.GC840@cmpxchg.org>
References: <20250421-workingset-simplify-v1-1-de5c40051e0e@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421-workingset-simplify-v1-1-de5c40051e0e@suse.de>

On Mon, Apr 21, 2025 at 06:16:28PM +0100, Pedro Falcato wrote:
> container_of(node->array, ..., i_pages) just to access i_pages again
> is an incredibly roundabout way of accessing node->array itself.
> Simplify it.

Agreed. The other side is shadow_lru_isolate() which goes also goes
through mapping->i_pages. That's probably how it came to be. But your
patch doesn't make that relationship any harder to understand.

> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks

