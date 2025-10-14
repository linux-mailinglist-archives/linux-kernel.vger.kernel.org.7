Return-Path: <linux-kernel+bounces-852018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B51BD7F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B64694E68B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4F2D9EF6;
	Tue, 14 Oct 2025 07:35:25 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834EA23D7FF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427325; cv=none; b=fSQzkEKLGjLEpcy+MLnB4YMorXAufRzU+J3S3wRNXnGtjunxh1qL+VfSOWjYdqJOQQVtGAhn+DbN8Jpub3tIOF2EJQ+7diMR+/iH3xqDRlNfpKy+ECDEBXJ+8B2cjVtURQp6RDt3dhyzbfJpEKLRq3rypmtFDzA4066eAdqH720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427325; c=relaxed/simple;
	bh=TUtlvdhh7flhiNzMhnhYJ96fxiYTQQPcDY/zfcVT2WE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oExRYU1XiARqSiMpzfTkFvNHgYpHm0XGDHJvpwQLt1F5U3tRxQCMWhOvLixS0p2csBDHEOfpfA8QkkE5xFR97TJBk6OrintwiGTe4TzzFPrXWaiVB7iXGdBT958zoy3lpEUdwbtUQ3E6wGMpP9+4njOjaJNWOf0va8i11ljs+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201613.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202510141535171565;
        Tue, 14 Oct 2025 15:35:17 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201613.home.langchao.com (10.100.2.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 14 Oct 2025 15:35:16 +0800
Received: from inspur.com (10.100.2.96) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 14 Oct 2025 15:35:16 +0800
Received: from localhost.localdomain.com (unknown [10.94.17.151])
	by app1 (Coremail) with SMTP id YAJkCsDwEnYz_e1o7SIXAA--.535S4;
	Tue, 14 Oct 2025 15:35:15 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <jani.nikula@linux.intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: Re: Re: Re: [PATCH v8 1/1] [DRIVER] gpu: drm: add support for YHGCH ZX1000 soc chipset
Date: Tue, 14 Oct 2025 15:34:46 +0800
Message-ID: <20251014073446.4549-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <9ab159073b644c83541e4782c30ae9900b0f27d4@intel.com>
References: <9ab159073b644c83541e4782c30ae9900b0f27d4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: YAJkCsDwEnYz_e1o7SIXAA--.535S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1rWF1UZr4fXrWfCw1Utrb_yoW8KryDpF
	yUCFWxCrW8tw45Cwn0v3WjvFnIy39xKF10qw4UWw1UGr1qvr9rZF4kJr1UWFy8CrWDJF4j
	v3WDXF43AF1Yk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUU
	UU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?fCDn3JRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KQyQoFzKlaM2ttcAX/HZpVo84+3O2tb1DiGSsiU9dN6FRurHi71v1tBU8sQDLmd7rOm4
	S3A6ft5o25+AJuRXN3s=
Content-Type: text/plain
tUid: 202510141535175dddae4cc9251d1e69d8051945ee1311
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Hi Jani,

> On Sat, 11 Oct 2025, Chu Guangqing <chuguangqing@inspur.com> wrote:
>> Hi Jani,
>>
>>On Mon, 29 Sep 2025, Chu Guangqing <chuguangqing@inspur.com> wrote:
>>>> diff --git a/drivers/gpu/drm/yhgch/yhgch_drm_vdac.c b/drivers/gpu/drm/yhgch/yhgch_drm_vdac.c
>>>> new file mode 100644
>>>> index 000000000000..2e222af29f69
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/yhgch/yhgch_drm_vdac.c
>>>> @@ -0,0 +1,134 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +#include <linux/io.h>
>>>> +
>>>> +#include <drm/drm_atomic_helper.h>
>>>> +#include <drm/drm_edid.h>
>>>> +#include <drm/drm_probe_helper.h>
>>>> +#include <drm/drm_print.h>
>>>> +#include <drm/drm_simple_kms_helper.h>
>>>> +
>>>> +#include "yhgch_drm_drv.h"
>>>> +#include "yhgch_drm_regs.h"
>>>> +
>>>> +static int yhgch_connector_get_modes(struct drm_connector *connector)
>>>> +{
>>>> +	int count;
>>>> +	const struct drm_edid *drm_edid;
>>>> +
>>>> +	drm_edid = drm_edid_read(connector);
>>>> +	if (drm_edid) {
>>>> +		drm_edid_connector_update(connector, drm_edid);
>>>
>>>You're supposed to do drm_edid_connector_update() even for NULL edid to
>>>reset it.
>>>
>>>BR,
>>>Jani.
>>>
>>
>> I add an else here to make the call.
>
>Please follow the same/similar pattern as pretty much everyone else is
>doing:
>
>	drm_edid = drm_edid_read(connector);
>	drm_edid_connector_update(connector, drm_edid);
>
>	if (drm_edid) {
>		count = drm_edid_connector_add_modes(connector);
>		drm_edid_free(drm_edid);
>	}
>
>BR,
>Jani.
>

The changes have been made; please refer to the link below.
https://lore.kernel.org/all/20251014072421.4486-1-chuguangqing@inspur.com/

>>
>>>> +		count =  drm_edid_connector_add_modes(connector);
>>>> +		if (count)
>>>> +			goto out;
>>>> +	}
>>
>> -       }
>> +       } else
>> +               drm_edid_connector_update(connector, NULL);
>>
>>>> +
>>>> +	count = drm_add_modes_noedid(connector,
>>>> +				     connector->dev->mode_config.max_width,
>>>> +				     connector->dev->mode_config.max_height);
>>>> +	drm_set_preferred_mode(connector, 1024, 768);
>>>> +
>>>> +out:
>>>> +	drm_edid_free(drm_edid);
>>>> +	return count;
>>>> +}
>>>
>>>--
>>>Jani Nikula, Intel
>>>
>>
>> Best regards
>>
>> Gary
>>
>
>--
>Jani Nikula, Intel

Best regards

Chu Guangqing


