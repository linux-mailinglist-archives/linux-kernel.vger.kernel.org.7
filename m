Return-Path: <linux-kernel+bounces-725433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB4CAFFF12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558AB1C86F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5162D1309;
	Thu, 10 Jul 2025 10:17:40 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690D2AEF1;
	Thu, 10 Jul 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142660; cv=none; b=qevfmPOuyIaMPCb6cqWfLfCVzfIV4SGcq98xslfNAqLMKWJCe+vl/cB2dUQFYe+EkgI2TDE1OqTPtDwvBLpet4qjKUzBMMsMa4WZ826NGQBCNrCGUejbu2xAMDy80FzK5doNQ99eDigt+52V0w9+15pp1O7PdptrnqH4Z3D4bbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142660; c=relaxed/simple;
	bh=0kuM5VXy8y+tTqVrYFr4WFguC9X1xGj+r/Gma6OEsrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oilKZd00Q1M0iPdAG3dzvJduJDwyDIcsvWvhNRptye9taIpu3TU7FHEjV5fXAvtslUevLjtWTyzqTX+q8bPM2QPZN4NvL9HuS8w7CuF6Beib1GooajWYj3P8Ka8dP/E1VSgFE4VpRc2b6TmrCWueWXZi1GJKLzH9lAqtwInR22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56AAHIZf025376;
	Thu, 10 Jul 2025 19:17:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56AAHI2e025372
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Jul 2025 19:17:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a8bed564-3eec-472d-8e57-aaf5274c13b1@I-love.SAKURA.ne.jp>
Date: Thu, 10 Jul 2025 19:17:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <686e7698.050a0220.c28f5.0006.GAE@google.com>
 <79f634db-c149-4220-b8d4-0fff2c6b6a01@I-love.SAKURA.ne.jp>
 <e064a3e4-ae70-4a24-ba5e-1bb8c7971f23@rowland.harvard.edu>
 <39f312fa-d461-4377-b809-50c8a7188f6b@I-love.SAKURA.ne.jp>
 <dd932df4-2a13-4a5c-a531-376065f87391@rowland.harvard.edu>
 <43189e93-2cad-429a-a604-15bf5cc95e43@I-love.SAKURA.ne.jp>
 <1d471e25-6671-4cb2-a2c9-af96c2b4e13d@rowland.harvard.edu>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1d471e25-6671-4cb2-a2c9-af96c2b4e13d@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/10 0:41, Alan Stern wrote:
> Okay, I see what your problem is.
> 
> The bEndpointAddress field of the endpoint descriptor is not just the 
> endpoint's number.  It also includes the endpoint's direction in bit 7 
> (0 for OUT, 1 for IN).

I see, but I couldn't figure out whether BUG_ON(endpoint > 0xF) is bad.

I came up to try these BUG_ON() lines in case some of hung task reports (e.g.
https://lkml.kernel.org/r/686e8032.050a0220.385921.0006.GAE@google.com ) are
caused by use of unintended pipes created by out-of-range values being passed
to __create_pipe().

Should I give up BUG_ON(endpoint > 0xF) line?
Or should I try to update callers which trigger BUG_ON(endpoint > 0xF) line?


