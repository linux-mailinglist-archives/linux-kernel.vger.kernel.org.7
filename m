Return-Path: <linux-kernel+bounces-892301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F00C44CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC333188C7E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37DB23D2B1;
	Mon, 10 Nov 2025 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b="gc2otjH8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A6238166
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762743348; cv=none; b=HMFMxAoGWcRdhvwL3PPWYGIiC9jyWn64VfSK7JUxFTHfkkRewsXdo/5Qts+ox2ilQiFvL2dwTRVzDgtRtswRgGFsljY9dFGuuc1VLkysBuqMJmra4588dPznsb9Og/e7W3Rp8t99cco6J+/RSbyHrFAnTAC5nsvffQDeRhK7pYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762743348; c=relaxed/simple;
	bh=H+9PkKTyEbJK5d9QgHXBfazvEvXSb4yGxVVDhUXWg7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBVJXXViAsyLtU1VqDl0ePTCpedHx6ubUL5hS8COq+mfPVWGwspvUum4Qo37ViTiXBEaKHtHSmAH0VcIrN6LDA7UCx6saysI38XNzQkEZlC5g93x9OWWqLQgWFdV2S6kfa0Goj8nJjuQxOQjmd5yl3ObOHzuvk1IhnOkYROk23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b=gc2otjH8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aca3e4f575so1964611b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 18:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chenxiaosong-com.20230601.gappssmtp.com; s=20230601; t=1762743344; x=1763348144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WqOgg+cKwawd/BMH2Aozbdp1DwLQQYYEttK6RNMeDMY=;
        b=gc2otjH8jWJgXULi3M2igGndbQO2x17RJRA67cINApTsesmzLwm8T+r9LU2u9uoJYy
         0Zm6jYHy0wGfNEDrygmh5aompVHQHIyvQpNxS4sBpCLgj6EgZa/OUHdlELyZS//OiaHe
         RASh2wL5Q1NEmnmt9kxlnztcu4WjElhlXdD7/+yEwwDbr3gaR3Ir91wGYa8HLfBWtLFG
         0qj8/h8VZxoUdws8aGDEJdBcgtERussUUol8z/TQisbsHaC4sRd4gnvkUgr1Aw6esj3n
         v0AZQgPzskJYK4lLtx4zdNUlGgSln50We3KGSLV53PSX7FDK59H3n45hNgEY3iF+f1HX
         oGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762743344; x=1763348144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqOgg+cKwawd/BMH2Aozbdp1DwLQQYYEttK6RNMeDMY=;
        b=UUDOrMv6UyztAfSc52j3dsSx/kxV0wYAvbbmYngWkcuN+E8cpcX7x/ILeqp9+E15gX
         0p06FmZoOg8CC0LW8HRn92qewsi0m84PE7EttS896r1pkmcrrgP2d+/jjVhRsjHrrrgv
         4v77mhoBWJzUBoMMYORliDrLMffn+zhKT2dn0bxG8Kpd+8SPh7lUdA1Xe45O3KDl/szQ
         suCrrsrn3Eot32S/b56ynhVgy2hC4/1um743ri5r2OQAWQ6M0YV65sWNkbmcSch+Q56U
         PzbFJ80v/A2PHftFL/oKuzwvmQL2WBpcFbdxNLmlUnsxiP4BZAHGFoTTTGXB/GgD+gmr
         ySYA==
X-Forwarded-Encrypted: i=1; AJvYcCWtkL1sbe5843p+vYof+9Jyb8I6WO+OaFeB73NKDQhxUPihMr2ehF0ssp2hz07f0TUOZVk/VNyCEN2/+Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzagGR2fV3+ibUQOFtvHQmwpPIUF+1/N+BGurSmgkcKrVO53dEL
	6u4X6OFjYt0fJ1MEkZ0pVnyx9jxOHrr3eS47DkeeiiMSzPKb68BxS5vAswOeRHAvn7zj
X-Gm-Gg: ASbGncvh2GjVh/ahLVr8tTp48AG10852Z+fe16CjAHlMlKJQiiZC8vdTxTcy6gho1QD
	GV3ybGnAc00S/NgSVvz3jsu3n+cgXIl9kopgnXfHBS6EiX996yO77ocLocEaH0Gmo39swLFdvpG
	jyTQIH0N3aqBbN5IXaf9WquttGzlh3OlfMxuz2DDa/wF65Ko+XMYRr+f1dhfrKD1MQllyfO7tXd
	RiUL/U38vciQR8AUGCgXdm5PyrM0SoE8S4MmvtE4IK//dKwE/PCA4vdR4Y6f+0QSyBU659828Rn
	NFdxbcS1DSiIfK3C/cVIfWMKpKWutFMO+6W5JOCo/xyNELSv0fzn8z14Vd2RhwQtrJmlO93jCKW
	FBh5tPhM7CCE3OVEYMNphpLHijXMGOi8v9lNeFjWCkZ5TnMBCqsfuf7WbxUHSGOdlWcLuR6vCpZ
	x9CGvL2JXmuXSyqlSaHfa3BJjXxw==
X-Google-Smtp-Source: AGHT+IEhIXHbExnbt5cZ9V6wkY49Qwukt14p/dhfSc81o8RDrG6PWBVmJX3HXm5hTzmkF5ta94RCww==
X-Received: by 2002:a05:6a00:94cf:b0:7ae:8821:96c7 with SMTP id d2e1a72fcca58-7b2266a90c2mr9217764b3a.17.1762743343774;
        Sun, 09 Nov 2025 18:55:43 -0800 (PST)
Received: from [192.168.3.223] ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953d0a6sm9794501b3a.12.2025.11.09.18.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 18:55:43 -0800 (PST)
Message-ID: <ea09d478-150f-4d03-be15-5892e5d61e74@chenxiaosong.com>
Date: Mon, 10 Nov 2025 10:55:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/14] smb: move duplicate definitions to common header
 file
To: chenxiaosong.chenxiaosong@linux.dev, sfrench@samba.org,
 smfrench@gmail.com, linkinjeon@kernel.org, linkinjeon@samba.org,
 christophe.jaillet@wanadoo.fr
Cc: linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102073059.3681026-1-chenxiaosong.chenxiaosong@linux.dev>
Content-Language: en-US
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20251102073059.3681026-1-chenxiaosong.chenxiaosong@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve and Namjae,

I have tested the following patches using xfstests and smbtorture, no 
additional failed test cases were observed in the test results.
   - [PATCH v2 0/6] smb/server: fix return values of smb2_0_server_cmds proc
   - Patches applied to the ksmbd-for-next-next branch
   - [PATCH v5 00/14] smb: move duplicate definitions to common header file

The detailed test results can be found in 
http://chenxiaosong.com/smb-test/20251109

Thanks,
ChenXiaoSong.

On 11/2/25 3:30 PM, chenxiaosong.chenxiaosong@linux.dev wrote:
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> 
> The following patches from v3 have already been merged into the mainline:
> 
>    - 6fced056d2cc smb/server: fix possible memory leak in smb2_read()
>    - 379510a815cb smb/server: fix possible refcount leak in smb2_sess_setup()
>    - d877470b5991 smb: move some duplicate definitions to common/cifsglob.h
> 
> The following patches from v4 have been applied to [the ksmbd-for-next-next branch](https://git.samba.org/?p=ksmbd.git;a=shortlog;h=refs/heads/ksmbd-for-next-next):
> 
>    - smb: move resume_key_ioctl_rsp to common/smb2pdu.h
>    - smb: move copychunk definitions to common/smb2pdu.h
>    - smb: move smb_sockaddr_in and smb_sockaddr_in6 to common/smb2pdu.h
>    - smb: move SMB1_PROTO_NUMBER to common/smbglob.h
>    - smb: move get_rfc1002_len() to common/smbglob.h
>    - smb: move smb_version_values to common/smbglob.h
>    - smb: rename common/cifsglob.h to common/smbglob.h
> 
> In order to maintain the code more easily, move some duplicate definitions
> to common header file.
> 
> Add some MS documentation references for macro and struct definitions.
> 
> I will test these code changes with smbtorure and xfstests as soon as possible.
> 
> By cleaning the common definitions for client and server, I've become more
> familiar with the MS documentation, which I believe will be very useful for
> developing SMB features soon.
> 
> v4->v5:
>    - The following modifications were made according to Namjae's and Steve's suggestions.
>    - Create patch #01 #02 #08.
>    - Patch #07: move struct smb_hdr to common/smb2pdu.h, do not move SET_FILE_READ_RIGHTS and SET_FILE_WRITE_RIGHTS.
>    - Patch #09 ~ #12: move definitions to common/fscc.h
>    - Patch #10: include all changes that only rename structures in this patch.
>    - Patch #11 #12: some cleanups.
> 
> v4: https://lore.kernel.org/all/20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev/
> 
> ChenXiaoSong (13):
>    smb/client: fix CAP_BULK_TRANSFER value
>    smb: move MAX_CIFS_SMALL_BUFFER_SIZE to common/smbglob.h
>    smb: move create_durable_req_v2 to common/smb2pdu.h
>    smb: move create_durable_handle_reconnect_v2 to common/smb2pdu.h
>    smb: move create_durable_rsp_v2 to common/smb2pdu.h
>    smb/server: remove create_durable_reconn_req
>    smb: move SMB_NEGOTIATE_REQ to common/smb2pdu.h
>    smb: move list of FileSystemAttributes to common/fscc.h
>    smb: move some duplicate struct definitions to common/fscc.h
>    smb: move FILE_SYSTEM_SIZE_INFO to common/fscc.h
>    smb: move FILE_SYSTEM_ATTRIBUTE_INFO to common/fscc.h
>    smb: do some cleanups
>    smb: fix some warnings reported by scripts/checkpatch.pl
> 
> ZhangGuoDong (1):
>    smb: move some duplicate definitions to common/smb2pdu.h
> 
>   fs/smb/client/cifsglob.h   |   1 +
>   fs/smb/client/cifspdu.h    | 593 +++++++++++--------------------------
>   fs/smb/client/cifssmb.c    |  12 +-
>   fs/smb/client/connect.c    |   4 +-
>   fs/smb/client/inode.c      |   4 +-
>   fs/smb/client/ntlmssp.h    |   8 +-
>   fs/smb/client/readdir.c    |  12 +-
>   fs/smb/client/reparse.h    |   8 +-
>   fs/smb/client/rfc1002pdu.h |   8 +-
>   fs/smb/client/smb1ops.c    |   2 +-
>   fs/smb/client/smb2inode.c  |   2 +-
>   fs/smb/client/smb2pdu.c    |  16 +-
>   fs/smb/client/smb2pdu.h    |  69 -----
>   fs/smb/common/fscc.h       | 179 +++++++++++
>   fs/smb/common/smb2pdu.h    | 221 +++++++++++++-
>   fs/smb/common/smbacl.h     |   8 +-
>   fs/smb/common/smbglob.h    |   4 +
>   fs/smb/server/oplock.c     |   8 +-
>   fs/smb/server/smb2ops.c    |   6 +-
>   fs/smb/server/smb2pdu.c    | 116 ++++----
>   fs/smb/server/smb2pdu.h    |  68 -----
>   fs/smb/server/smb_common.h | 237 +--------------
>   fs/smb/server/vfs.c        |   2 +-
>   23 files changed, 682 insertions(+), 906 deletions(-)
>   create mode 100644 fs/smb/common/fscc.h
> 


