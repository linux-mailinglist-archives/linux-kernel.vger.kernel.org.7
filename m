Return-Path: <linux-kernel+bounces-831111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 071BCB9B904
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F632E5863
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC281314B90;
	Wed, 24 Sep 2025 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZHAfAYq"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC9248F48
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739694; cv=none; b=fif/wao4Bis7EkmFJ29T20An7Nrj6e2f4I8tLU4VzY3DG85BlI7yVDlnxnprPFfqAvuc662EG2ZY5bFduRWaaBi6gI0ZD4Dt6FlVg85SLsGQH5NyNFLmHNIXOJeRdSLNDGVPkxl4AsKEpDxwJDTu8cJYAib3zRgkPd3GoExRopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739694; c=relaxed/simple;
	bh=+cSLJVLKEj3BeCjUb5d6mRlp+LSIiYsL9/jVduhGhWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csWruOi3FVVG8V5L7wLRHGTLR10RWar9BZhjfNcoBms1yenOyiduT8pfBZRc258uyBsXxiZF6hAoplTQ5kiC3Vp3jZpF3u2EzK+JDeoPFu1TGWa+sFRFa+eBYDwFvVcDe5x2DRr5ug/64eIK8U/qkdPZRo/EXLpns95I5Sl6e+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZHAfAYq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-25669596921so1461515ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758739692; x=1759344492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkL6ZFw2eyDJxTR6geR0RUKNGEtDseea1wBQWsTFcXM=;
        b=jZHAfAYqh2wPNbnXSA2asFxTrdqisDx26KybOumU8OilxXaJC1F+NfIwcZHMX2GyOT
         jb6CkYBCNXknub4wyTWFCKqfQGr8vGSt4AvhGyc59+Ae0xlkApIUmj7a+7B9XpA87Yhb
         hwn7+JDGUzMhohaGdBm+R2iyHXkf2wtLzoq7WVzku9yux41dZ+7AD+0F8At6x2rll3gi
         cSmegGpBsWcCEb6mVOZYq+iPeVHLDeD+QFrpO2wQhgmjbo0tHNhuW+3JqXNQ8gzTyYyi
         6qSDd+TDoWogLi7QM/gwdo5UAyUfLR+Wqlp0gFY8HbVKq0JfxN3l9E28MhYtQMFNcVtd
         LJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739692; x=1759344492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkL6ZFw2eyDJxTR6geR0RUKNGEtDseea1wBQWsTFcXM=;
        b=eYcmUXfyheQNamv1XBJVrdY76xle1KJmoKiI3II2qsNq6+1EIKRAzdgJB6f6hby9ew
         J2SkgGRZm+RE7o7ho5nswOb4KL3ng/ye+a5abEDFfpaGr4OyLzAUl6whDiJzZx/vNnPT
         tIvGhz0fU2kFnJWLsTxM54zSK53nHKHgBuKIqhQCbKMIHneDr2uLaPSDu5jX3rkiZ6hZ
         +qWbN8uYMABi9+GMMWxVS6U8Ppi5cqWqsI4qgJ0QJI/t6Mwbm8sjVOz/xWQNzvvKBFZ4
         YfHVSHQS5TPyYSK96xY6jhCbM6g80oRUlAU2eu0o9Et4AJ+kwS9Yx9KeNy1zg7CsgJDg
         TVZg==
X-Gm-Message-State: AOJu0Yz1SC2aWgFkIuLNon3DLdGtjb/CwbhNmKw0pvf1W3kUxpnR7hDK
	Il/CHiVnR25lqALBn7hXqXeVVlDSst7omOTzZMFvqzsH+nuHhoxZDwU4
X-Gm-Gg: ASbGncuzv+i8WCvqY9d29z+7gvg+Eu4wUkLvZL3jE1J2Y2nye1mHYjP42Z6jjqKG270
	0j3b1OnunlWEh0uWiRMxFqwv2UmrGbA+XbZ55UE4Dr6ggd0+C/PT/27/ib0cN7+Gm+WUgMDrOlw
	2Psrzm5ce4qIboOxAKMMcijLJaGOlerlKG50E/vYRTPFwBu7r2mbqDRwP6sAb5NusiKgGAgInlV
	4oOQ3OlCrhSuwtMy2YScgeJDCeXkRU8G2peZwWlIfnJMlSQ8FOFl9kGqr+huISHAQMqv8ILV42K
	WDpVcBNyHOwYR7wK93Dc8F53FC/BhfF2KSn3dwbfkmf7sS5IJPSZRb++0rgEwWwixuuWvjtoNdp
	qa9sCnuAem+Qi01xPms9XGR6Iqesqqst5tfbLRtFTHqqVFWaE4TcVvlCWsKiun/h+
X-Google-Smtp-Source: AGHT+IGTxELwHOVAchfeV+Zua3SucLlubodBPLOiFSjPNAs1H57tvT0lzKr1jBAv6AHjCcpTAs5tCg==
X-Received: by 2002:a17:903:b47:b0:267:bd8d:1b1 with SMTP id d9443c01a7336-27ed4a934b8mr5659715ad.50.1758739691900;
        Wed, 24 Sep 2025 11:48:11 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df630sm198733655ad.81.2025.09.24.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:48:11 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:48:08 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1] mm: convert folio_page() back to a macro
Message-ID: <aNQ86GPdjRc2DoJN@fedora>
References: <20250923140058.2020023-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923140058.2020023-1-david@redhat.com>

On Tue, Sep 23, 2025 at 04:00:58PM +0200, David Hildenbrand wrote:
> In commit 73b3294b1152 ("mm: simplify folio_page() and folio_page_idx()")
> we converted folio_page() into a static inline function. However
> briefly afterwards in commit a847b17009ec ("mm: constify highmem related
> functions for improved const-correctness") we had to add some nasty
> const-away casting to make the compiler happy when checking const
> correctness.
> 
> So let's just convert it back to a simple macro so the compiler can
> check const correctness properly. There is the alternative of
> using a _Generic() similar to page_folio(), but there is not a lot of
> benefit compared to just using a simple macro.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

