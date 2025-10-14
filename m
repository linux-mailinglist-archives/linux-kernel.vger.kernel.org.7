Return-Path: <linux-kernel+bounces-852351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D84BD8BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16C8C4FD24A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F62FA0F2;
	Tue, 14 Oct 2025 10:23:35 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B102F8BDF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437414; cv=none; b=cCsAX4BOVDQq7lYMIOLAzWJiLTg9e3MJUYildYNU7peRF1CI3nygb4mdeEldKijsQT9ZzjC0Jo4Nyqeh+diNp6u64p0E5CFaKj6KTdC6E2kmDts9gPLj7czkey1h98F+7QNyzuigLcU+mzTgsVWHGmrmr1Pf4aIPz4wdSaroqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437414; c=relaxed/simple;
	bh=d6qS3sMazyET5es1dfauU7Kfa9sZXLeTxfJ5kFAPT3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j9KENTiDEvoyam4ONiYgU3TY/lGYoIInklZkQODDrYXq2RJZK95ibHf4rWisjbQfX6sFrceJFRK/FKMcF9ZqnRnIbMn53CEgCfitfyVvXFVbkxBiZ4ZBsDB53ZzoQ3qiuTcp4oZjArl93bLUjsEgmPGgeCl6obm6hzwD/9qsMIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59EANLrs047411;
	Tue, 14 Oct 2025 19:23:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59EANFkH047371
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 Oct 2025 19:23:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9a3801d1-eead-4289-b324-a64153786236@I-love.SAKURA.ne.jp>
Date: Tue, 14 Oct 2025 19:23:15 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in dummy_timer (4)
To: syzbot <syzbot+879882be5b42e60d4d98@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org
References: <68ed353a.050a0220.ac43.003c.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <68ed353a.050a0220.ac43.003c.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp
X-Virus-Status: clean

#syz fix: media: imon: make send_packet() more robust

