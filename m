Return-Path: <linux-kernel+bounces-726136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9811CB008A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431FA1CA0E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB462F0E31;
	Thu, 10 Jul 2025 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6gAcOrG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C11E2EFDB0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164873; cv=none; b=muDwdg9U2M4HvmS8ZfpgoQjEyKOcg2ickf4d0f3HKz49ym3am+NLwFgwBRzWKJcaqyfdxM+GZ9RN4Ftg3bbydb1UuTheKIZNybp3Kcey7BCWjnmvm12S4Mrdik1KtI1qRiNqpoRHE2FrWv+hYZ6FfvmI8wvzDDwx1Ky/sbjw+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164873; c=relaxed/simple;
	bh=uByNPn2hW31VVNIAVITQmiBwDw9ZQzuzCS+fE0hn1Ds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VpvGT9y72CPwOEoAFQLig23YW2HE2Ki9lw36i4lJ1Z/wQfsuqPOkCjFGqNadavdH3fwR5JrI8jxY4I1CsfKwsgSQhki5RzIqwkvniZPIiHqevaTpX1Hk6k6zqDSoUKqK5ouEzSjIPaOsd6Qe0j38M3GYF6ssUFlPmpZWrdfE75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6gAcOrG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752164869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3sO2/JwLoOB0WH2WCnvOSV6HSLemFLUS8qLx2PjBI2A=;
	b=i6gAcOrGJPGc3MIOSZhyCLlH0bUc8pdQkmxjN1aGKOvLTV+jP6qerNFoYimpA5LmU6xqll
	JBweLErIIliKhD94OjIEOfdrlnyk6gwQvid2gEvwKHbFYndY1fvNZritbWIXw7i/nh/5P9
	JZvo538GqL8GfDmCMpGGK1ixXR4/hhI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-VlUtdI_5P-6qPFIzeQZXBw-1; Thu, 10 Jul 2025 12:27:48 -0400
X-MC-Unique: VlUtdI_5P-6qPFIzeQZXBw-1
X-Mimecast-MFC-AGG-ID: VlUtdI_5P-6qPFIzeQZXBw_1752164867
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d15c975968so179280785a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164866; x=1752769666;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sO2/JwLoOB0WH2WCnvOSV6HSLemFLUS8qLx2PjBI2A=;
        b=lnPQaFNQk/lnDRN8S188fkantbB5+75lp8qzwCFzWiVvjpjfp6hvmNueAZJhRhBm98
         /X4HmOqQInFRRS8V/dz2SdHY2rqN3KKKa0Qt9fZSCeWPz/DOw9AUsuxE058iEPX6H0cN
         Eb5HoJL7cWD5Jaj1yR5p9KnRKcB+eg22lj/P70uufVrQj1b6DN5wW6XyefYqotCfDwCZ
         HidqmJOkPehXs0QE9w3mtjT0QCW7Q24VyLOuNFg67BMoo+N9D1QhSUeQoswK6hIoCTzk
         4KoJjUNEUoXNywiQmpUiYclbPFeahcQcLmI9+KkYy+OYOaSgcW3JFBmsP+fm/d3DGeDW
         yEJg==
X-Forwarded-Encrypted: i=1; AJvYcCXGkAANmDHcOhzuYeIUE7thURdV+aeSFKo0YCt2UfLz+zTiozdfPgFvhb4MaeKxVyt2fIlLfbPET96tOcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSylOQ9KEG7kUcMOLX+QJnrqP4NdqWD3YFruqU4XXr6z4kJ2Mt
	o2iBHHb3g25N5vAyxYCrmZAK5p34pxyFWoTTS+BmrWJpO9NYgKi9I4lPTYseK+zO4ZIJWPfmFEU
	T4DJ5QKRAutvFgrzaN10HlJCZXUwoVCULWKDxjExocoBjkPFBz1G9xOug9+1TG7Fqo5h0qPO9gA
	==
X-Gm-Gg: ASbGncvhQReIcfGED60uAv1crbCcLwe2uTpW5Ghm4Fi7H4RznB09XrtCtHgGfeRnvVY
	PWsvje1s8ylaFZmr16MlRvmwcRAtqhVoNXYyTVpqRLShAJp9cMFa8R05e+Rd/x5YYeJsWu9/jrC
	tmogxt+E611vVSUivhdWV6/RZymBR6g7G64i8peT31Kii5ZNw5szRL0DcS9C3njbL8OKV569STo
	xyTiGEFxd74f9FpALzLUAe4JBlJIKxupuXTjBIzCTM9OIZTDDmaJtupvUVoT8YmzDNwr7xZeDAt
	halXJwMF8qAaWKn79bE1aqFuy38qlr7eY/gX8MhX6JaTmcF4VJmvz8YYvyBo
X-Received: by 2002:a05:620a:24d6:b0:7d3:dbed:869b with SMTP id af79cd13be357-7ddecc1d5a2mr17536285a.42.1752164866489;
        Thu, 10 Jul 2025 09:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE27LfFDrGnMnfhyfHCbnzrSuLJo3IShFntK9oUyUSQ7N0TE7WAmGfbfKdAyUi+8fKCbP099g==
X-Received: by 2002:a05:620a:24d6:b0:7d3:dbed:869b with SMTP id af79cd13be357-7ddecc1d5a2mr17531485a.42.1752164866037;
        Thu, 10 Jul 2025 09:27:46 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc5df99asm113487685a.49.2025.07.10.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:27:45 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 0/7] drm/msm/dsi/phy: convert from clk round_rate() to
 determine_rate()
Date: Thu, 10 Jul 2025 12:27:26 -0400
Message-Id: <20250710-drm-msm-phy-clk-round-rate-v1-0-364b1d9ee3f8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7pb2gC/x3MwQqDMAwA0F8pOS+QiuLwV8YOtc00zFZJVRTx3
 1d2fJd3QWYVztCZC5R3yTKnAvsw4EeXBkYJxVBR1VBrCYNGjDniMp7opy/qvKWA6lZG73tLoan
 5STWUYFH+yPHPX+/7/gEq7Uv9bAAAAA==
X-Change-ID: 20250710-drm-msm-phy-clk-round-rate-ccb10d54e804
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752164864; l=5373;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=uByNPn2hW31VVNIAVITQmiBwDw9ZQzuzCS+fE0hn1Ds=;
 b=IyDjRecZ8lmUveDSl1A/ekKcgnVDZWOm0cbVtunJ0Yg60K87JgqJbB99cAFDWIE1Ws5cFuS4G
 SGQmD+wl6KeCcggSryEiIu7SICeBclsasH4oDapkP9eAZ8fGGn/ww3M
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the drm/msm/dsi/phy subsystem using the Coccinelle semantic
patch posted below. I did a few minor cosmetic cleanups of the code in a
few cases.

Coccinelle semantic patch:

    virtual patch

    // Look up the current name of the round_rate function
    @ has_round_rate @
    identifier round_rate_name =~ ".*_round_rate";
    identifier hw_param, rate_param, parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    	...
    }

    // Rename the route_rate function name to determine_rate()
    @ script:python generate_name depends on has_round_rate @
    round_rate_name << has_round_rate.round_rate_name;
    new_name;
    @@

    coccinelle.new_name = round_rate_name.replace("_round_rate", "_determine_rate")

    // Change rate to req->rate; also change occurrences of 'return XXX'.
    @ chg_rate depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    identifier ERR =~ "E.*";
    expression E;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    (
    -return -ERR;
    +return -ERR;
    |
    - return rate_param;
    + return 0;
    |
    - return E;
    + req->rate = E;
    +
    + return 0;
    |
    - rate_param
    + req->rate
    )
    ...>
    }

    // Coccinelle only transforms the first occurrence of the rate parameter
    // Run a second time. FIXME: Is there a better way to do this?
    @ chg_rate2 depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    - rate_param
    + req->rate
    ...>
    }

    // Change parent_rate to req->best_parent_rate
    @ chg_parent_rate depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    (
    - *parent_rate_param
    + req->best_parent_rate
    |
    - parent_rate_param
    + &req->best_parent_rate
    )
    ...>
    }

    // Convert the function definition from round_rate() to determine_rate()
    @ func_definition depends on chg_rate @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    identifier generate_name.new_name;
    @@

    - long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
    -               unsigned long *parent_rate_param)
    + int new_name(struct clk_hw *hw, struct clk_rate_request *req)
    {
        ...
    }

    // Update the ops from round_rate() to determine_rate()
    @ ops depends on func_definition @
    identifier has_round_rate.round_rate_name;
    identifier generate_name.new_name;
    @@

    {
        ...,
    -   .round_rate = round_rate_name,
    +   .determine_rate = new_name,
        ...,
    }

Note that I used coccinelle 1.2 instead of 1.3 since the newer version
adds unnecessary braces as described in this post.
https://lore.kernel.org/cocci/67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com/

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (7):
      drm/msm/dsi_phy_10nm: convert from round_rate() to determine_rate()
      drm/msm/dsi_phy_14nm: convert from round_rate() to determine_rate()
      drm/msm/dsi_phy_28nm_8960: convert from round_rate() to determine_rate()
      drm/msm/dsi_phy_28nm: convert from round_rate() to determine_rate()
      drm/msm/dsi_phy_7nm: convert from round_rate() to determine_rate()
      drm/msm/hdmi_phy_8996: convert from round_rate() to determine_rate()
      drm/msm/hdmi_phy_8998: convert from round_rate() to determine_rate()

 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c      | 18 ++++++-------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c      | 36 +++++++++++++------------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c      | 22 +++++++--------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c | 34 ++++++++++++-----------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c       | 18 ++++++-------
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c        | 19 +++++++------
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c        | 19 +++++++------
 7 files changed, 84 insertions(+), 82 deletions(-)
---
base-commit: b551c4e2a98a177a06148cf16505643cd2108386
change-id: 20250710-drm-msm-phy-clk-round-rate-ccb10d54e804

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


