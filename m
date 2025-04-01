Return-Path: <linux-kernel+bounces-584111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE38A78359
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 22:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5303B0851
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B402147E6;
	Tue,  1 Apr 2025 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="inHuRNot"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E72144BB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539568; cv=none; b=jda+B5WYhupzfm73Xxi4exJOeqB/xriaA9pfP7Sy4NxDZKd6yONseIwYLk1qtOjdX+KQnjsL2Cc/WDeIydo5XHIIMmqQz2S50TSa12Yq6nFC5QNgnJovXOdLAj3I9nmVs73tL4YNss/wq6ghk6eUjb4AylICBqZNi8bVsLktyY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539568; c=relaxed/simple;
	bh=pCaY5QEecOZqAQfBEWo/AS6i+E4ZJukp97flbZFbee8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+I1fyP2WmADEOK874RmWF7f0RM+cZ8101ajpbmX5oAe0P4zh+HxWzCEQon6oIzkJbNEgt6wz86FqQTj2NJ2i9oQ3qYVwJ+AZW0xkRQ2tG72IYY3kYDV+uo4/aTsF87HbnlhQ1UZ3/Ecj2Mg7VIHxISltsODTZ3g+OWlx2AG+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=inHuRNot; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c597760323so502097485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 13:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743539565; x=1744144365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2k6DkQdvevUPrjABauEbFK+K8GOAoD6LcLNKG6lEhw=;
        b=inHuRNothZXbXdyQR3dzjei0Y3eMbXZWE3z/bfPENG780108hlOmPomvGCvk7mr4h0
         EPeWNhLuHRNLZuSQDopnaZ+XBAWH2chFLep9hEUjLgm3GH1oV+uBV9IxSDiLyMOcc9Zn
         1Ad5ZoPWaXw9sF0/5TqfTU2FKx1Qh+KqqE0f48xpIWkMqPR4zWvC7frGlBEwtnc6s2S4
         h0y8XAj26P3nGhqEND87X48uexb/2ajP0KSRec/jHhSRFD0hWW+xsTDygO/+8Py13kRf
         16OFgWtJpxE4kliBSLUDrS4Qoo034STuLylw7VaaniW4zhq59GpYN0b6MWW1DIQh8QrJ
         W5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743539565; x=1744144365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2k6DkQdvevUPrjABauEbFK+K8GOAoD6LcLNKG6lEhw=;
        b=b/pvX/CAweZBudmU9bgWfbnEu/wZLKiLMvrwx+ilW3atk+87Bl8KsFIbfG9dhNlbrl
         bU63sYQ512RGcKMVG8wl44yqCAUm74BKnOQH5uIC2dU/cKlOsxT01bzoSFoGsJYzCGGy
         nWVdIzgNHJmEHW4KWKohbkqi2YWlWhcRwgSWIrkFFl4ZlKGCD+nmtpF0l695CSQkQZhf
         kVsx2PD3YZ1Tar/1/NRMKWlEK2FG2jIChDS4LP+0MXKNuBC4Ey1o2+2+ukU6R5plaqGZ
         rJHMQd4RGHfV6+XPfKG/xlXY1C7aTJo4JyylGcbEGmY9RFD0iG7mwgkhvxgpmwlM+B3V
         Dzrw==
X-Forwarded-Encrypted: i=1; AJvYcCVwmYd//Orf14+f1h6tdTqimqSrTgaQK7agZdffaL0VAGkWjRcofhlPrkBR+trGg/YpYG4iEIInwagVsys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhB8KLzv2YPreAKjZPwbGHBKLSWoEkZIintVOC7Vchdhn38du
	ysclIv2Nve1TspEbGfZH5UprAey1zppqrUTGfY+HpUaThW6lP9e9jYknTX6unCY=
X-Gm-Gg: ASbGncuXivDURICQPKAkOHUndtPSI00+th3lhMazn5Dp2UVtzwQWswgLj1waPsT7WMB
	OSPv/wo7OiIonBV/WpLee+TIpFvdS1hnjPwKh0tZaJABXpSims4QNGOqwY6bM9Fh0gsRAEzdph7
	TaP59uCjcBadsgON270zel/KyOjrHAf59vSzvIwN6fm7xsXk2zSNes84hqbmix5F8V7H44KSmCh
	VBN8LpxE4WBYGggQkH1tDSt7KDJkDEDpC535wLWkyeGE2SmikzMLiq5G0fhAsO4UfVjA/1zBjeC
	hHf/a/ZpgNuLy/jkKjqi+kPnO8MQiayoOwodOe2qhRe9FDpttOMWQh5QxYnnPTG2UT5j3GuDDxS
	8FYrUGBYZH8TeF/Nm8/hxhtETcuc=
X-Google-Smtp-Source: AGHT+IHpA7yVkggd3SdpJmClfh3ARTdnupmvQOiOUgl5sud+yDFv7RLPVDRHK/OJg/kxrXh83AnMoQ==
X-Received: by 2002:a05:620a:1987:b0:7c5:4949:23ea with SMTP id af79cd13be357-7c7664efa92mr930285a.47.1743539564817;
        Tue, 01 Apr 2025 13:32:44 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f777d700sm701590585a.103.2025.04.01.13.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:32:44 -0700 (PDT)
Date: Tue, 1 Apr 2025 16:32:42 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v4 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z-xNajhtWgdhT2Jo@gourry-fedora-PF4VCD3F>
References: <20250401090901.1050-1-rakie.kim@sk.com>
 <20250401090901.1050-4-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401090901.1050-4-rakie.kim@sk.com>

On Tue, Apr 01, 2025 at 06:08:59PM +0900, Rakie Kim wrote:
>  static void sysfs_wi_release(struct kobject *wi_kobj)
> @@ -3464,35 +3477,84 @@ static const struct kobj_type wi_ktype = {
>  
>  static int sysfs_wi_node_add(int nid)
>  {
... snip ..
> +	mutex_lock(&wi_group->kobj_lock);
> +	if (wi_group->nattrs[nid]) {
> +		mutex_unlock(&wi_group->kobj_lock);
> +		pr_info("Node [%d] already exists\n", nid);
> +		kfree(new_attr);
> +		kfree(name);
> +		return 0;
> +	}
>  
> -	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
> -		kfree(node_attr->kobj_attr.attr.name);
> -		kfree(node_attr);
> -		pr_err("failed to add attribute to weighted_interleave\n");
> -		return -ENOMEM;
> +	wi_group->nattrs[nid] = new_attr;
> +	mutex_unlock(&wi_group->kobj_lock);
> +

Shouldn't all of this
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> +	sysfs_attr_init(&wi_group->nattrs[nid]->kobj_attr.attr);
> +	wi_group->nattrs[nid]->kobj_attr.attr.name = name;
> +	wi_group->nattrs[nid]->kobj_attr.attr.mode = 0644;
> +	wi_group->nattrs[nid]->kobj_attr.show = node_show;
> +	wi_group->nattrs[nid]->kobj_attr.store = node_store;
> +	wi_group->nattrs[nid]->nid = nid;
> +
> +	ret = sysfs_create_file(&wi_group->wi_kobj,
> +				&wi_group->nattrs[nid]->kobj_attr.attr);
> +	if (ret) {
> +		kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> +		kfree(wi_group->nattrs[nid]);
> +		wi_group->nattrs[nid] = NULL;
> +		pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
>  	}
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Be happening inside the lock as well?

> +
> +	switch(action) {
> +	case MEM_ONLINE:
> +		if (node_state(nid, N_MEMORY)) {

Hm, I see the issue here, ok, this node_state check isn't needed, as it
will always be true.  So this function needs to handle duplicates still.
                          vvv 
> +			err = sysfs_wi_node_add(nid);
> +			if (err) {
> +				pr_err("failed to add sysfs [node%d]\n", nid);
> +				return NOTIFY_BAD;
> +			}
> +		}
> +		break;
> +	case MEM_OFFLINE:
> +		if (!node_state(nid, N_MEMORY))

This check is good for the time being.

> +			sysfs_wi_node_release(nid);
> +		break;
> +	}
> +
> +notifier_end:
> +	return NOTIFY_OK;
>  }
>  
> 

But really I think we probably just want to change to build on top of this:
https://lore.kernel.org/all/20250401092716.537512-2-osalvador@suse.de/

And use register_node_notifier with NODE_BECAME_MEMORYLESS and NODE_BECAME_MEM_AWARE

~Gregory

