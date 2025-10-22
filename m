Return-Path: <linux-kernel+bounces-864197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA87BFA260
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEA51892DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9FB2D5954;
	Wed, 22 Oct 2025 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKqpF+hP"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95191D8DE1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112925; cv=none; b=GsP06lhBLGXbPaxNJoiRKQjJuK5uiE5lRA+SbGAr+VQRJozrtsjwEEYeaa+A7gXEAKM/i7qw4EAdHJBtiunC3+Mo193FhCdAHeZ9c+o+WIoScOO/zpXK/BWsenKZ0lEJd8cflS+zI6YLQMefrEom+c9lwLG99iYXSD/1AugFTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112925; c=relaxed/simple;
	bh=uNd0RlezKmVOkkCFnO3wa4SdchHNHXgBhmGRBya+TZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMGey4M1M3PBlbz+dNBRJmqSEuJjzG4wDZbmYr2+tLLjOn2OZOmAjtRsl1XKV3Jzc7+J9h28RwPUEFnT2ij9HtTuPdAhIPhuNcDTG52WY/vZ+0rAJgnLkK8Tire67geMbYgoaj3lvoyrzVptprlZwLs31jCy69DCTupbjtroZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eKqpF+hP; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b58445361e8so535292a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761112923; x=1761717723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKqDAZxx1reZjTRMo7FvolWvlhv6pTm58+Z40R0DLEQ=;
        b=eKqpF+hP8Qbu3WbRL1Cu/e12XbVa8+AAEYIMi0P31MHcpq1v81UMrb/4C9zSK6AuOr
         z7Wjz61qr72WZxGlM0KXV+POp8WVj1nuV6yHeHG772YwOaJbcPx7ZU5VGQTxSsBKNsDD
         tC3BH8JAiYDj0y4N2XzwRyuolOTakgMmdRckXqQxSyMXTg0Szy3qtK4nMH2fPqkrPR/a
         D7YJuAcE1qmNXJBfoQDcqJQ70CUVxWehHcqWgC/Kn74BS8ejG+o8fCaC9PDKE4X7Uvi/
         A0gFJ3dfYeplAM1H86RVUfwBbqUsr4tDmv6CfS1s3aWtiKKfvVJSsvD7F239+xR2rA8P
         HAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761112923; x=1761717723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKqDAZxx1reZjTRMo7FvolWvlhv6pTm58+Z40R0DLEQ=;
        b=hg6YBiMAytGEJW3NUmYz3D/6Bc7atlMDJnIX/ei876b1gloluvYXnPSLT2OVTtCrHK
         i6j4pBi8xwuwy+wWNdZXnE4QAB8xYVIiJ7V4MdvammIFjqpmQRgzJ5QOp63WsPgFI+ZX
         jbcHwcbElws3DHHuPB0Iks1PARo19ac5rJymN8+vy8zVMIo+YNZhj1kf4dMWgtSIRgJ4
         9JRsCiZUi/wSdmrKHSGawuAFsclmqyrj3UhnjacP/q/nsmFg5ajUJstT2KEVpg4vGdY1
         Op9T7AECVTGL59z0oIcjKcr1mIFKocmbGxgWYpvANtVGV/Gc206uz9UyJ9uAg3jTsFFu
         68gw==
X-Forwarded-Encrypted: i=1; AJvYcCVirKCxzsMgUd4+PKS1jmBM3f7Y25+oE+S1RE0oOtPs3w1oNF8SjqSDbAsdH7GFKGxjQ+BQ63vxDzB+hLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXdZC0go6nHdp1lP+M5C02ez8J0iBB6TateM+O69JuoeiCyFZ
	iYGzymxJpm+1CxVE9UAwQ0T6RV3Om1kgFlrj2RS3xUOX61QqLQVxtzQMvRZAMhMP3DzIfCD4TFl
	IqtCh
X-Gm-Gg: ASbGncuby3QPUaQssqiTsnS2C/0VVZyqdzGPg2O24v8fLa2vP767e46JKbVFsAJafrc
	y4uByHb2OmchndHvQ9oCCrKKZvfbs8TxOC2bQGWIcw0sDnsRYgGdbtcMHFj9OD3PlW8YmXcNlq1
	BDNqA/bUwHQSmIzAryb8ywvp7+JBJb5v+yQPh3VJ6SN1LlxHNb9bybdsxHICzIugDVbc+I75OYp
	2uyIwMqu+8fRmRceq8Rkd21MKT6ymUOjrIIX/GLfTHouRAE7dAwGU3JknoyFFUvSamuZy6mnhF6
	mXQ2d06PnCNZdAPIO8o6HeIYgiOFT5LoN5+YVfpxG+R4hA7MazH+H9rkcLfdRJeESIaK9wpbIIO
	TeSCp0MuxnJDxcjUULr65gKob6mOD/uI83YNlHFK+E/OWCG2pE4A4PNzmrEebpFDg9cBYVv53fi
	q9Ew==
X-Google-Smtp-Source: AGHT+IGnZYhZ63rWNSf5aRz/1B5HoUov1Sbx9ncDDRSOtX2wKHaECGMRKtQmrnXwpxWiNTSuOjN5Bw==
X-Received: by 2002:a17:902:ecc2:b0:269:a6b2:2463 with SMTP id d9443c01a7336-292ffc0b82emr31764605ad.16.1761112922908;
        Tue, 21 Oct 2025 23:02:02 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292469104edsm128908115ad.0.2025.10.21.23.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:02:01 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:31:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: tegra186: add OPP support and set bandwidth
Message-ID: <bxec7gq3b62g5jdyxs7oo4dvq4dd5hwczdsvbimjka7u4zwye5@iubxkvn2mbre>
References: <20251021-tegra186-icc-p1-v3-1-7e6db3b070c4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-tegra186-icc-p1-v3-1-7e6db3b070c4@gmail.com>

On 21-10-25, 20:08, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Add support to use OPP table from DT in Tegra186 cpufreq driver.
> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
> Cross check the OPP's present in DT against the LUT from BPMP-FW
> and enable only those DT OPP's which are present in LUT also.
> 
> The OPP table in DT has CPU Frequency to bandwidth mapping where
> the bandwidth value is per MC channel. DRAM bandwidth depends on the
> number of MC channels which can vary as per the boot configuration.
> This per channel bandwidth from OPP table will be later converted by
> MC driver to final bandwidth value by multiplying with number of
> channels before being handled in the EMC driver.
> 
> If OPP table is not present in DT, then use the LUT from BPMP-FW
> directy as the CPU frequency table and not do the DRAM frequency

  directly

> scaling which is same as the current behavior.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>

Applied with:

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 35f1c1371f6a..34ed943c5f34 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -127,9 +127,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
 
        /* Disable all opps and cross-validate against LUT later */
        for (rate = 0; ; rate++) {
-               struct dev_pm_opp *opp __free(put_opp);
-
-               opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
+               struct dev_pm_opp *opp __free(put_opp) =
+                       dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
                if (IS_ERR(opp))
                        break;
 
@@ -145,9 +144,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
         * Enable only those DT OPP's which are present in LUT also.
         */
        cpufreq_for_each_valid_entry(pos, bpmp_lut) {
-               struct dev_pm_opp *opp __free(put_opp);
-
-               opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * HZ_PER_KHZ, false);
+               struct dev_pm_opp *opp __free(put_opp) =
+                       dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * HZ_PER_KHZ, false);
                if (IS_ERR(opp))
                        continue;

-- 
viresh

