Return-Path: <linux-kernel+bounces-738032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDCB0B371
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 06:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5738B3C14B0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 04:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEDD1A2390;
	Sun, 20 Jul 2025 04:00:41 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612319FA8D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752984040; cv=none; b=Hu+oGF2UdyuNGCllppU+/tX5/HD/uA/cbeDPyqq0d8h14QamZzhM9bB+Yh0OcQi4GUbmGvlSFS4Bb/lYFpTUq8ZGvFVbxo1TjcIeDrdbNmqoxgIc9cqOi8jQoy+UPPTTGXIUhwJWjRP8zEnlLDk6sZgHJqJKHa2uT4biGAvzPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752984040; c=relaxed/simple;
	bh=HdI5BXXjYUP8fiKBBvDn6K+MhzOKHTTLNL+KHCkvScA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WfT4YlTd82KXTOi0v6MVacbFlb69ubG1lqla0okFrslt2cRLrQzrX0OgtxRYQo6iyyeCAvV/J0Ryn9jqG2nzk6iPph4VGK+juYVZHEsx9vAWEL4Zl742usCuFK6ag2Y1eLZQw6ShLKuPtxXQATknesBwTxQhGBSX+sktosOZPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8649be94fa1so710911539f.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752984038; x=1753588838;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdI5BXXjYUP8fiKBBvDn6K+MhzOKHTTLNL+KHCkvScA=;
        b=mVyo+r5C6cZkB1oX5exnSG7HrTrLAt6BXi7YQBKT578ghK4RDpK/AA85nZrUV8Zc+f
         VEctneQWbHHqr24eSejTuB48YyUaQ8EQFTjCOCjggqp8svD4jJ8D2QCUKOI8vYnRPExs
         odh1lufzFz0OphXTxI633d5n7iLuoc4PG9mrD/M2xOkWPh6eOx15KLiZopp5KwpsM6xr
         YogZFNVPO3HKCSva/1K411bFKpBGsdbbD+hd1avoXvfT+3SO2UDchnJonK7PFLEYwxYm
         ZO/dXWlE7NkRfLyzXl10mU09PMhosdtgBpG+XHaHlZhFyDSvXl0MPgaxQl4+k1NqxguF
         CMVg==
X-Forwarded-Encrypted: i=1; AJvYcCUxSxVtdpTAii3d0VnMtFDrt64Aw7aOqqBR1rlAf3/2pnR+cZVktx6xGRZg7Wf+7SY9sESQpn1puuODPdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXvUbY1glVeUUmQ0QMOyq8cyBnKMusJVjdEzZovtgb7E25NjQ0
	Xs4cpVDX/foLGjSbJ2BLrCJO0vFIjwy653uwnfNeGTz81UGpJKf6EIeOnEaDZfzrSZixgmred5N
	VdU9sKyFdvLAMq7Kj5oLiflAgDzTCOXTCapQzlp9JOiA88p2Tb77roPIxtSU=
X-Google-Smtp-Source: AGHT+IErCJcCmnagu1fZRqNtXzK3OlWf6hbWAUJF/H8gO/f5c49RTChMz5G4wOP6BzFltztpq19giII2cKwrw35IV8fap2705mIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f0b:b0:873:47d1:2259 with SMTP id
 ca18e2360f4ac-879c08c4c8bmr1794835839f.7.1752984038339; Sat, 19 Jul 2025
 21:00:38 -0700 (PDT)
Date: Sat, 19 Jul 2025 21:00:38 -0700
In-Reply-To: <drpsv4a7vnjfdtgok6vzixaft6oksx5kyorwn4ynwazx32ctrx@clquygauwsul>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c69e6.a70a0220.693ce.00a6.GAE@google.com>
Subject: Re: 
From: syzbot <syzbot+3201be560ebfa39bc6bd@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz set-subsystem: net

unknown command "set-subsystem:"


