Return-Path: <linux-kernel+bounces-891519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4FC42D62
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 14:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D523B084D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C621257A;
	Sat,  8 Nov 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q5AhuKM2"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2451A9FB4
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762609216; cv=none; b=b2PhWUSvOVCPKvX4n5JwxHAIKVNQ1QZWve4jy51j6xKEh9iP1cfnpEe0t0dTlB1l0RtYSRXjUcSoVV4dYhxuuxV95Yx+IpNwwvoWmzCISRvZZJDpIPzL3cAxaMnjdeoPP6SXcbbxENaOblCbvdHkUVgvv0GNfWDmsKgx6HxRzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762609216; c=relaxed/simple;
	bh=VzJqVHLJEJbg4leZ+HEE6brhUMsbrS0i7/IHP2c6zkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZuQ4uCMI5dJdZVUS6LmMdLPm2w8HvTmEqFh9pFlwY08RxG/x3WoNbI9ez3gP4gW+ZvfOn+DBpiVcRhyDp+8PIUxiZ9PTHL+ehO9F/olukgkbdwjoUfJDYqZ2nnYMFOwNbDTX5Eql9n7OIykMRlqj+7lOUJYKHncv5pZ26Nsp2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q5AhuKM2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so15547011cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762609212; x=1763214012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ghd/ld/RtrgWoEpUX7jRCKlUQzzc8Yiprpw7/fUO0CA=;
        b=Q5AhuKM2N+j0jMPkruY8hrgaLIp3L2nN3tunwkgW5SH5+0+MooyUid6L/y31nxMMnC
         DnzXsIGsdrcG6B9+rJJcfRVuw7AgoT7eEqkpKFWY0+viAqPhfxs/gRKUGm/OeHmuSkuI
         boqNId4Ko7eVsaM9L22Ht1dVjkeUkTLl3pVzBgoYBxZEm5rOoLtfa1HFd74cqRCiBG56
         81L+4eOiKb0XBpIKZN7PsThOAFYmp6GzIfmuZOLaIjcQU5w6tMvzfzIYfVkh5h4AA6wi
         vYZhkgL/R/j3mL4kGXdas2pwVth5YUU+1K8sCEfkJhB6bp/4ymlfGHVZlGHzqlvNZ4Mh
         tuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762609212; x=1763214012;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ghd/ld/RtrgWoEpUX7jRCKlUQzzc8Yiprpw7/fUO0CA=;
        b=jHnZb2WXzx0teP+l8FFsieoVgwtrgltmmMNoS27SzQ9OXtK4YTeX2h7pFsy25lPmpp
         DbCq3Gmyh7gmIxxN3f0qPl/Y65JtATDuwnEkB8m/QtBlNbhM17U5jgPfthddhzlm8tjQ
         UMIDTi5MgFsJUarqBNAGcUxbsfX7jD5Pb6w9o2OKnVSaLgjN27Kh6hk4/rqb05NGaT7u
         4ggPUrZLq83Tw8T3CBE4WijWEqRe+lckr+Ck+srbGalaf0D1y37bDpxc+A+tFhSDsdo9
         vjiU0uI+408K8mdahtaW1NDE3E9A4UowERpp0LiEK2tlhIc4C3KcucAOLMxAMDG7MPar
         /KDA==
X-Forwarded-Encrypted: i=1; AJvYcCUWTD8zPbM9JghaWUvDo0ZINSYX1FaPaCXc38cd04GiNu1+vdEzq0lWbak2smxcisISyYxMHNAVGDM1zzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYR+sPeS0TeJQks2pmCm147VGVWYZ1uJZzqZDi4Jg+cNUlwmQ
	9mYkh54r1q3UbwecpZ/4172IwHKWItQrvEPhr2o/QaG4V4OvakCwWpu0SDJnRfSH8NCTYzDJqoL
	OtGlt
X-Gm-Gg: ASbGncun1sNhHJ1PrcULl/HistRzSdfoZjN07tk9lI1ky8QS/0Szpa5BPMWnCw+uJu7
	QqmcOOwLZQPlA59rpjDP/QSC2nqYue2SuUGw5+0ph27kk7r3AwjhAS6CB9g5DWGAo3v6HrzQsRT
	NeNqJwxsifIaMFP3WUJZFgJyxvp1wy91V9YYMuoWN1UyUJJMM4eSlc6D4GqZdFJDRC96KSxF/ma
	SHt3GA5a3E0SmBr3A919bTsMvuJ4bjD2/2/1GuQr5srfEMCu21U/O5OJbB0m3KBdlxOmj1ieHhF
	ao4ZcFamqKjsu1vbSkx/a78MKS/RQqgL56iMje2zPOb295HFA1IwOOaij00jjewM4G/r8C/9qWp
	Kyya4e7jNSsG623g8pAoNq4P1iu9ei40JLdCHtzfAnrHhZRWyWb0VnSz6iL9Vb16m9qIUdAzN6A
	p9kLsPVzNhmgqyTAZx
X-Google-Smtp-Source: AGHT+IE7901mPN3l2lR6QHNGxnfEp8vN/UEu7mW6GuPxHqTF7pE1OXBkRGjJDXweFnxWIemAIHzkWQ==
X-Received: by 2002:a05:622a:88:b0:4ec:ef09:6b74 with SMTP id d75a77b69052e-4eda4fb0d24mr36342341cf.60.1762609211781;
        Sat, 08 Nov 2025 05:40:11 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b290eesm14808676d6.34.2025.11.08.05.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 05:40:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, xiubli@redhat.com, 
 Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
 houtao1@huawei.com, linan122@h-partners.com, zhengqixing@huawei.com
In-Reply-To: <20251108070202.1816004-1-zhengqixing@huaweicloud.com>
References: <20251108070202.1816004-1-zhengqixing@huaweicloud.com>
Subject: Re: [PATCH] nbd: defer config put in recv_work
Message-Id: <176260921037.52069.3327906711798432611.b4-ty@kernel.dk>
Date: Sat, 08 Nov 2025 06:40:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 08 Nov 2025 15:02:02 +0800, Zheng Qixing wrote:
> There is one uaf issue in recv_work when running NBD_CLEAR_SOCK and
> NBD_CMD_RECONFIGURE:
>   nbd_genl_connect     // conf_ref=2 (connect and recv_work A)
>   nbd_open	       // conf_ref=3
>   recv_work A done     // conf_ref=2
>   NBD_CLEAR_SOCK       // conf_ref=1
>   nbd_genl_reconfigure // conf_ref=2 (trigger recv_work B)
>   close nbd	       // conf_ref=1
>   recv_work B
>     config_put         // conf_ref=0
>     atomic_dec(&config->recv_threads); -> UAF
> 
> [...]

Applied, thanks!

[1/1] nbd: defer config put in recv_work
      commit: 9517b82d8d422d426a988b213fdd45c6b417b86d

Best regards,
-- 
Jens Axboe




