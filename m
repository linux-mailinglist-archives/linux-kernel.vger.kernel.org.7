Return-Path: <linux-kernel+bounces-852830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEC3BDA057
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E58F3B39A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F902D7D41;
	Tue, 14 Oct 2025 14:33:16 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD192BDC13
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452396; cv=none; b=afOj6+5ChEFvVchNEvw0X1tgIZbxYFnctuE6b5DUAzDp39gTCSI7LwzJ+nWmY44S/VdneXFlllicd7L9QL/5IFSVBnsIlMXDCmkUK7qyfDCJlu4z0JQOcTsVw/HKrcPKWfn4N1+AUCJ8uwpUGRfFXfapaDkDvPM6SSVsGMEOgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452396; c=relaxed/simple;
	bh=G/6KdXu31T1VAui/RJwqf6i/24VbdcZQazuZ9wjU2fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OmRfJRDqr9bCH72P/7RpHezo2Gcy8YivtxQWPXYKxCqVCQb7ROTr05iQbJGihTjTF9RnFxfEm0mr8Q+CH0YnUjonaHcc8Saa8d6ncWO0wS6xXWYY2xyvylKCtnIpwT+3Owjur5lM+g8jieapJo9vop2buRwk7fW2y+0RbqrJowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59EEX9fU098047;
	Tue, 14 Oct 2025 23:33:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59EEX9ve098044
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 Oct 2025 23:33:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3ee9de25-9a65-4945-8049-0df6fcd389aa@I-love.SAKURA.ne.jp>
Date: Tue, 14 Oct 2025 23:33:09 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [udf] WARNING in invalidate_bh_lru
To: syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org
References: <000000000000eccdc505f061d47f@google.com>
 <000000000000af5c290612ac6d86@google.com>
 <20240311093258.2oc6siuzmntx5jqk@quack3>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240311093258.2oc6siuzmntx5jqk@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp

#syz fix: fs: Block writes to mounted block devices


