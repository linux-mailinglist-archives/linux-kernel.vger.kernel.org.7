Return-Path: <linux-kernel+bounces-722175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9104DAFD646
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580BE7AFF23
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F219821ABDB;
	Tue,  8 Jul 2025 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fe8WUe+5"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C321ABCB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998669; cv=none; b=tDb4/raMsgx1CVwhgJ/reZYxw/S3YpYSnrBGWfb8N+NZVDth8R+6bi0c0jsnIJ+et9nyPbErcnKLNSBy5+XBk4+3X3e/icnYWh4IKOm8YzRBwr4ow+rnKpXSEc4goKY9P9cLkHE2GSCChS8PfJq2On6s3suedA9qF0iA4t+hoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998669; c=relaxed/simple;
	bh=LpOkjb+ecQQBtOWkcVVUBt5c7MvC87zMsmyehH6sHDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgzCLI+PGk1h5BObZCWevtdEbfiZ9/RROWe0QNfvG9f+PRCldWClI8O73cOf3Uw2tP64TEczrI4wovMj1TUkIJLW8RgTAiq7Y2f2K91F5kSqGbn72qyuUDs8wMD+NbkEWPgQAdGgCza3/av4RLxE9lNk2UjKDiPmteFNeyQVKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Fe8WUe+5; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-875acfc133dso153382939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751998666; x=1752603466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7oks48muiKNQ9MQb0raKT3/XZo9cmEOj4qy77c9F8s=;
        b=Fe8WUe+5bI4LSraBHXz64gIq1Y6YQHak3Lbyk0xWGgqJewgRMwjkaAFEoiudlRA036
         eU7NMXRp2CCjCbB8HyiO1lMkXlDVFmvWXvkrvWpV3AZ1G0IGbuxNHLLWzZw+PKm/s43Y
         17sgU8aZaN7F3KELr4F3xlyHL4d8E6iH2JBjfSZxb6E7OJz9znHtOgGFeNJb3ygeKKTX
         zC7xaSSLSJcAmia3kkXONlJyPRTgdGQckLcG6JErKKETaG3Nj7QP7Td5l+4wlwMUZSRh
         59S+phlVk+5YfPwbqVrhbkEkfrzI/Q2SM+x16x0rZZzfwo7TRk7xA5lFjdIv0zoFRKG9
         unEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751998666; x=1752603466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7oks48muiKNQ9MQb0raKT3/XZo9cmEOj4qy77c9F8s=;
        b=GSCZ+ebCy+Hsq47QpEPf7Q8ClQzPj4wsB+S+dr3X6kmKYxf6fJV6ZRVyXqMafxWOYf
         qqjTDrLRdceSgACBDi4Gm5QMt6l+sFWOB31oz/vzaD3/4NW3Kss3vT3V9pxybusuKVjt
         EMaMUKLSTebJ+cRYtBcf5T5ovTvZ34rli2IfA13Dw/BpqvkDwMKslaEniGW36n9nkblZ
         c7NHZ3/mqmIZhJzuXzcsZO12XcZ271HvoatADQC6f9CplLGTl7CnxzoPHo8UV8+KxpPf
         +1N0xAGIf+sUtHWOEA+yz2dUEuDoCVe2Gdy96e0vD3eyAME3pqVmPteV/OdhIrWtE6Te
         xvfw==
X-Forwarded-Encrypted: i=1; AJvYcCVmclJYt7bpY1T7s4SrzBO1qwreBGSxatSD4PXWcFaxq0PGSuHYPnzC7ED6FS7A+ZGmwj1pggBi4sOjwR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGt2WyLKFBc9k8+v2FsuVVC8qhRiPyp98N7qpnNQcgPDc1Z/e
	/PRG1J94wGPSvE7EjD3/Q0GJLtas6uSavJmcKPTAzg5UYSMewIMnkEtYYOTi7cN4T/k=
X-Gm-Gg: ASbGncsaBQ3V2WaEFwmvosW0Hd4l8IjmJDWUm7gGzRT7r0+u5dsZt54ce7LvjT3oXOG
	Vox4qLgCvxQTLJL8TLZ4Po1Ai9ZdmcCnPT7LTL3BtRFxIOT17KvVHypLsWrBIQvEbntmNmJ+dD1
	2jtpx/VN8rBW/9dtUowJxdyXFIyrbeHpOtlf4x7393BfVSykDCW5wXtrGpFnZG4xcpfVCOQoCzS
	vdKouUM/GPwnbfnLAD5ube/qvWmnGwGLcwkVvDY/CMQtSEDsvAIMeB5xHWVdWe5++U6+ed1XIEB
	cOOP6vYdkfGfQPXJWl1X2tt/C0uKshxrtbOIVteWhG67+XNzoNZhe8DTqQ==
X-Google-Smtp-Source: AGHT+IGQnxN9Juqo5ZTXTrtTXAYwJOZx2V2bAQvz67ZgmfrWs8KU5VcAU1pY9C/YikiytA7oWFC7vw==
X-Received: by 2002:a05:6602:2cd1:b0:875:dcde:77a9 with SMTP id ca18e2360f4ac-876e1667944mr1871390039f.14.1751998665602;
        Tue, 08 Jul 2025 11:17:45 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-876e07bc6bcsm297705939f.13.2025.07.08.11.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 11:17:44 -0700 (PDT)
Message-ID: <76ea020f-7f57-42d5-9f86-b21f732be603@kernel.dk>
Date: Tue, 8 Jul 2025 12:17:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs/ioctl: store btrfs_uring_encoded_data in
 io_btrfs_cmd
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Mark Harmstone <maharmstone@fb.com>,
 linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250619192748.3602122-1-csander@purestorage.com>
 <20250619192748.3602122-4-csander@purestorage.com>
 <c83a2cb6-3486-4977-9e1e-abda015a4dad@kernel.dk>
 <CADUfDZr6A51QxVWw2hJF6_FZW7QYoUHwH-JtNEgmkAefMiUjqQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZr6A51QxVWw2hJF6_FZW7QYoUHwH-JtNEgmkAefMiUjqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 1:51 PM, Caleb Sander Mateos wrote:
> On Tue, Jul 1, 2025 at 3:06?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> @@ -4811,11 +4813,15 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
>>>       loff_t pos;
>>>       struct kiocb kiocb;
>>>       struct extent_state *cached_state = NULL;
>>>       u64 start, lockend;
>>>       void __user *sqe_addr;
>>> -     struct btrfs_uring_encoded_data *data = io_uring_cmd_get_async_data(cmd)->op_data;
>>> +     struct io_btrfs_cmd *bc = io_uring_cmd_to_pdu(cmd, struct io_btrfs_cmd);
>>> +     struct btrfs_uring_encoded_data *data = NULL;
>>> +
>>> +     if (cmd->flags & IORING_URING_CMD_REISSUE)
>>> +             data = bc->data;
>>
>> Can this be a btrfs io_btrfs_cmd specific flag? Doesn't seem like it
>> would need to be io_uring wide.
> 
> Maybe. But where are you thinking it would be stored? I don't think
> io_uring_cmd's pdu field would work because it's not initialized
> before the first call to ->uring_cmd(). That's the whole reason I
> needed to add a flag to tell whether this was the first call to
> ->uring_cmd() or a subsequent one.
> I also put the flag in the uring_cmd layer because that's where
> op_data was defined. Even though btrfs is the only current user of
> op_data, it seems like it was intended as a generic mechanism that
> other ->uring_cmd() implementations might want to use. It seems like
> the same argument would apply to this flag.
> Thoughts?

It's probably fine as-is, it was just some quick reading of it.

I'd like to stage this up so we can get it done for 6.17. Can you
respind with the other minor comments addressed? And then we can attempt
to work this out with the btrfs side.

-- 
Jens Axboe

