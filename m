Return-Path: <linux-kernel+bounces-860533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C00BF0568
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4C84E3234
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFF2F744F;
	Mon, 20 Oct 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQcgbM5K"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C842F5A25
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954181; cv=none; b=BBgsq2q9roUWocLL+z9waWDFAxaLp5qj4bDlyb/DAd5w5ciL4P8BabW7Lq2s6Si21GiLpw0KXmaywP0w+MkSvLhWDtYknxkmRw8usmldP8stNFJMesp2FV3T4CoeVrJ7tT86VBLuEyUH3CXJWwsvjqWsuwCjysCgVJLitEeWjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954181; c=relaxed/simple;
	bh=j2NvydwBbIPuJbatOdw2TojuRwj0GPACk41ubNT0QfU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgv8M8E8ZsU36YqMuzonyzXRgqqNKBLwjKn41V1VtT+za1RXUFS0uNc0w7tfFrL2X/4AtzlGKoHsjiciXN7ynClOSwx/G5sRPMCsRQxwYlqz/r5E5t3xJbNNlbJJrkG/0w5/vbekJWheJDTmyigvGIzMyIOfbzxGnpJYqyESioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQcgbM5K; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57ea78e0618so4834223e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760954177; x=1761558977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X82yHa6WgvMKlTJcR19kPIZKafNa3VhhrDxBxVYdfcM=;
        b=LQcgbM5KIl/oXdPTwxNujVP0xIjX+h3D3efBup5sYOSgKY2YASFAGIfBZigRCQDnkC
         klvCf1xl7ACEu0jtWOW+QtE28zBS2xlM+3J5wMpjfoLt+za1vDWxO1NjiZZuDoeWlmK+
         G9caO6GwZsXNxa1xIIhHjU8uHeWGIAZfqd1XJ+lu0N/mXHXHcPX4th6P1WLhvgo3GjcH
         DhkH9bxkgB0LaO/XeEe8usnPpSPoTL3xsk7ahNHElJFLH12+xqr/9eHukp57OomHDphI
         +4s+6MVvdRsRyzpyns+Q6c+QSkLAUtTCc8nv+1PcdXwTVRJbq4rinuoxyVrv9IM4lHyi
         1ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954177; x=1761558977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X82yHa6WgvMKlTJcR19kPIZKafNa3VhhrDxBxVYdfcM=;
        b=VMYaZKhjJS/lkELav5SBtL5UsFb6tZvUKcSupURkGUclCxUeVlZR65QddVXTGvwllK
         Bd1Kh0oVxBHx5pv1mOWBjXN0K8MY2QMKPxk+rXa2AG9pLzKpc/DmcwxJ2rkPhD3TJRR0
         hzzET4QcaLmgXWiRmOSGHSrRQbD1VCAIjCvKMAaysXhh4qc7LYJJzT6VrtlEDpcpPYfl
         nF97RicH2v7BCzxVRGCyin7Vj8rLYCCIv3tUJXGiPWyrIxRxqPna4GGF9jSgx87NsgG/
         wb7WiIOxBHQpw0jSC2jcej2GZp2PX8Ej7EfKoKyp2wi/AyucJH5gt/0gu3nYOYPLl1ua
         SonQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPAhgQ3SO1xAG7HwLjJx03DS9c1Xj4fbApZfo85KDEheYuyAXqGG+4LB51YwG88zyVQTWwRsFPKJcXuhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz//IihwRBU8cWwOgioa0BZKo+KeRlmiOGhIZww22+vNy7LTFgO
	bZ1fGnYyNg6gsw7vv8s3JFDGxO48aQXu3vZ/CwQapumTzGUJe3RaG5Pv
X-Gm-Gg: ASbGncv9IDu2XdvVOiIWUxXJQ4v+K7hMkjxC7QbGMLqQf4fekFo7OJwU29a8B3WQfAG
	aJMMfYHaYbN0vx/428MsEsgX90+H/EhQy0o/ugkfCmHXJm9/HJKH7BoqJnQb393q6ne/wJYFFFO
	8yAlRUA+q2t5ZN0ecx/yeMASIWMEoG1JOaP+B9lqBkZ9kyK/chqdhcUGViNuft8Wmt8Y1V2zTFH
	7LJg9n3wVnSsfaK6ueRXfrZrmj6JVZYW5tggIXzyiBdyQgguROXOqB1Mg1mSJeZM8iZBV/lLuVS
	AnUYIUK6QzOfmI6IB6TcyXdzpy3ycs635uggH/hq51gDXSEL6ym6L7r3FbvZCVsk17GTE+228sA
	zgY8e4h8cCZZIPWEM9TrqRUbKzTDJu5oCwrHdxLNfn0zTjn3Xj2EZgg==
X-Google-Smtp-Source: AGHT+IHuU+9CvQ9Gt1nfQHn51C/T6e1754T+yjliALLtrmrWjcnHKqMnxprnyBu97fHYVVzHprz3fA==
X-Received: by 2002:a05:6512:31c2:b0:57a:33ff:c7fc with SMTP id 2adb3069b0e04-591d859ea86mr3876727e87.48.1760954177014;
        Mon, 20 Oct 2025 02:56:17 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def168f2sm2346847e87.54.2025.10.20.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:56:16 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 20 Oct 2025 11:56:14 +0200
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org
Subject: Re: [PATCH] mm/vmalloc: Use kmalloc_array() instead of kmalloc()
Message-ID: <aPYHPmebIcGxeywe@milan>
References: <20251018201207.27441-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018201207.27441-1-mehdi.benhadjkhelifa@gmail.com>

On Sat, Oct 18, 2025 at 09:11:48PM +0100, Mehdi Ben Hadj Khelifa wrote:
> The number of NUMA nodes (nr_node_ids) is bounded, so overflow is not a
> practical concern here. However, using kmalloc_array() better reflects the
> intent to allocate an array of unsigned ints, and improves consistency with
> other NUMA-related allocations.
> 
> No functional change intended.
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 798b2ed21e46..697bc171b013 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -5055,7 +5055,7 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
>  	unsigned int *counters;
>  
>  	if (IS_ENABLED(CONFIG_NUMA))
> -		counters = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
> +		counters = kmalloc_array(nr_node_ids, sizeof(unsigned int), GFP_KERNEL);
>  
>  	for_each_vmap_node(vn) {
>  		spin_lock(&vn->busy.lock);
> -- 
> 2.51.1.dirty
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you!

--
Uladzislau Rezki

