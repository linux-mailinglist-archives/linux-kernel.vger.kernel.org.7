Return-Path: <linux-kernel+bounces-830682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A08B9A4B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A2E7A3916
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F35B308F2C;
	Wed, 24 Sep 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHbdYRLD"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A3347C7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724735; cv=none; b=AtaF/bCtJTeLpqMHzn6ofRV7+tiIzAmQOeMRqw5VaLP/yyYiUBV1HS6qtuR+xV4hrIASrvUSUNTB40R+lgWawxTYyq3Cd+Jikvy2I5A7rg7fDo5bytgJlxfDf8AmXuzIQC9EI+tZTIkoCyYm4qyan7+4X+o1RCYWrBqOhiSs4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724735; c=relaxed/simple;
	bh=rQERvq3LxAL3olY++7GUnxakKNlgdaqYdzu+Pq/Vls4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfg9CIM60ylKQXlH7IbBnN2uK4dkZkL1qrSaann9+RBqfDdaIfVfPxnygyfn87GVaNSAK2wcW5TCDegWi8lqoHQ1sdYeXWG1TwTJGYOKQV2BND3t46Qs4RNHi9n3uOaIaIekgIPjuy1In5k7hMamqByJMlesGfjRB62XunISmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHbdYRLD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32bb1132c11so810240a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724733; x=1759329533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHey/5DHcQEnqAp7YgPLfHFFCB1Ord5+8bM01gUQSRM=;
        b=VHbdYRLDHOfm1us49LXbS43lflElJmmEco7nFhDQ97YcLzuomZizwE+u/PMSnWbSQ0
         giTAhNFH9dcbN3ToW4qzskWF1KGmaWGbZko3OpN77V2oDGJ+iltkYvAsMnUWq3xIvcpm
         BHMA0qHvTj6ERTk2ARk+QnWLAN6q2IKp5qkmeNJWKHJMqEl0zRtHRvrdd3P+a3kMewY6
         MsaTp1Gfhnw+tS+vGyyNG1u7ggKfJQJ8Cck+qOnVgc08FvCKZ0pGe13XudQF7KCPZBn1
         0/pkZUu4qNfGhxlvwFNMivrrhCktAREIpi9w/kZy703ZLlXO02yiB133UdftpKV1zppH
         /o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724733; x=1759329533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHey/5DHcQEnqAp7YgPLfHFFCB1Ord5+8bM01gUQSRM=;
        b=KQMZP6oU9gsGyDqZMLA0v/5gUkWk+8O9AOASl2cAxViuU5m3DhM/e4gh+KaQDtaiSh
         9m1nL89p/VojnljULoMHQpW3KMHfULhag9t+Iy2aG113e9xFoQWD1zck+dvl+7D0OEPy
         vTs0SaljjB+7KVef0WrLppdT1UDQp6IJ0g7o6dqBaRCq6+zHfi+IA32I5hmI0V6H1aV2
         Oljj7AEmRuui6q3uaxxNL1ci8kerrvdmafiqTMacryIRlQmocsgAvq+cJMjRIB/XBQnK
         fWejWZtfbhjusV/6AKp/OKlOo+evF/+zinTxF8RyCXVmmEZo5Q4u9XHjaZrFK/0TAEIW
         GoKA==
X-Forwarded-Encrypted: i=1; AJvYcCWYo92PZefXC95o5e5bUNbE6NEMFSzOEu6ezqN6zD3RPrkWc7J9xs4KU+mSXVITcElXw22udG23qSBsEn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6o8DpeyHGyCm1IxHeUdIw1D3IC4mjkDgSrYU5MvF5yukO/ce
	dPKPR9g6oQ3Sd0RgB2N+j8Ui7g3yWy29t4xYqK6P0cnawOLadDTulrpHwTSovju8
X-Gm-Gg: ASbGncuwOCXb72ChGG0Lwta5/qtk4l+I5ubLB0aGoDUQPlTN5S4Hn4gxxNoFbFKMsIg
	pH10xpcpTlocZRSjHiTc9sOyLc+Hd/Nvs+oQe6DeSVh5OH+L+eOhfHDxlTO9j4SLLd2iwG5GT1o
	Lgy7huE4O+mtXJdCbto97HTmyd4I66CZrYdYtKsy4AyKxrbnvObQ0rtN1/zcci/FgxTlYEAtV+D
	3NpMooRSoG5WI7qnjt3ZMKCYxay8cAXqqFe/eODTy/W+YweT+AQMGbZ8e4NE/mhP+3nfQYZ+iBc
	NtfOLU9c7CIAy6v2MrumnxJybd9/FSjNMG9kls4budawbWIKj2ybWyDlvBSHkl9w7rDvZ3zKBIx
	SnUwHCYjvWYt0ZiG7N1fyQ9fokrqiZfp1/w8=
X-Google-Smtp-Source: AGHT+IHSjKFW99tQBIV9uMHLuecEJfRlBOsf5ME3SjzE6fe7svS7Oz6A7dO7dcM33tP4xiTiSQEfsQ==
X-Received: by 2002:a17:90b:1dc9:b0:32b:a311:d1ae with SMTP id 98e67ed59e1d1-3341bfdc9b2mr3219424a91.10.1758724732781;
        Wed, 24 Sep 2025 07:38:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-332a9d48fa8sm2338760a91.11.2025.09.24.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:38:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:38:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com, zhanjun@uniontech.com,
	Chenx Dust <chenx_dust@outlook.com>
Subject: Re: [PATCH] hwmon: (gpd-fan) Fix range check for pwm input
Message-ID: <c0364b38-bd9a-4ff4-ad31-4c75160e307f@roeck-us.net>
References: <20250919-hwmon-v1-1-2b69c8b9c062@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-hwmon-v1-1-2b69c8b9c062@uniontech.com>

On Fri, Sep 19, 2025 at 04:38:49PM +0800, Cryolitia PukNgae wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> Fixed the maximum value in the PWM input range check, allowing the
> input to be set to 255.
> 
> Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
> Reported-by: Chenx Dust <chenx_dust@outlook.com>
> Link: https://github.com/Cryolitia/gpd-fan-driver/pull/18
> Co-developed-by: Chenx Dust <chenx_dust@outlook.com>
> Signed-off-by: Chenx Dust <chenx_dust@outlook.com>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Applied.
Guenter

