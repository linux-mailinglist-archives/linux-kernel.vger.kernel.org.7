Return-Path: <linux-kernel+bounces-835263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80153BA69A8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAAC3AA75A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F53329B8EF;
	Sun, 28 Sep 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t7/i4ZTc"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEF287246
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759043534; cv=none; b=XG7HIj7oTtiNtX/5U+RfXG6X0BMLyCKSmvo5TQ3jEQiwp/sJQbsqV/nDlIE64ZVB0qXAcwHRnOxZr+duXNhP49iE3s0zNwxngXLRpUnLqL77oi/Z8P/vwL6UOis0tU8+ZWmMLpsiDN8Q6BmDLKlruRPXhAx9zSzObBIWR+tQFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759043534; c=relaxed/simple;
	bh=vuivaMvUxiIYVoLT6sVG8ShBVpGAyANeLDMtmKDyowI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfG3fcnOgKSyLPYkwdsiv/YftHtccdfK0nFbuQwdzf+G76MdlcZg935jJoxh4B44ptkRNxT18jbmCAm0A7bAGP7A00m2w7UVntkQOThmVxqK2QrSXvYJr2Pfje8/poktJpPGRtqW1xFtWji9/ENluF96dijGLt4omRZDMD9EJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t7/i4ZTc; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f7483f8-29bb-4caa-8978-2bdad0d46072@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759043530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tI6qHor2C/A9mqAelwnyQcCicuKGbTAFcFT0kA59dJM=;
	b=t7/i4ZTc3snGDHXmiWpnz8ReLmrv7UQY5doU/iNDZVCX2RlNEKvK+EykawQBlqcRUpXgKE
	z2hy5PK0Bpd0EOP/JFtjFwSuFsZ/o1jUiJKi1krhzDfAWs5JSX/W8NEmgnKTQgb0hMMa2+
	gL6VULOC+Rsjhyn/cbxtQqEMuxQKiTE=
Date: Sun, 28 Sep 2025 15:12:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdW3YyXSBodW5nX3Rh?=
 =?UTF-8?Q?sk=3A_Panic_after_fixed_number_of_hung_tasks?=
Content-Language: en-US
To: "Li,Rongqing" <lirongqing@baidu.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "mingo@kernel.org" <mingo@kernel.org>,
 "pauld@redhat.com" <pauld@redhat.com>,
 "joel.granados@kernel.org" <joel.granados@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>,
 "kees@kernel.org" <kees@kernel.org>, "paulmck@kernel.org"
 <paulmck@kernel.org>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>
References: <20250928053137.3412-1-lirongqing@baidu.com>
 <3c44a757-f823-4671-b3d5-548fe04e52e3@linux.dev>
 <d33ebade05ea45c2be47717fe1b812b8@baidu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <d33ebade05ea45c2be47717fe1b812b8@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/28 15:03, Li,Rongqing wrote:
>> On 2025/9/28 13:31, lirongqing wrote:
>>> From: Li RongQing <lirongqing@baidu.com>
>>>
>>> Currently, when hung_task_panic is enabled, kernel will panic
>>> immediately upon detecting the first hung task. However, some hung
>>> tasks are transient and the system can recover fully, while others are
>>> unrecoverable and trigger consecutive hung task reports, and a panic is
>> expected.
>>>
>>> This commit adds a new sysctl parameter hung_task_count_to_panic to
>>> allows specifying the number of consecutive hung tasks that must be
>>> detected before triggering a kernel panic. This provides finer control
>>> for environments where transient hangs maybe happen but persistent
>>> hangs should still be fatal.
>>>
>>> Acked-by: Lance Yang <lance.yang@linux.dev>
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>> ---
>>
>> It's working as expect. So:
>> Tested-by: Lance Yang <lance.yang@linux.dev>
>>
>> But on second thought: regarding this new sysctl parameter, I was wondering if
>> a name like max_hung_task_count_to_panic might be a bit more explicit, just to
>> follow the convention from max_rcu_stall_to_panic.
>>
> 
> I see that all the hung task sysctl parameters start with "hung_task"? Should we keep this convention? If so, we could name it "hung_task_max_to_panic". If not, we could call it "max_hang_task_to_panic"?

Well, let's see what other folks think ;)

