Return-Path: <linux-kernel+bounces-827781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48184B92C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16B4442288
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748831AF37;
	Mon, 22 Sep 2025 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUQQxhfy"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87E2DF714
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569329; cv=none; b=TLHJxu6I9ia8VVzpE+bWkuqzCk/ygHcuS/OsooO9C7pKLJMI2Cu/7AJ31if+rN/S78hnCPsd5q1Mj87Ni79ExnBsuuP5JWR5gFxM6DWcK0E7ZHmZ4NhsqdLh7wGACgHTNEbvOHoWpR59+yQ2ry7/6xuee2T90Fi7NA/q237vv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569329; c=relaxed/simple;
	bh=zSkwFxdawuhzp1rpRWhOyjFp/r0ht9I8B+KlJS0Nahs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cYyL6F8Xs+3HayU9XjeyQTKdbzvKScG1Sj+O1pY3KvYoAtExSRj41zrc/0ssd09A7KvE/80WLYwvJukDXNwIQn9w6WNSLaHK5h/ntgRelxmUCXMPuw7UNYJQxRVltpxld7QaaJUxGJd0rE3mq3Of1dDQV4LAmeLIoxKbISdo6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUQQxhfy; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7e3148a8928so5461686d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758569327; x=1759174127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxb0la0Xz6K3HZRfHiufAhiCg3Bf0VK65WFpq6/jGV4=;
        b=AUQQxhfyEGIQJiv/zp4tpSpnjN9kcWbkpfMo46nL2wkEc1fFdwaay3HXYkNW11oKE2
         cyDLHglZ1dgKvzmQh6i6JERPQPXCu34zPRv2r27PwruDVkK7T65gtSYnyjZfKZHqWtrv
         F6P0WZ9OPSUTht2UOYIyr8WF0pkl2mPaCAxBwbtVMSrvCJ0LvjrPOC+1v6HJRt1PGw0i
         eOMNOTn9XjnMwHO5DqnmmGcKmv61s3iZOTYPyNHV+NTq+2WkAc5kJJzaJfj7pf236nGx
         YiOQ+WufyqiEswo+s0+NVc7t5RaBW0+MfDn7nQUrS8f5aRbEWrYv/eJejljOMYWLJG2B
         iMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569327; x=1759174127;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fxb0la0Xz6K3HZRfHiufAhiCg3Bf0VK65WFpq6/jGV4=;
        b=HbafbFCHdGaqxqQw3dMUGMGd7XWjQEQjoRkF9RxKF9qH3C3+y3w7UdDS/FRnW9MthC
         LJ/xj/F8ZQk+L/yvFm2zLTcivgax20738Ws3vKN7U62LpbeNo5FOXAAhibJ2K6quetwo
         0Nw6JA140r5SvIh08ks84dx2NSzLuFVmYTNsLmm0rXWrKECyEezCaU+Wbx0vBVjU7jwT
         QPyuaHMrBFl3/wzNLXp7l30q0WJeXS47UbRcZM46uOxgoz2DhPLgPHUcxTea5e9t76rF
         ZZ3zfV4xbkqt1wIPwiJUszPl7A0YTar+i+F8AfZPgnmNTrwNmRJet4GP4cu8IM4y/tzz
         sjlg==
X-Forwarded-Encrypted: i=1; AJvYcCXilaR47MGsu2ytSuROSJknYSCGKx7YFhVOogJGlhMWil5avfmiij0AsM0e7OJHx1Fc7oKQEcI9tMoQJD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbkbKRHp21SuL0skUdalVofbwurY/35FC5UDU/8FV7O9ZBYZfL
	lohn7AA13CvP8tmbkgP3S/oNUSJxLwOTfRYG+Pu954V0jAwuIRech4th
X-Gm-Gg: ASbGncurbyH4nAWtwDX4N9/0zIWv8ffMu0bpi9FH0fDiIVxXNw7j74uhBscL0zi83k0
	+ZCU3FOxSl/jfvo3yrSqCUmdpYKATf0ASPnmpX8EJtRTjoUz9u8dJ98ksOnl+YscS9LJerkcW6c
	WnaYpDbOsbXdhCJPOOtQSVYDdD7i82WMwhOPRULampnNQnfczFR/Xvy/HIfjz0eqXtQOOTfE5it
	I/pwx4fqE2gg1f1Jr3X7LXzNrXKRosjA7M8BlgZNgl0WJ+2rSSMwOxW8XsrfGlreAVUXtn1mNDO
	kXvsIeN9pWTQ3L7eV/Kvk6I//ET9wrZaS1YPTDRBwZHx4menJmPuOtE+Q/YMnATJHTjgjQK1EnP
	lr0nXRnWIhIZuuSQbtl21H0jNG8as1dmlfBcSdfIksAyA9euwcVLF83qYfrGSPbHk07uWnw==
X-Google-Smtp-Source: AGHT+IEZ7ogsjwn/ejt4gpuz+nTAp6KlpElnbRIi//vPnug23cysGIqoyTYI3LYBuPZHPV+abeZSlw==
X-Received: by 2002:ad4:5c6d:0:b0:783:cc80:1770 with SMTP id 6a1803df08f44-7e707658d4cmr902906d6.25.1758569326786;
        Mon, 22 Sep 2025 12:28:46 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-793516d7c7dsm76243486d6.35.2025.09.22.12.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:28:46 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:28:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.259fe4b84bba8@gmail.com>
In-Reply-To: <20250916144841.4884-3-richardbgobert@gmail.com>
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v6 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Only merge encapsulated packets if their outer IDs are either
> incrementing or fixed, just like for inner IDs and IDs of non-encapsulated
> packets.
> 
> Add another ip_fixedid bit for a total of two bits: one for outer IDs (and
> for unencapsulated packets) and one for inner IDs.
> 
> This commit preserves the current behavior of GSO where only the IDs of the
> inner-most headers are restored correctly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

