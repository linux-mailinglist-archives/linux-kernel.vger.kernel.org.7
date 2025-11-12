Return-Path: <linux-kernel+bounces-896413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AC1C504E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24513189A30C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EDF296BDB;
	Wed, 12 Nov 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XQDv60WS"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688C735CBA1;
	Wed, 12 Nov 2025 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913346; cv=none; b=oPyuTV3AM+cZhRdfiEQvjPEHA/4C6LcMBWc5sEmW1XoRAOrjXegUiXcq0YDlPWqfxGVJhs1qzdQgKeh/Q3kVec9if/hm35XWFIOdgMc+s/vZqegMuOygnt7V44KDjrwrgW9HormeBKJEMqf+zUl38WSX0PLUAR524hARDEtCrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913346; c=relaxed/simple;
	bh=c0pRtdfq7/UyLUqHpJItuXxtHKswo3QtIc94dqkHOP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tlhJ5i2zzPCV7oHSFoK3PFWYquC7XysEkr6FtepBg5eaTh/65VcwWleXsJHowjZT5sJdm1+De8Psi5jl3jyYBkh1+lC69PgebTbaRiWW74HnbjDQ7KCIuRfVpRqIbMnLZuA/BHuiAsHwFjEErTfFOQIy2+NRj6RR4krpLBjlTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XQDv60WS; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=k+lEIps3Ad061Y0
	N1VRIN9ZMFcrkNkF438I6q5gvkHI=; b=XQDv60WS1xaWYlQGHxcj4j1KqR5TC22
	m8a0NnKvG45xg50vBduHA24Cmte5qxD1Tb/YkN37UWWaNJ9+3m0YbZDaaHR2SuLV
	NTuIyKBbZiAm4SQfVRgudxy8APHD72513ldSwOLgaW9LNbbu6nTr0POQtlo2yL4f
	hjBQt00e1eRk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCHe7kL7BNp5ws4DQ--.143S2;
	Wed, 12 Nov 2025 10:08:13 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: robh@kernel.org
Cc: christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	jdelvare@suse.com,
	krzk+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	wenliang202407@163.com
Subject: Re: [PATCH 1/8] dt-binding:ti,ina3221:Add SQ52210
Date: Tue, 11 Nov 2025 21:08:02 -0500
Message-Id: <20251112020802.103963-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <176285353822.2206360.4224721052880001451.robh@kernel.org>
References: <176285353822.2206360.4224721052880001451.robh@kernel.org>
X-CM-TRANSID:_____wCHe7kL7BNp5ws4DQ--.143S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw18JFW7tr47JF1fCry8Xwb_yoW8Ww4kp3
	yrCF90vrZ8Wr13JwsxtrZ2kFyYqws3tayIqr1UGF42vF15XFyaq3ySg39Y9F1UKrWfC345
	Za109w1xK34jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JjTZXrUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/xtbCvw9dMWkT7A8nigAA3o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

At 2025-11-11 17:32:18, "Rob Herring (Arm)" <robh@kernel.org> wrote:
>
>On Tue, 11 Nov 2025 03:05:39 -0500, Wenliang Yan wrote:
>> Add a compatible string for sq52210, sq52210 is forward compatible
>> with INA3221 and add alert register to implement four additional
>> alert function.
>> 
>> Signed-off-by: Wenliang Yan <wenliang202407@163.com>
>> ---
>>  .../devicetree/bindings/hwmon/ti,ina3221.yaml    | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>> 
>
>My bot found errors running 'make dt_binding_check' on your patch:
>
>yamllint warnings/errors:
>
>dtschema/dtc warnings/errors:
>/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml: alert-type: missing type definition
>
>doc reference errors (make refcheckdocs):
>
>See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251111080546.32421-2-wenliang202407@163.com
>
>The base for the series is generally the latest rc1. A different dependency
>should be noted in *this* patch.
>
>If you already ran 'make dt_binding_check' and didn't see the above
>error(s), then make sure 'yamllint' is installed and dt-schema is up to
>date:
>
>pip3 install dtschema --upgrade
>
>Please check and re-submit after running the above command yourself. Note
>that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>your schema. However, it must be unset to test all examples with your schema.

I apologize that my configuration error prevented these issues from being detected during runtime.
I will update the tools and retest before the next submission.

Thanks,
Wenlaing Yan


