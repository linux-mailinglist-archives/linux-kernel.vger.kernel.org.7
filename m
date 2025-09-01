Return-Path: <linux-kernel+bounces-794354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6AEB3E078
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D013A8131
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93530DD0D;
	Mon,  1 Sep 2025 10:41:29 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52A2494F8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723289; cv=none; b=NBPvebBfi9TzYmqPUhLzuBzSB/YzdUo09v1obWhp3BPPDPmrV4WfScOPV3OmhHsiUG7GMOPdoZBrspb0G0ODXatWw1XhdLW8FrTPafLGpMveO9uIWsCYldo80ln5mV7/q9bo/+UrTJUxM5t11y/nM/MOMmh+jIf2RJXzhGN7lFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723289; c=relaxed/simple;
	bh=G0FJP/BL+pbXzrJ1DOrMcqojaE1ArJ1TE/lGmNZcegI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZltmx9vmEKKLy1G7cmDZYDGQadSotMozSXWvDqoBuIZdwlyuMZTLxvN/duTazG9nNBLIuIeUCDfSydbhraO64UGgwTdxgtlINtl1DgXaOThHEyhfwCAGqrkEMo35StiLDcPqL8aUQ8YhQC54I2jmDQO1WIwBc8tN9LrEXz14YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id C647D43121;
	Mon,  1 Sep 2025 10:41:14 +0000 (UTC)
Message-ID: <93b9e1dc-f8d5-4b8d-a7d2-27ba8e09dd54@ghiti.fr>
Date: Mon, 1 Sep 2025 12:41:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/tests: modeset: Add drm connector
 atomic_[duplicate/destroy]_state
To: Xiaolei Wang <xiaolei.wang@windriver.com>,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250827084514.3364009-1-xiaolei.wang@windriver.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250827084514.3364009-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleduleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeeutdekteffiefhudfffeelhfehleeftdehuefhiefgudelfefgffefudeivddujeenucffohhmrghinhepphgrthgthhgvfidrohhrghenucfkphepudejiedrudegjedrudeghedrgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudejiedrudegjedrudeghedrgeegpdhhvghloheplgduledvrdduieekrddurdduheelngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopeigihgrohhlvghirdifrghnghesfihinhgurhhivhgvrhdrtghomhdprhgtphhtthhopegumhhithhrhidrsggrrhihshhhkhhovhesohhsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepjhgrnhhirdhnihhkuhhlrgesihhnthgvlhdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Xiaolei,


On 8/27/25 10:45, Xiaolei Wang wrote:
> Commit 66671944e176 ("drm/tests: helpers: Add atomic helpers")
> added the atomic state path, so adding the drm connector
> atomic_[duplicate/destroy]_state is also necessary.
>
> WARNING: CPU: 0 PID: 96 at drivers/gpu/drm/drm_connector.c:234 drm_connector_init_only+0x934/0xee0
>   Call trace:
>    drm_connector_init_only+0x934/0xee0 (P)
>    drmm_connector_init+0xe0/0x1b0
>    drm_client_modeset_test_init+0x290/0x534
>    kunit_try_run_case+0x110/0x3b4
>    kunit_generic_run_threadfn_adapter+0x80/0xec
>    kthread+0x3b8/0x6c0
>    ret_from_fork+0x10/0x20
>
> Fixes: 66671944e176 ("drm/tests: helpers: Add atomic helpers")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>
> v1: https://patchew.org/linux/20250811063403.98739-1-xiaolei.wang@windriver.com/
>
> v2: compared with v1, add Fixes tag
>
>   drivers/gpu/drm/tests/drm_client_modeset_test.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> index 3f44fe5e92e4..e702a27c2368 100644
> --- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
> +++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
> @@ -12,6 +12,7 @@
>   #include <drm/drm_modes.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_probe_helper.h>
> +#include <drm/drm_atomic_state_helper.h>
>   
>   struct drm_client_modeset_test_priv {
>   	struct drm_device *drm;
> @@ -48,6 +49,9 @@ static const struct drm_connector_helper_funcs drm_client_modeset_connector_help
>   };
>   
>   static const struct drm_connector_funcs drm_client_modeset_connector_funcs = {
> +	.reset                  = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state   = drm_atomic_helper_connector_destroy_state,
>   };
>   
>   static int drm_client_modeset_test_init(struct kunit *test)


Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


