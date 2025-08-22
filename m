Return-Path: <linux-kernel+bounces-781233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85935B30F98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEA11C25F22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C1A2E54DA;
	Fri, 22 Aug 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EksWfMZl"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1832E54D0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845483; cv=none; b=Yyn8a29IYdkufhXOjXU1NOkhY7Bqtbk9/ynVfBi9/SChmomZpwwDpBBvQbQ6U2c85XQ/+kbmR0UTgDuUgeLwXOQ01VefYKonKKwdYTf0/4f6AlK++oQDwklbJ9s/d7UAEnAWjLdC6RdOfAnKaiw3C36EHyvonLPy+Y90sIPKDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845483; c=relaxed/simple;
	bh=w+fF5jilwCss3OzaglG2MI9XKzVq/OKDUeZWYv3d5Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePE9+EQvsAkuEccrr1pRecMeZLXvLJ56hH5rzxJLC2erDM41OlimpBKG9/hkKaum3i7U88lgn74znQYmd1R0Q28PS4rhAWRLsptBCT21JDu17GzvqKbx+E5h/wBmVEqBpx5BcDmNNyOBzww1oqnhQO1v5EvVevNx40Bwl8uEUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EksWfMZl; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49c622e598so59107a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755845481; x=1756450281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wnWlGVKFdFIBt1j22TCSqfwegODnyLKYBcy7SHn/za4=;
        b=EksWfMZlgr4e5ZZThYERWiBQ7aMeSuPlEUg2Lbwog/Po0WjlUTyewqcU0wAuE23gS0
         YaXbNNe3hoGrMgH9pE+x98EThdmcpXDbf4ZKlyClWmW7va0ThDh4ljLFhIyyGSl/lKkS
         okjFw0PmAnlvexeq6aeqFl5r5euYi+8FL20H9JAP4SD/M2pJQEXDaqVPo2UQMf0DyBaB
         shYCg8xsZn0xEyiqn3ZcbD8GQvp5GFvrnVuHcebM7j+Dow10jOmvA6zv7s0HHes3fKmn
         mFNNHJKJaCxP4txRNdhaGi5RyK/6O+P0K+CB0f0blNOnb96aSHRRerAq55B6tjUMPYt3
         x95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755845481; x=1756450281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnWlGVKFdFIBt1j22TCSqfwegODnyLKYBcy7SHn/za4=;
        b=MsX3dtbP+4FqWeEJBb1z797qfApu3jmEY7o4dUyJNLEOkUUzXgHbUV64jaoupxJi+S
         Qhzmuf+ZmICIyxlJ/A+KOqu04guhpkvwLfTwXCPlgcE8bfJGqwaipYWy322GBnS3xp7j
         Z6R7IGfGYQzLxYCubAc3bo/L9Hx/boYZXGykHoIVNGA3whki7c3R3Bq4Dc06JdRP5W4+
         y4oVmsAlkhCzxTQkN1MCi9zEvUbKqgzSC9hQP56a7f3WrWcQ0rYCbGVVXdr6dCF865S8
         2lqpkF9EKA2CEStgwkDRU/3vXHKvuTrkRmLzqQxH0Q+hv4c9K9QvPICWnkJ7yWamVXOd
         hmWg==
X-Forwarded-Encrypted: i=1; AJvYcCVGJhCsUhnkAyaaPymOypmVqLpzen9TMuLkuXBOW+7v4Ke49CY4cCu9Tyxd0C0WbHnOp91Nr0aYgpQiw4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUZoaSecbtWmcC8VQnsUSN8UZb46T5tbC2IIuXQDW7xO8scNW
	Kav8cfGZ+pluJPH/YStNAQ1HsQEcwOeaEb6QWWq19ZAiiqgu5yVkbbO7+TRbLnoRJCM=
X-Gm-Gg: ASbGncv6yKY+HBRK1+miI+bFNmt5aU1G8IHyE0VokeGsGVdFtduK18gjmh+/UAPjFKj
	4EJXhLwkDqEHkT90Ou1M4T4Iq+3ntvsxV/uA8PY41VBsqpIc28CM30lUUgAYp5gNGccpIBeKxNA
	LoG3Vsyq4N6rlawiILYNyctkQIUPtDUu9jtlbhAT4bP65AvuNgrPYFqID2U3xS4YaCnXbFMnXUC
	GohGcK8miI015lwxmKi8VOmX8Fe6kEPI8alA8w6sxxUE/pUfISFokUYtvm8Yxx/+8Zq3rifB12r
	a+UqYCwQMg+YwX32cFFMvXfPdUIODJgjpg0dr9JsBRsLkkVx8D0DK8MaOirK9ru6SWVuLV8je32
	Oc5yvlqAf+FnkGumZlMAJL4Za
X-Google-Smtp-Source: AGHT+IFuWz2fYkZGwCki5RHEZnzuVzd/HPxt47eh+hbJsFpZ62hbUXT2LVNh+1RDFwpb0mmLfChYMw==
X-Received: by 2002:a17:902:d607:b0:246:441f:f111 with SMTP id d9443c01a7336-246441ff47cmr14160665ad.43.1755845480880;
        Thu, 21 Aug 2025 23:51:20 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7489sm74182225ad.70.2025.08.21.23.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:51:20 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:21:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/7] OPP: Move refcount and key update for readability
 in _opp_table_find_key()
Message-ID: <20250822065118.qktpqaudc2uhgzdm@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>

On 20-08-25, 13:58, Krishna Chaitanya Chundru wrote:
> Refactor _opp_table_find_key() to improve readability by moving the
> reference count increment and key update inside the match condition block.
> 
> Also make the 'assert' check mandatory instead of treating it as optional.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/opp/core.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Applied with:

@@ -554,8 +554,9 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
        list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
                if (temp_opp->available == available) {
                        if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
-                               /* Increment the reference count of OPP */
                                *key = read(opp, index);
+
+                               /* Increment the reference count of OPP */
                                dev_pm_opp_get(opp);
                                break;
                        }

-- 
viresh

