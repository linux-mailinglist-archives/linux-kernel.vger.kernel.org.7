Return-Path: <linux-kernel+bounces-873015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4DC12D66
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9DE463753
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC562882AF;
	Tue, 28 Oct 2025 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bAPvYg4G"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3922236E9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761624323; cv=none; b=nK/Znju+6zrUAJ4iyRtulJMTdxsL+UbkmFUXRGeP6jtPWqSc+RjgD1Vg0++2F5ABVAsZ+1xCU1eUDpnejt/FGfkFxxtAWjDHwHnxo9APlfkSYHZyhn9iUjKcSLtftzHcQTWyUIzHOLII8ci0DVRbheoHWkcX5t5Sgnz8UsbKyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761624323; c=relaxed/simple;
	bh=Nfsq+JtkBw9KVVTd9umdC+x300tX0xxu2EiJF7U4ess=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZtGP2XGOqR/NICa26f6fmzSiK4LqHyrc5LcpCWa8VKLC0MBf4WygpdINBgiv42l+vaEJvbnBJq+fuEYL1HD9wIspGuHqH9K8SWqUml28ZMIiGX9gaaXDbMuSpyHQm2pAnwRlolE1Mfz3I7oSbcH97Bde78jfdKEWaa1ml9RY0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bAPvYg4G; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6679610e-0e8f-43bb-a994-b9949e636b8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761624309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6p99fq4+aDu3NTN4hgnbdTua/gnvTFt7Efn6aq9U9xs=;
	b=bAPvYg4GM8fKkx3FypH717P+5CrENSFEGrtWgvzwgxJQ9wtzrBzzD1V1+HKwu8QZ4+e3Jx
	aKxwFguUc/Ld0+3hhEhqIH1VSOoYe/RjISA+znjK4Rt4Tr/0P5kJeSsEDtVypqjCxvBYfa
	iJWnCxrLd8iq/I7YhczzFzcolGTJZxI=
Date: Tue, 28 Oct 2025 12:04:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 13/24] smb: move FILE_BOTH_DIRECTORY_INFO to
 common/smb1pdu.h
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org,
 christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251027071316.3468472-14-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd-Jh2ucT5E8p5=jbU5NSrsejGUn2-DJb8-mzrERQcSGBQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAKYAXd-Jh2ucT5E8p5=jbU5NSrsejGUn2-DJb8-mzrERQcSGBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

OK, I’ll try to create a new common/fscc.h.

On 10/28/25 11:39 AM, Namjae Jeon wrote:
> On Mon, Oct 27, 2025 at 4:15 PM <chenxiaosong.chenxiaosong@linux.dev> wrote:
>>
>> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>>
>> Rename "struct file_both_directory_info" to "FILE_BOTH_DIRECTORY_INFO",
>> then move duplicate definitions to common header file.
>>
>> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> file information classes are defined in ms-fscc specification.
> So we can move them to fscc.h. Please check other your patches also.

-- 
Thanks,
ChenXiaoSong.


