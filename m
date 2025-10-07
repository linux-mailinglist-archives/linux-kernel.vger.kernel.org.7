Return-Path: <linux-kernel+bounces-844262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7947BC1676
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9D864F5F43
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064521FF48;
	Tue,  7 Oct 2025 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QokZM0qJ"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4082AD2F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841245; cv=none; b=MFVAkdLicqhqCNyk49DByjO3zzpwlaoIEYCIU5nHjmpTwOLvzr2CdojGr2nRuFFqOleucZOovibUn3jldTIPb4bEtNAbzhet8UnpLvlL7pZ1QQinvZ3Abug73YH78UYt5TC72y9ZmA64zChPNptjU32BibrktLgfrpY3341Gvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841245; c=relaxed/simple;
	bh=RQN/2lDlhzCHpCJtTDLlN1RlhI45f3qz73uJwycfNyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EQDvZ+qXwzKcLN/2Cjjccb54Zx6PxiIXeKQ6RY1asQagVWPklId54CfGQ8yBPLDOJWHWGHM7vfxfoEzMgvRYx+w9Fm5SiPGAv1GvH6AQnhf73QhsX0HZNRQ/Rmcmp0swjcY64iD7dX7uZrR7Si+tB9h+gK2toP45Q1fHb/NLlpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QokZM0qJ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42f5e9e4314so45003615ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759841242; x=1760446042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CJuDLqWRo4Zntrd7FLhRCTIWZVZXh1mD+BCXSb25DVE=;
        b=QokZM0qJdV5QIxYrua/bpJ22oY2BnV9GPTZEEql/b5va0Gh3BNTQKKYGIREgbV1d/B
         oWHbaZCunLe5AfACdWoBEyXaOFa0kGEj+H8qKVzVinuTg0UKhMOsRNUlbEOiVmwLuCYs
         CPvoDpyfM69NZG+gkOI/1Kdiqh31iDopmAC40VYjY/D2bG1jUCFVKpgMakYSzMJQP8LZ
         cs75sNpUE8wnYZk9sUO50MgN6C71GNoxnYomQA08wxhBItUeDBENOF/g4jVCo4+SAjKe
         zXPb/E5HhRG73yC/NzhchCsPrXJb9rpFRXOLjbEWD+gm1KJjC4hQ47+CNciyEWYE2iKi
         Q4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841242; x=1760446042;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJuDLqWRo4Zntrd7FLhRCTIWZVZXh1mD+BCXSb25DVE=;
        b=PFraOFLUgk1w1RJXe5aiLprk518xu974NnF+WRDbLj+8rr2uemWi8ow3pLpamRVcTa
         pr5MgWbde+c0mcVfPgdBjhp5W5sT58yCaOhNrwxdYuf19WGu1rj28b2TLrUTzMf9ZIeH
         2e30QnKou7nm8GYFJ2q+97ZpLf9Qzm+D5Im+LRd9zmSr19IrSEciFtpzzOhmbd8TybYA
         bwmesSJy55gSMwKta5d3kvQvfXsUQnGmvxDq8Yurte9MH8nxOfq14XD0/i0xuaTYPrHD
         Sckpoa3v/kaU/7t9l97oD8itSL8BXHQb7mlFRRv8lI12W5bfv+9pnNSYqppiQtUNDTwB
         jYYw==
X-Forwarded-Encrypted: i=1; AJvYcCWmSvXoGbHg1rqx0wcfYVgYglMqj2UPTHWceiDchtyv+qJUmScRYkYX2x9uEI2Pr9sDxZOysGSObZxO4Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hqMEgp+j91woJs4K3rQRfh4RVEGFpvmks2gNRYhsIDCf+TNG
	xTAKZD1A+lO5kvi3Lqf/csqgWXZppxHAmSb0wGqyruxV3YeXjKEk0q1zpMaQ/zAWBTU=
X-Gm-Gg: ASbGncsTOuRgryVg2ZCGymLsJvwEP7YBr/RSi6rfpqD6HnF4Z90OnR7kd+HRN31OeJ+
	l+rCMzhrxyY1iz7SAkAE3B4L9UrvB65AajGtMY9zk6LxhaTl8TWtPpxHGJjOoak/FOj1m+G56uf
	EpvzD2URqmlt9V04i/pzgN7dv3+SVQkeEJ2jIuROq0dDlPhzyRiZj5F8WM38T51xwSvbfjTZeKB
	7EO9Mc4s3EJWkVGRrRnswv6zHGPrBJP+2rTr2wX/c8Cf7lbT2cmDIqfoAKJR7ThgT5d5yIDU7cp
	9e4u8BKRaQ12WiBO7USfRBUoGFbAhYleujl4IyCECfLR0v2fFZaFWlXKSpgET+0zNbFi0yDZw6Y
	JTAkimdbpX3zHHGZHuLJw7BThy7IPRlZupWR/3xeOp8eOVNWIqvHqSqU=
X-Google-Smtp-Source: AGHT+IEhjV+rQNakagoyRfFs8Cw5QyuLbDFd/MmJxW09tmaws68gZlvukb/j2kPTZy0RgCpUbBD3iQ==
X-Received: by 2002:a05:6e02:1d89:b0:42e:38d1:7c61 with SMTP id e9e14a558f8ab-42e7ad8447dmr208356865ab.22.1759841242260;
        Tue, 07 Oct 2025 05:47:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea3a5basm6128505173.23.2025.10.07.05.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 05:47:21 -0700 (PDT)
Message-ID: <a2cb114a-e31a-46d3-8c27-35149bed668f@kernel.dk>
Date: Tue, 7 Oct 2025 06:47:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [nfs?] [io-uring?] WARNING in nfsd_file_cache_init
To: syzbot <syzbot+a6f4d69b9b23404bbabf@syzkaller.appspotmail.com>,
 Dai.Ngo@oracle.com, chuck.lever@oracle.com, io-uring@vger.kernel.org,
 jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 neil@brown.name, okorniev@redhat.com, syzkaller-bugs@googlegroups.com,
 tom@talpey.com
References: <68e4a3d1.a00a0220.298cc0.0471.GAE@google.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <68e4a3d1.a00a0220.298cc0.0471.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Doesn't look like it's io_uring related:

#syz set subsystems: nfs

-- 
Jens Axboe

