Return-Path: <linux-kernel+bounces-866834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC580C00C88
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1F13AF401
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC7330E828;
	Thu, 23 Oct 2025 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzjIwAqF"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DADA30DEC5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219161; cv=none; b=oFxoBNDCgnc0x9FLANvID2m4JPGw2Vdi5+g3x/0CcVcr8UNuct4bkYP8D3BHtzb04d9SzeeeTVSI4EY8BV6+ap9qTkYwlRlu0WY0CxV/DqYta7yzwH+WiCFHcbUe9qr1D9555ynUPnKvdqsdS3INTaPXezjwjuXrju8thOQUffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219161; c=relaxed/simple;
	bh=azN9cFPaIK+LJvezpMi4n8W0xzLhUdTsw6rk/82Y4Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVqcS0ySU2b0xh/2ucvdcc/vevVXyvF771pXWoesfX+Ji9sZipRTHEidWmxh8iAa1yJ0/qkAWxH+/rfkWXA2MeGPf+6dBuGTRK/M6ErFXVTtRdzlrNrgijpI+WS/HeqttuP7kJqKlz5padDyHU9MgnVe7jWLH7LFSqNaNTPGcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GzjIwAqF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33d7589774fso811666a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761219158; x=1761823958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbT+vL0Cn4CTb6yElLpwHZ54WgDRlKCx3aWeBMwUJrQ=;
        b=GzjIwAqFeZ4Us1IkLeYKFX/B9rnMtdcwRA3Z7JWlL1EeRxoTIPVbXGclFmtVkpycPY
         pEyXmgDZuzqaCmnlV7kzyOoRSlMV+4sKlRsdP9M7W6EtBbVoyD4VtoA48E5+EB+Mmo5M
         +rPeLnkCrh8ua9Vrk7+U3o8pxLOxATEtFFdA3YUC2ngtWANcdBbhG53LtbEbu4WnjrR3
         8if8sTwBEOHGJzAZ/aEdThe1U6V2FpJS5HPA3gk1GDjliGqQFXpHezuS76IoxX0TyJyT
         LQZQ/YcCGpNBxop0WV+RdxVXJZJ5XAmfSKSs8cU/oLzgoea+Vg8S0DImMmP+GeRoDGDf
         9NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219158; x=1761823958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbT+vL0Cn4CTb6yElLpwHZ54WgDRlKCx3aWeBMwUJrQ=;
        b=chwzDa5Tl/AA2fm7EIqrUZFksKajaSVf/PD6ezb/A8RR02bRXi0nc4weSk0KOj/eve
         MfJKeoSOfkF9PruGwYagYrAzj4Ea6ZQ4ul3yMkzungFkHSsUX7fh7k2IshP2DcfLzmI3
         DgeEIxAvQtXChDeSyZVUiO1PTIMLOzIc/iuHNQIwDmMVxQz0mrEgAp9/oKoWGN4o+UvH
         Rg21+ehVj+0wyBU8LkTaTFj2vVqeWv0EuW74kgQHT9FcRzfoFjD+yvmWp7+XAaoRYgkJ
         wV/gT4Vgh6bnSLaXBaQoybNINPsPTalCTvEq1TuQ+wm2nTK3s8kQ/XlizUa2vwV46rXA
         bwpg==
X-Forwarded-Encrypted: i=1; AJvYcCUJJZhWQ5Kbf1E+6lkqS0kC7l3TWHBBCfXJrvL/wxg342pdSt4obXLYnwFB0NYzkRf8lNcflK9w40H7no8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+pbSEEcI4tKHZK43f4YixZDw4E/R+IMmXL2rhsL2hZHnIZGW
	7jb8qVSzQus7/qjysa8Ynl8o2g+cYlpUNdNFpsVZ1vYalVURyM63bP4ebTA4k1PcphDE+emmo6P
	QOmSc
X-Gm-Gg: ASbGncs3wMnUdFy+5BxUVqWrK7qLjjPEFZxSSDGGb7f++kfp3ioKRHz6y7kMlt113gZ
	vTEpApPbAQD/1+5i7f5aLyMT0JTaWM9VxCXRtcGAs5fLccCHWtIg6HAtHkCfbPSluPUQHG1PusI
	0QmWNdNLYQpxZQaZkI41otIw8thV6QOojKdojNn29sPFWMVSm+hIIsCuDWfuzLV+qyL0u/9xPqR
	VxdAvgI6MmFenvPF3xLInExCJBR6ad3CvYs5yWKbmHrvCZIdWhIR+iN9fzuBtWDeV+bdkywwz4A
	BMxpPTyNx2NROXpuTceewkNvCKn6P2sonNAW1m0se12Onw8tTJon0wREeKFbTmeli5apyKFhTHo
	Ta98WbPkBNiGXu1yZfo8dM4OXEj4LxLXzw74L63vEwRS+EeydeRCb/FNjXvhjGT+eJewCDc0CsK
	ojqg==
X-Google-Smtp-Source: AGHT+IG9Mwz3D5ODuzsbIDuuLt6IzRd6uufkDmvzSlsw4AlqElvO+VEf4ssfLY/szdToC/ms2IV8tg==
X-Received: by 2002:a17:90b:4c05:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-33bcf84e181mr35547160a91.6.1761219158271;
        Thu, 23 Oct 2025 04:32:38 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3c1f8csm4042462a91.4.2025.10.23.04.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:32:37 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:02:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: simplify callers of `to_c_str_array`
Message-ID: <44k7h2wzksrp4eghvdim5kiq5tsul3p7yhy44d3eii7hyvivch@xx3x762acknd>
References: <20251020-opp-simpler-code-v1-1-04f7f447712f@kernel.org>
 <ms55ue7qqbvoyfhptzu2a5cuthusihtobremhuqfm7lyu7b62o@qasunalgkptl>
 <CAJ-ks9mKiXR-8m_9x_k6YcL64h+QWExkiWCHMFNJbdUYQvPsNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mKiXR-8m_9x_k6YcL64h+QWExkiWCHMFNJbdUYQvPsNA@mail.gmail.com>

On 22-10-25, 07:22, Tamir Duberstein wrote:
> I believe the `{clk,regulator}_names` vector bindings remain alive for
> the whole scope, even if they are shadowed. See
> https://play.rust-lang.org/?version=stable&mode=debug&edition=2024&gist=800b334c514c2024d7b5e47fc54c1f2d.

I tried to print the name of the regulator and clk in the C code:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d67d392e16d4..89b65fe07b99 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2565,6 +2565,8 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
                goto err;
        }

+       pr_info("%s: %d: %s: %s\n", __func__, __LINE__, config->clk_names[0], config->regulator_names[0]);

and I get this:

[    2.358437] core: dev_pm_opp_set_config: 2568: �<��y����<��y���x��: �<��y����<��y���x��



With following diff applied over your patch, it works again:

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 743080e14292..02cb754c4abd 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -444,13 +444,13 @@ pub fn set_supported_hw(mut self, hw: KVec<u32>) -> Result<Self> {
     /// The returned [`ConfigToken`] will remove the configuration when dropped.
     pub fn set(self, dev: &Device) -> Result<ConfigToken> {
         let clk_names = self.clk_names.as_deref().map(to_c_str_array).transpose()?;
-        let clk_names = clk_names.map_or(ptr::null(), |c| c.as_ptr());
+        let clk_names = clk_names.as_ref().map_or(ptr::null(), |c| c.as_ptr());
         let regulator_names = self
             .regulator_names
             .as_deref()
             .map(to_c_str_array)
             .transpose()?;
-        let regulator_names = regulator_names.map_or(ptr::null(), |c| c.as_ptr());
+        let regulator_names = regulator_names.as_ref().map_or(ptr::null(), |c| c.as_ptr());

         let prop_name = self
             .prop_name


and I get:

[    2.460149] core: dev_pm_opp_set_config: 2568: dummy_clk: dummy_reg

-- 
viresh

