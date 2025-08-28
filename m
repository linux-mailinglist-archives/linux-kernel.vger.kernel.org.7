Return-Path: <linux-kernel+bounces-789345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED58B39419
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70ED91C226A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806D1E51EF;
	Thu, 28 Aug 2025 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RqLIxVH9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98EA27F754
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363550; cv=none; b=LdGJK6bPM/C22i9fgALD/c8pWOym7h5/jTaj9ZLk+vpaPCXjNK8Z2qwo5RI6YwAiWWy+fWjVaR5wbsBlwqeYc+wQ35CGjTrWO27IC07a0pDEaK8QNv30YNTedp1hMMg+Ixsqs19DTFTo1OUMDJDJmCJN5ayLiajo1S/72BDXyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363550; c=relaxed/simple;
	bh=62NYP54Cna9w9dH1TLqnOmtFUzq/oX8j1ZPnt6KXitg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXg/CZOU1TzOYvkyO3Ft6gfDHIbuuAwa0NILQw5sQsNWfbM0WpJ287T5lJVCF/8doOPpjEXioVQojlGA5ihzmpgOxthTpuncdTWnBl/EAc4TvlTNON/xnCza9DPSVnmWT8L7EG/IweGjtDXOBiW5rRcNgkPyF9K5/IuW6rXEbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RqLIxVH9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so2791955e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756363546; x=1756968346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knemHQZ23pxIDABlkjX6mLqLtGGVNS33kJ89XWuOpd0=;
        b=RqLIxVH9Jm/2q1AyaKiUYe1FdIZrWpO8zrA+cF/G0iqpzj6sIq4mqPOmi9CgO9URlf
         QoydTFIUsDJkW0Z0HD2GGixY60ZJ5myhjujeuZ66er5mjDvJ3vvKmAgG98fHvRcAAgz6
         q12vuDT3GjKGAa2mastf96Xry2GtwJyTaLrN99cm/cODeQf5AE7o9mLhmx6smWtfE3bl
         +1YrEcVQOhkEm2Gv1dHqY9fYZuk0yN/nAuN+7SfN2de4tlnJrKu7IAbbvLJnXw7hWrU2
         EYXgqu1RMxMUV8s4Lvikk6ThH4IjQVK1g9sqXtbVbIawsJoTAPvjl+H5gny4q4uivOQp
         ARrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363546; x=1756968346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knemHQZ23pxIDABlkjX6mLqLtGGVNS33kJ89XWuOpd0=;
        b=ikVaVxvczkoW9k6LMuTH/sPtBK+wNNtJwNTTZAJ8ELC7Ybr03fM1RZ2colZKKIUbvW
         +Jc2cByvAbtJPCByWXXB2Tc65QQSGPsUA16pZuGHaIDrDrNitWRfE7GvsNYwJ/N4+tej
         aVTub5uwW5gRWo6N2HA5ClkVLp+91DFY0Zq96PEudPLHBo0cGLCg5fv52D0G34eU95TR
         N+WAV3kifKetYmF4VXYoldhX6hMrRmgpQNQ3Zxo9Os9uw+OwfqIwTS03frb+holyT+Dd
         Bhd/Fs8Xpf0F2oIEQLvWCj+xPhpJjVMYwRUXQYJNaRLUZ+1blVaAZfZ9r85Fo/k+N33m
         M3ew==
X-Forwarded-Encrypted: i=1; AJvYcCVbDJegG7olp0PwLJsHmDiNabsK25Rp64Ms6WMru93E1VnGtT0BpSWwUKeofTJCHundwyy9f0fq07ldcjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhfdxd3SOyTY9umKmUXpW6nroCFH36HdAd7FbN2/trTWgzn3ZL
	y7OGrfVPhmPm1KB9z0h9hAYxYLtc0FkrujowDMQF4mxWnW4zImrzQJ5R5PREQFwy8LE=
X-Gm-Gg: ASbGncu97nn9A0rVl2TFGprsW0fMre9xvXLG4Xjyhq+8BwTlCkRY3RlC1jBD2bEtbmk
	PYyp4z58qYupKUUGUOqhZxIpP+MiIjKSqG1OicspKdg2qqMLlAiivKCfx0oHaQ7NUJ0Ejcb0EmU
	YKTFfAOojzHa6amXXQwZGEOwPtQF2jUHe60z1xrUQp8jsP1Lpj36NmY61zSAGqGXujaRChQG8jr
	3Ym2UE15npMybSfdvRPsPfpplarbtbOiCU+/OGY0WJavc4fCy3gnq0we9iqTq5cpCimZdIYgpVw
	OFmpfiYOQAZz3J5ZNvfrJifPZH23souPIPk+AutirYMbEj6h2dkPxs57F1gF3qbH9M7ucKPd1Kw
	QyccY2DOHQRgNyIncbaQXCIQo3ScsxkRPb6K0b+nbh10iPg==
X-Google-Smtp-Source: AGHT+IEzVCb/sPwnrBnjP7P0WHlUWm3cB4aF8du8T7+csVrDJeE5Tu9GjnX3DSLGMIT4YnlpckMapw==
X-Received: by 2002:a05:600c:3b8b:b0:45b:7951:92a2 with SMTP id 5b1f17b1804b1-45b795195c9mr9624715e9.18.1756363546098;
        Wed, 27 Aug 2025 23:45:46 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b66c39f72sm49159435e9.2.2025.08.27.23.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 23:45:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 08:45:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: Weilin Tong <tongweilin@linux.alibaba.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz,
	surenb@google.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com
Subject: Re: [PATCH RFC] mm: Use pr_warn_once() for min_free_kbytes warning
Message-ID: <aK_7GKJ4BWjye4tZ@tiehlicka>
References: <20250828030602.204332-1-tongweilin@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828030602.204332-1-tongweilin@linux.alibaba.com>

On Thu 28-08-25 11:06:02, Weilin Tong wrote:
> When min_free_kbytes is user-configured, increasing system memory via memory
> hotplug may trigger multiple recalculations of min_free_kbytes. This results
> in excessive warning messages flooding the kernel log if several memory blocks
> are added in a short period.
> 
> Sample dmesg output before optimization:
> ...
> [ 1303.897214] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> [ 1303.960498] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> [ 1303.970116] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> [ 1303.979709] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> [ 1303.989254] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> [ 1303.999122] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> [ 1304.008644] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> [ 1304.018537] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> [ 1304.028054] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> [ 1304.037615] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> ...
> 
> Replace pr_warn() with pr_warn_once() to ensure only one warning is printed,
> preventing large volumes of repeated log entries and improving log readability.

pr_warn_once seems too aggressive as we could miss useful events. On the
other hand I agree that repeating the same message for each memory block
onlining is not really helpful. Would it make sense to only pr_warn when
new_min_free_kbytes differs from the previous one we have warned for?

> 
> Signed-off-by: Weilin Tong <tongweilin@linux.alibaba.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index baead29b3e67..774723150e5b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6412,7 +6412,7 @@ void calculate_min_free_kbytes(void)
>  	if (new_min_free_kbytes > user_min_free_kbytes)
>  		min_free_kbytes = clamp(new_min_free_kbytes, 128, 262144);
>  	else
> -		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
> +		pr_warn_once("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
>  				new_min_free_kbytes, user_min_free_kbytes);
>  
>  }
> -- 
> 2.43.7

-- 
Michal Hocko
SUSE Labs

