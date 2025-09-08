Return-Path: <linux-kernel+bounces-805162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BCEB484C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB173B97F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620582E6CD4;
	Mon,  8 Sep 2025 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ml2mmTlo"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907B2E54D7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315033; cv=none; b=AHRBZ9/EujOO8dD5lvSFdhQX1OP5VdfIK8u/Ra5kocGjW0/uKtueL7fzND0APN1mwVIGlVdn2NhGr2amdXO/5EYBq0eIphZ4hZD2gbP0JbGoRuTy2PCb91y0oS70A4cBEa11R2GypEC+WaeYVslP7oKDQCYVF0IaQhZ6EGBIo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315033; c=relaxed/simple;
	bh=IFQSsw7X2lJbg2eU0tkmcDM/OFT1IO01YnqUQ2sDIUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2gqOsxyn9LxfuY8Iz408WNf6/oTpjJXbsgc/C1EuP1xa0BygwsaGUy40QKeRqmsUfbJIL+zxyjZFwITUMCPybHEADCZ3vEqgkBjwgi+vrVUjBTKdlOvan5UR1fW2sMOfzWRTiyw2T8+nPDXpg+JYyGncZ/TeHmCzKJeqNDYwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ml2mmTlo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24af8cd99ddso51299365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757315032; x=1757919832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xM4p/zyaJz7z9vlZN3il8DQFkpBC93i/XYk/dKxNDs=;
        b=Ml2mmTlol0pjRBy/jnvuNKbuhrHj9lRhfet7IVe3yw3n6zObqXEZDy7fTvfbPJ3bVU
         4dNMOZb85Q6uvEcV/aoT4CSY3UbdIR3U4YL0gCxTaZsH7DtaG8hHurdOXIQsX3NsXc2E
         eRCa9wYguwux6t3DhUn2sAG/iZlEsPg3kjfqkG2yVJmfSMZiFdDJvjlP1QoE9OXuqp9a
         9JhEaPsLn1djpX47bE2Bsy+eBi9cj9i+8+XKhVWrnIyMgYYQtCiGBKJIkj1O8ZuKS7Ja
         lv04Pgg3nsSEb8jsitFpO+yXSsJt5qxUZid7eNSyB4OWEhjBfVM64R79U2PJCWVA2YKS
         vrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315032; x=1757919832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xM4p/zyaJz7z9vlZN3il8DQFkpBC93i/XYk/dKxNDs=;
        b=o0VYJ0920x6sm4mDenLPkz1WpIBF9j+aOV6g+tWqXh5EttFg92CF+wC1iPMFTVNhAq
         CyKuq5G5sMhFoMeTTsvZhcWMWk7X5kfRJ7eoP8rhNrD7YXCr0TJ5wmFbGwmGSBC9wsDf
         1g0mWQSPNKbFI8dp/SbZ/JlE6NZLbyVlNPZzk3aX5ifafD1GbzE+jOAGn4XNWHFo52EO
         01T5UEPKEG/B3j3ASzLeQaANdCJ8pUEsVRUtU6lDuQu6pZiSLyR3C3C0rQ3bkEkmeqZb
         On0BEVZ6AS6nyIw/g6qi1ffDz8Q9COaqMO+9y65JFGil39YGvVPbMsGeNK9iBi/dOgFB
         If4g==
X-Forwarded-Encrypted: i=1; AJvYcCWG/Fn3hc9ip6vi3UbcCbueLihSJKaG4eMxxkMgxhzBh83ZjRvQurIJZkHXsLIjEsdrIH4BMK7qUTJPE0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YziX7Jau3MBHYUSt9EhXqDsmwN87SFWyKTwfgCtLuzAwkeSjITz
	DHVhV3I9xtm5enI5gu6LQj5pTEvkEmJTi0Pq99Y/YwcSa6WxjpL6nKeawUNba/YxUHs=
X-Gm-Gg: ASbGncuJAncM5++ndek2se1plH+KIiDN6X7C9h4TIg0FdH9tHhA1TmHJ/bXEW8ybPyQ
	4YN2q7/xb8eOyVqHlLOpDC7mqDUjGjLnPNrhTJU/JlhNaYjuulor6EzoSlMOy8H6nPdwQtzMzJY
	7n2iAU9vnhT6aG4N6Jezp9gpcUoj4gCJcBn73PZ77HUxoVpa14QN8fFBrwT/1Hp5o5Bq2wFOEg7
	Cr3jG6rgL5DOxsweNfFoOsb7xCz3/wYNDOoIP/+67FZSo9BS+L/Slq0r+V2Ip1+dQ+73VQxUwXw
	X3GjEiI2JT5zw+nxqp5vxNIvYbEEC4erwHELK2/I16JdE1F+RP6QlunJ9EnyYZm+OcI4/Bpt+iQ
	umrvYg7zXEr8E9dpopcJLw0pxcGrXHHeR71Q=
X-Google-Smtp-Source: AGHT+IGdeCh/rybFQC/2arp3UhBEUX+o56WdtJ71SfDZ99wsZPoSxMLD22J5lDCxlaU3DSTir3vf/g==
X-Received: by 2002:a17:902:ec8f:b0:24c:7862:41e2 with SMTP id d9443c01a7336-25171cbdecemr112986595ad.31.1757315031785;
        Mon, 08 Sep 2025 00:03:51 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77248cfbc9esm23739860b3a.99.2025.09.08.00.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:03:51 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:33:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, webgeek1234@gmail.com
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <luceoscutum@gmail.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 0/2] cpufreq: tegra186: Fix initialization and scaling
Message-ID: <20250908070349.nsep6ekt7g426txq@vireshk-i7>
References: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>
 <20250904050358.kj7gxypu5mmov4f7@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904050358.kj7gxypu5mmov4f7@vireshk-i7>

On 04-09-25, 10:33, Viresh Kumar wrote:
> On 28-08-25, 21:48, Aaron Kling via B4 Relay wrote:
> > This series fixes an issue with shared policy per cluster not scaling
> > all cpus and with some cores being initialized by the subsystem.
> > 
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> > Changes in v3:
> > - Use more clearly named variables in patch 2
> > - In patch 2, fail probe if no cpu rates reported by bpmp
> > - Link to v2: https://lore.kernel.org/r/20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

