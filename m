Return-Path: <linux-kernel+bounces-737934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA91AB0B21B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E479C189A173
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A42235071;
	Sat, 19 Jul 2025 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McbwzzrP"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F616F8E5;
	Sat, 19 Jul 2025 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962468; cv=none; b=J81Vn+INmg9VAZLugzZoxdn4uclaeiRbzQS78h7oj2gvFjfpT+uzw4MVOP9ZT6/kdFBwE7JfYCVtwaFmu+SilJRfQukNBlnJwCagfiz6rFqO8GS5o1nDhPScZ69evj5l1WOau9qe/IowVCTpLi1UeC+7lduYVXqNhf6aObJ8twM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962468; c=relaxed/simple;
	bh=SMT8nkMmC72ZrH0aJULzYudTfnut3E/bLledufyp7Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbyO0xcfd0Hk9n8iThoH7NLB27/4bA0Cr64dTbYu4oI2LmLDswBxk5tK3Ji/EqwFbw20WIvYL0fnOshCS+jkVK4QelP26GMoWfPGoLlw7jTVdadxyqK9MzPT8nj1JAIiVLNSxJtAuCEHjgrBXwZUBfvnXaUwkgUW8XlTlPg7r2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McbwzzrP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31329098ae8so2768820a91.1;
        Sat, 19 Jul 2025 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962466; x=1753567266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuGjbu6MP3F42ooeUyy+xaVq4CNVeFp69dlwDCRvfl4=;
        b=McbwzzrP3ODRrGxFqZ763OdymgkTHYaloPUFIuNy19tki9yV6krlC/0tDlkak3z8qP
         jGBY+C4YV4npzE5EzpB6hTyh4XfqNBbFkPjLIDR1h91DYGedpekfSbXgPO4XMe1kVsxW
         vlYzqyQ2yd8cuo0hGkF/xfhoEgczG3uyZyv01Op9YNSGE0nBRctjc1IHpYbw9QMrw150
         8xJnQXexYXZbM7xHUGXjaO1xAXgKt02wPP2MT6mSPCYA0tiAVIcP5F9NQFBabtF/D5Y9
         rpEYtfAHBnAp2ewn20FDrtRBOPUovptlwkyAz2Y2hw5rluZQeEXDeQPp62v/4vBEb06G
         zDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962466; x=1753567266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuGjbu6MP3F42ooeUyy+xaVq4CNVeFp69dlwDCRvfl4=;
        b=Ae+kaeqkSAazBZsoipP/2ZtEoLNZJXhtxdwcthfen/kyd+07ZP4w/xaBWlSnu64Hfw
         U2d1rOvGKcyFlvLCpF4agX2Bipr3Lc6GkoDQX7kyHJrOjIUKjlSiDoxc7bRa1vBvsjTO
         hSQlvbaO993Rr0Yb38HWBbbbiPnxnDz2/QoL6drxlEEHjHX/2VUnyS6rjQutAHuc333V
         f6e/Iw9cqhWllxRpX+VMo6D2TgyZqL0j8lhpCCLwn5aRU+MfzxOwqDD1+LlZ4AZbtrY7
         9ggOYxTv+RaoB08BoIsnJ43KMjXDHa1cYOje/gIDT0IiaWl05w2QvyUNLLDj31isn5Wq
         joWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Lo1Pl1m6jYZwA1kt76IAOQaNDLPwc4KNt3ixAuuya+f1HjEclYhPrJ/Wv+yzeSrI1vsHfDyYipj96mha@vger.kernel.org, AJvYcCXPnXgrRTXNEMckBF+DmOAeQIWgmH0uIu3h2XkD6xzKS7y4+rg6AktkfldTjM4dLnu26rwwVkt8Br4F@vger.kernel.org, AJvYcCXtkgc59SJR8422FW0f8siFtc2k1bg6ReQWFEQFgOrXz80GcmBfzAvWohHmGrBPepfPhOLG1zX1B5sRhI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFwxO8/EMr5L2IGmAeVhXliwdujV4jWiYbRokKbNTsC3a0NTPb
	R7JKcoJwlbwKHZr8QxwvGkD4hrLPEoXqHtegTGLoM8/WNaH0k2pG4jZO
X-Gm-Gg: ASbGncvI2xhZEPDuXo+viqH5EzB2KgvnkF+CkwOUCdzVE4QQ+J8emJ/IbxV9bJ2HtNK
	p+vHHl3JoLnSts6OyVuXvU0R6af0ZBKq9lOXlpcYT5puHsL/FBdGJygdJqjClikPoyrlH1pcOJ1
	aqCV1zrzGpoGF6OnlpakHb0dDrW8B0mX259RhyWuo5CfGLlQkYvo4frhrk8Hx/a1ABoNr05JPb4
	71F1wJbUYUIRZMj4L1p4UWfKV3Bbw3sy6TT5QwoJ+2VmpWMjZoK9MnOqefeWMBtPvnK6q2KrHWU
	x6gPhiDhUMFxM5O0rWVZzZtFz0uwJ79VE3LFfOYYr9sYgcP85gKUeftJzNTt87tWi0tglSSM8C5
	BOjhKHFlwq0NP+yhaj1HWfFRGdEfNcjQDHqtj3rE32vLD8w==
X-Google-Smtp-Source: AGHT+IGMUi7LUuVDI5HtLdhe81ljjRA6H5xLG+2gjo/lEFyGwxT4QmyY6dkZ4P3/C4RYzuqKoY08FQ==
X-Received: by 2002:a17:90a:2d0:b0:30a:3e8e:ea30 with SMTP id 98e67ed59e1d1-31cc0440b11mr7737354a91.11.1752962465634;
        Sat, 19 Jul 2025 15:01:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f44970sm3495572a91.39.2025.07.19.15.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:01:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 19 Jul 2025 15:01:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/3] hwmon: ina238: Add support for INA228
Message-ID: <1fc421b7-80fc-458b-8ac0-afa61ed03568@roeck-us.net>
References: <20250718-ina228-v2-0-227feb62f709@pengutronix.de>
 <20250718-ina228-v2-3-227feb62f709@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-ina228-v2-3-227feb62f709@pengutronix.de>

On Fri, Jul 18, 2025 at 04:12:50PM +0200, Jonas Rebmann wrote:
> Add support for the Texas Instruments INA228 Ultra-Precise
> Power/Energy/Charge Monitor.
> 
> The INA228 is very similar to the INA238 but offers four bits of extra
> precision in the temperature, voltage and current measurement fields.
> It also supports energy and charge monitoring, the latter of which is
> not supported through this patch.
> 
> While it seems in the datasheet that some constants such as LSB values
> differ between the 228 and the 238, they differ only for those registers
> where four bits of precision have been added and they differ by a factor
> of 16 (VBUS, VSHUNT, DIETEMP, CURRENT).
> 
> Therefore, the INA238 constants are still applicable with regard
> to the bit of the same significance.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>

Applied.

Thanks,
Guenter

