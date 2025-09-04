Return-Path: <linux-kernel+bounces-800575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0E7B4397C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50843B1219
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27C02FC00E;
	Thu,  4 Sep 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5nZ5Nuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F32A2FB63D;
	Thu,  4 Sep 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983874; cv=none; b=EGyPqyJbWIgnkHtNSuEmbSgipK8bv4cWQ6r0PKwFaJ0MQ3rYrQFpsddLPWtTPuTWmJ1Le4kOrc6qeVo66q38a30EmXqHSTOrAEP1NkM1/X5/UbfD5jzZfU2axFgyKd2xU/eXRKQQK0Em5LXwYpS/765j5aDHeZVBmvDlLdOLUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983874; c=relaxed/simple;
	bh=gZrdc2XAuoGO07YrW/d2XCXm0nua7N2x6yXGw6uJSFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uE44124IIKKTRc8F4WVTtyJGH5SlJ4I0hZaH1rq7lIu6tRDz0iS4/6WxXtyOSq4zwyUKQf9bmdlMGk42xM9CZUW+qYY419YNJTzg5dhdOxIDubd2mSLpEwL7p7HGGnBJGz91XX6IMf4AcJNukzNgDuiWpvnKifOpLuiNGjearMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5nZ5Nuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0192AC4CEF0;
	Thu,  4 Sep 2025 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756983873;
	bh=gZrdc2XAuoGO07YrW/d2XCXm0nua7N2x6yXGw6uJSFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u5nZ5Nuw7uG1NigAlPZqPweeFwAkjzTaWIj2XyrrBuZC5bFDSfUDUj3W+Fx3fAZdS
	 lo0AF8Z7fH/gEFEguGfGRV3b37M4ePvOIO0bgUxW2RB33KmjCRlr+fs72pGD+W/PRy
	 D61A7MSJez94CfOnjiD87phisk1nVNHg5NLSv2Q7aq7ZNgMv/XkJp9rMy5nsggPUI6
	 /jDoHVyPFfEYzYsvu8dNemFouSL7pz7BJZV66VihCv/YaVV5Cz9i8Sg7EfRwrPyqwY
	 U0T2/kB4DhHFiWgw1qov4Ip7Uuw8UYrFL6f4wzd9mo05aO9H0CaawZ6CIzCNH/jcVr
	 QYZzkGa2W71ng==
Message-ID: <e2c40d56-e0aa-45fa-958d-97dcf4f92a6c@kernel.org>
Date: Thu, 4 Sep 2025 13:04:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] This patch adds a new DRM bridge driver for the
 Lontium LT9611C chip.
To: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang <syyang@lontium.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250903123825.1721443-1-syyang@lontium.com>
 <20250903123825.1721443-3-syyang@lontium.com>
 <24rahlm4kkob7knapdxxnjixye3khx3nv2425y4kkirat4lmam@gjey7zqsnzks>
 <CAFQXuNZUfAJe4QEDfi+-1N99xO0_z5_Omnsn_-SXr2QPtvdL_g@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAFQXuNZUfAJe4QEDfi+-1N99xO0_z5_Omnsn_-SXr2QPtvdL_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2025 12:48, 杨孙运 wrote:
>>> +
>>> +static void lt9611c_cleanup_resources(struct lt9611c *lt9611c)
>>> +{
>>> +     struct device *dev = lt9611c->dev;
>>> +
>>> +     if (lt9611c->work_inited) {
>>> +             cancel_work_sync(&lt9611c->work);
>>> +             lt9611c->work_inited = false;
>>> +             dev_err(dev, "work cancelled\n");
>>
>> Why???
>>
> ?? I don't understand.

You need to explain why that line - printing error - should be here. And
focus on "WHY" part.

> 
>>> +     }
>>> +
>>> +     if (lt9611c->bridge_added) {
>>> +             drm_bridge_remove(&lt9611c->bridge);
>>> +             lt9611c->bridge_added = false;
>>> +             dev_err(dev, "DRM bridge removed\n");
>>> +     }
>>> +
>>> +     if (lt9611c->regulators_enabled) {
>>> +             regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
>>> +             lt9611c->regulators_enabled = false;
>>> +             dev_err(dev, "regulators disabled\n");
>>> +     }
>>> +
>>> +     if (lt9611c->audio_pdev)
>>> +             lt9611c_audio_exit(lt9611c);
>>> +
>>> +     if (lt9611c->fw) {
>>
>> You definitely don't need firmware when the bridge is up and running.
>>
> The previous text has already described the working logic of the firmware.
> 
>>> +             release_firmware(lt9611c->fw);
>>> +             lt9611c->fw = NULL;
>>> +             dev_err(dev, "firmware released\n");
>>> +     }
>>> +
>>> +     if (lt9611c->dsi0_node) {
>>> +             of_node_put(lt9611c->dsi0_node);
>>> +             lt9611c->dsi0_node = NULL;
>>> +             dev_err(dev, "dsi0 node released\n");

Your driver is way, way to noisy.

Please read coding style - what does it say about driver being silent?


Best regards,
Krzysztof

