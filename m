Return-Path: <linux-kernel+bounces-791948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56E1B3BE84
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D41F1763AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4633F217654;
	Fri, 29 Aug 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mc1/r0xB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7692116E9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478975; cv=none; b=ADtpGzFUMkKQNxlSL04ERhWn1ath262VbWR+K/RkrfDwD4owBR6BWQBqQa6DdMpxYqc8QL5lXBHOlg3N3BjyawvSlTB1Gq9cPvo1SaYaDbOl7wq8RCdGI0nEo83bPTaFfpyNv4fwwDoEF0vAc1f7q0nxv53T9YR2TFyukL0MhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478975; c=relaxed/simple;
	bh=WL89je6DiiHJ8zm1KAPw9gHwmNQbwHiX8qux5ytnaN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkGIjg40eJUBlb7izXXEogSOsOkwSe/GsdNf4ouHx5tedeYHszeNzxmEFI2iwedQ1G3VkgUVduYsjp2uF/G7AYE6hIdcjYvRMSzFy7bgps+I+X3MWlyNci3239+I8+pIavQCSsfiHWVb0k7v8T53FbvkVGJCS9bMak//vrxhwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mc1/r0xB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756478973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/Pipyb1To1Nv+/AeyJWgr3lnBnGQR9EAX0GXEeG6L4=;
	b=Mc1/r0xBjOuhEPhQHGPt0eETb7RkFqZyCCIB4z4HAiCjk9BcVzSuaF/NhheEavAXUlhfNf
	qIooCgLGQyQGbUkK7SOWIM2AMa6S4jjLpI6HxOvO0gJvchih/PELyYwlcGbb2jwqTGTxRV
	B2tKhos2HFRIAHXcYNFBLRIW7/av0Xw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-auVmEHmVPW2ZCpfzvdh58g-1; Fri,
 29 Aug 2025 10:49:30 -0400
X-MC-Unique: auVmEHmVPW2ZCpfzvdh58g-1
X-Mimecast-MFC-AGG-ID: auVmEHmVPW2ZCpfzvdh58g_1756478968
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 435261800446;
	Fri, 29 Aug 2025 14:49:28 +0000 (UTC)
Received: from [10.45.224.190] (unknown [10.45.224.190])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A06830001B5;
	Fri, 29 Aug 2025 14:49:23 +0000 (UTC)
Message-ID: <e7a5ee37-993a-4bba-b69e-6c8a7c942af8@redhat.com>
Date: Fri, 29 Aug 2025 16:49:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] dpll: zl3073x: Implement devlink flash
 callback
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250813174408.1146717-1-ivecera@redhat.com>
 <20250813174408.1146717-6-ivecera@redhat.com>
 <20250818192943.342ad511@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250818192943.342ad511@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Jakub,

On 19. 08. 25 4:29 dop., Jakub Kicinski wrote:
> On Wed, 13 Aug 2025 19:44:08 +0200 Ivan Vecera wrote:
>> +	struct zl3073x_dev *zldev = devlink_priv(devlink);
>> +	struct zl3073x_fw_component *util;
>> +	struct zl3073x_fw *zlfw;
>> +	int rc = 0;
>> +
>> +	/* Load firmware */
> 
> Please drop the comments which more or less repeat the name
> of the function called.

Will do.

>> +	zlfw = zl3073x_fw_load(zldev, params->fw->data, params->fw->size,
>> +			       extack);
>> +	if (IS_ERR(zlfw))
>> +		return PTR_ERR(zlfw);
>> +
>> +	util = zlfw->component[ZL_FW_COMPONENT_UTIL];
>> +	if (!util) {
>> +		zl3073x_devlink_flash_notify(zldev,
>> +					     "Utility is missing in firmware",
>> +					     NULL, 0, 0);
>> +		rc = -EOPNOTSUPP;
> 
> I'd think -EINVAL would be more appropriate.
> If you want to be fancy maybe ENOEXEC ?

OK, will use -ENOEXEC.

>> +		goto error;
>> +	}
>> +
>> +	/* Stop normal operation during flash */
>> +	zl3073x_dev_stop(zldev);
>> +
>> +	/* Enter flashing mode */
>> +	rc = zl3073x_flash_mode_enter(zldev, util->data, util->size, extack);
>> +	if (!rc) {
>> +		/* Flash the firmware */
>> +		rc = zl3073x_fw_flash(zldev, zlfw, extack);
> 
> this error code seems to be completely ignored, no?

Yep, you are right, this should be propagated to the caller.

>> +		/* Leave flashing mode */
>> +		zl3073x_flash_mode_leave(zldev, extack);
>> +	}
>> +
>> +	/* Restart normal operation */
>> +	rc = zl3073x_dev_start(zldev, true);
>> +	if (rc)
>> +		dev_warn(zldev->dev, "Failed to re-start normal operation\n");
> 
> And also we can't really cleanly handle the failure case.
> 
> This is why I was speculating about implementing the down/up portion
> in the devlink core. Add a flag that the driver requires reload_down
> to be called before the flashing operation, and reload_up after.
> This way not only core handles some of the error handling, but also
> it can mark the device as reload_failed if things go sideways, which
> is a nicer way to surface this sort of permanent error state.

This makes sense... The question is if this should reuse existing
.reload_down and .reload_up callbacks let's say with new devlink action
DEVLINK_RELOAD_ACTION_FW_UPDATE or rather introduce new callbacks
.flash_update_down/_up() to avoid confusions.

Thanks,
Ivan


