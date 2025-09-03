Return-Path: <linux-kernel+bounces-797944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9928CB41786
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CE214E48F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F9D2E1F03;
	Wed,  3 Sep 2025 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFkwY3uI"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF912E1730
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886391; cv=none; b=aNIjXzmfLsuX+VK8ggsNqQEEaiaR0k1m1NQkh+vD6W/xtdNpqRszrjgqUbk0Ys/9W5lPhnr8XhVhNffNUZHyls3HHSx5a5KqIrObxiEUr/qLzGC0mS9eXPZIfA37atCXc6nCpSSAyMO4h2ZtrRruhOzZvJ8R63rdeA9tSuLRpvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886391; c=relaxed/simple;
	bh=NuJ5kczUaPyxRvxC+f1VoCqxCsu6DO+7M/ERWYPz9t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrOrMEzKRrspcK0U9GWqKVWxhzuOisWZYgOFDNH/Si/W/2RGlMxmYDHrRpg6glvnITbtUKsFrtZTg5CgoFJdReteri2loczM+XAoUHQPlSPrgEI3mMpBoCcMqrIf123cVPOxiy7tu+i7d+GH/nJP/cgtoZQvrtDiuKeHoLQveKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KFkwY3uI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e8005bso6213341a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756886388; x=1757491188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxaxPrhxXUKCJIvoF2szrtMVwxxmWJYC9qzjgklL7VI=;
        b=KFkwY3uIBwEznFBSHoIiuTXmc21MjuXj+J2YC6IuK+YWWLbFnZEkoq/wcExbpDfLMU
         p0MpCLm5oaiIssydCRoLB8SnV8Rb8xEnegNEYsIRfSeTKEZDjk/32PcN9FIYeOxrGyVL
         R8NApop+63gUtk5ojnP4NvX6lA3uy8P9M0SVxfXP2JOdruZFvkmpI3c0xTUAQyWnlb73
         FpXWtHMYfdbKTMTWL6KCQMpZ3Gz49/VwOL0MLlQgd06deVyeyrkf6skL4+m+6bTXkyad
         p39L8QM2qkmmja+lhvgW+mVvTKZhmkSowemBHhxCWRy7NBrH4MuKaQLQXh2GCRPQ11zj
         jWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886388; x=1757491188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxaxPrhxXUKCJIvoF2szrtMVwxxmWJYC9qzjgklL7VI=;
        b=AYVKY+D7dFn4hS+5YCLveNoO8kn/AokLusiRZsoa4ppzFNmSlsrpgM8RaBO9VQ266f
         S6tveamiykM7jlGni+0crr4JGYZvTw6MwM3B5r9lZjHiqtV+2ZvT1n/R6HH2Wd8TQzjI
         eGx12FZqYAvfzKJ1zaBviXOPT4FTbklZ/9F4TyS5Nkkjg6RD5KrGGxFNxqKdGFt7COlu
         nbaqoUSt/jCfKEjeutosJ+klzy9SanZi2+GMNqbTNWzEhefTzMUWUbQvm0QfEnM9TJJM
         78LnYcdHpNAZ/YCwFVCRCNs0X7kbSZKB8J6UzMyCBECJrIlXzimEmxorTEm/S4B/j5L5
         uv1g==
X-Forwarded-Encrypted: i=1; AJvYcCWKN4zBQT0cKRGjMfluSqdjiejBns0erX+PI04GGIWBk/eBlXaHAfKfuCXl94G7dx9We+hO7YrC3Pp4JtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4QvrX15BvLfy13An5D2/xyYHApGXilg/EQaZGc/+A8MeGcgM7
	GTDS0slNbrH3bYjyI59fU+2EABxuV4LJDWWTFyrHNvQGaXBiarj+L/GGNni1B1qj12E=
X-Gm-Gg: ASbGnctczAGWBoOq7LxNj+7RObnkzKUUXwn19dJ3ZMGQTcxuds+1Yq6g5h7WSjhGF3a
	ElqAegC7dysEbnTGs/6q3QX8LCT6aON4HBIzxU104WtZt0B73oiawgBtRpd7Px7I1G9ecetl/Qf
	4s5/CMD9e9iM04h+AdU5kh30fcBUL66OX/7sScyHnd1mHXORgmYiHLkulGFjQOQ3MYOZ5QH5DMj
	uYvX+jvoQdJICyvc5idR6SDuSVJRrW+ep0fHoh5Aw7MyDQANlYbGuqgmWvVuAv+aA5mvi7TVrhH
	88uLdauiH6RQFmt808c/YzcGzro5JRPRDa1q1ZybZ0C3qqFFkWKchtKqM1IsPwWeJOPkKsPWJEJ
	hleEkCrKZmAvGUd8N8Y5KYwLm
X-Google-Smtp-Source: AGHT+IEP2QMbg0XCTQEpNBhuxFDoLswUh1fE6Y3EcWpzAAZ5uDLhKBYJuBQLyDeR7XebXktTSScoSg==
X-Received: by 2002:a17:90b:38c2:b0:327:e67d:6595 with SMTP id 98e67ed59e1d1-328156cc9c0mr18377152a91.25.1756886387791;
        Wed, 03 Sep 2025 00:59:47 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd007026esm13828115a12.9.2025.09.03.00.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:59:47 -0700 (PDT)
Date: Wed, 3 Sep 2025 13:29:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernow: Remove redundant 'ret' variable in
 powernow_decode_bios()
Message-ID: <20250903075940.wftjq2uq7tginq2q@vireshk-i7>
References: <20250903072936.4067-1-rongqianfeng@vivo.com>
 <20250903073702.g755d3xtjlkkdbfs@vireshk-i7>
 <4c7249a4-d4fb-402a-b958-e862b6eb04fc@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7249a4-d4fb-402a-b958-e862b6eb04fc@vivo.com>

On 03-09-25, 15:54, Qianfeng Rong wrote:
> I see you have already added the Acked tag to this patch-do I still
> need to send a V4 version with a detailed description of changes in
> each version?

No, its okay now. Don't resend.

-- 
viresh

