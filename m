Return-Path: <linux-kernel+bounces-809242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C80B50A69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDDC3AB335
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A12153E7;
	Wed, 10 Sep 2025 01:44:39 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6F212550
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468679; cv=none; b=nOU1Fu4yhtU//DiQ3B1EED8VPjXAnCOtNAzdy6S04xqOz9gA19SRWrLIRZTgd5nXEbmLtnoZvc6+9xXBkhHx5Lvil8bs04khQcInWTvJ73oxMvjVGfINCQteSwmWwJNc0J5CXwq4n/1JWiZkN94Lk2o0kvRJRY4zxuD4MFaj4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468679; c=relaxed/simple;
	bh=i00BFgtIu6IdpJE7LsvCBK5BDWvu2nf2fWobmXdUGaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uST89IMPl+s4I0LD6PjyAkJx5rhAeoEkUxj77ezQ90/r6JXxVPTUSfuq5tbw+Xy/5xL6FAwF3D9fDWetQ+mGqalPihpK2VezPSHAIuNOzzbuff7qyuBj4Gxo4sPTJ1VU8YiZ+HrydpDeLZAAuvxKPzQyE+dhXP1A8B5ZMf+J0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee368c0d7f7d41-8a631;
	Wed, 10 Sep 2025 09:44:25 +0800 (CST)
X-RM-TRANSID:2ee368c0d7f7d41-8a631
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee868c0d7f6ae6-95c01;
	Wed, 10 Sep 2025 09:44:25 +0800 (CST)
X-RM-TRANSID:2ee868c0d7f6ae6-95c01
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com
Subject: Re: [PATCH] char: misc: Make the code for allocating minor in misc_register more concise
Date: Wed, 10 Sep 2025 09:44:20 +0800
Message-ID: <20250910014421.2837-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <2025090910-tactile-devourer-1070@gregkh>
References: <2025090910-tactile-devourer-1070@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> On Tue, Sep 09, 2025 at 04:58:35PM +0800, zhangjiao2 wrote:
>> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>>
>> There is no need to check the registered misc dev in misc_list.
>> If misc_minor_alloc failed, it meens the minor is already alloced
>> and the misc dev is linked in misc_list.
>>
>> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>> ---
>>  drivers/char/misc.c | 32 +++++++-------------------------
>>  1 file changed, 7 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
>> index a0aae0fc7926..fc2f5e8b2f95 100644
>> --- a/drivers/char/misc.c
>> +++ b/drivers/char/misc.c
>> @@ -211,6 +211,7 @@ int misc_register(struct miscdevice *misc)
>>  	dev_t dev;
>>  	int err = 0;
>>  	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
>> +	int minor = 0;
>>
>>  	if (misc->minor > MISC_DYNAMIC_MINOR) {
>>  		pr_err("Invalid fixed minor %d for miscdevice '%s'\n",
>> @@ -221,32 +222,13 @@ int misc_register(struct miscdevice *misc)
>>  	INIT_LIST_HEAD(&misc->list);
>>
>>  	mutex_lock(&misc_mtx);
>> -
>> -	if (is_dynamic) {
>> -		int i = misc_minor_alloc(misc->minor);
>> -
>> -		if (i < 0) {
>> -			err = -EBUSY;
>> -			goto out;
>> -		}
>> -		misc->minor = i;
>> -	} else {
>> -		struct miscdevice *c;
>> -		int i;
>> -
>> -		list_for_each_entry(c, &misc_list, list) {
>> -			if (c->minor == misc->minor) {
>> -				err = -EBUSY;
>> -				goto out;
>> -			}
>> -		}
>> -
>> -		i = misc_minor_alloc(misc->minor);
>> -		if (i < 0) {
>> -			err = -EBUSY;
>> -			goto out;
>> -		}
>> +	minor = misc_minor_alloc(misc->minor);
>> +	if (minor < 0) {
>> +		err = -EBUSY;
>> +		goto out;
>>  	}
>> +	if (is_dynamic)
>> +		misc->minor = minor;
>>
>>  	dev = MKDEV(MISC_MAJOR, misc->minor);
>>

> Does this pass the new test suite for the misc code allocation logic
> that we now have in the tree?  Or do we need to write a new test-case
> for this codepath?

 I didn't take this new test suite, can you do it for me? I don't think there's 
 a need to write a new test-case for this codepath. 

thanks,

zhang jiao



