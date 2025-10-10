Return-Path: <linux-kernel+bounces-847869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AFBBCBEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3A53B0E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB92257848;
	Fri, 10 Oct 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lwh8Whwv"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02753126C03
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081434; cv=none; b=m6xwgK0ep7XWhaBRtRbZKPa4rQbZEttRZ9CFaaxI33yoa5JTlJ0N6z3zPC+IM2PzLWCnro2FuMdAn4+prC1q6t9d1EQ3bBcwm7Rqt/pmU+c6Ln3eHRoehHI6Cnm7sbL8xEgTfx5Tqf3gnrbaQS7pzDtuvVSDC2rMvIDtYDZhh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081434; c=relaxed/simple;
	bh=IkNqZDVNyA3duHS9hH3ye/gFfHu3uCgOFPAbVTvHETo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHi59JJ/loqAo88uJEz1HRiMcCkvHJ1SCDUOeRCSJJS6Xph6YSEwOjOLBjx0g+KxeHasYYX6OAe7tHJJ1gZNmtXf8u5FDo7rYyU2it2zo7Qy1bXMJgKy+sJgqB7Fov+GziEWaKNlNL5eesbvGEPTLPXOiruvexgwRY+Jo43DGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lwh8Whwv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1473658f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760081430; x=1760686230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v15gcWq4DAaCwZCWaSHzLQyiwH2fsn5hdGQ6c6k6meE=;
        b=Lwh8WhwvA5CTVPbgq3G2qobOT9Y/6sdwjUJqHA8e8Anh1a3lrZWGzAfF9B8yho7N8S
         o8iVROmX6zE1N3RwerwjfUAwQ32cqCZZfWZpbsdYIgfdRK9AnD8UwN9QbumM9nIjT00q
         0VKv2nb6Wj9V92WQ3WF965euf5qAqHHmzbQuKNCqiss1mZd7anflxlwPJ5REq5gwmn9H
         zk+C1yHwlJWOeFjZ9RpDh9MNpxgutYb5VKKk7AE9zDsmqI6xsjVKFe8IAsE+VSsawvUp
         ufVZx4CBfvkA8HZ2TKlH1tmt+7MqfyjoKhSbl54NAYjndlXoeH8qJFUODHuRiW9hHwfu
         tNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081430; x=1760686230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v15gcWq4DAaCwZCWaSHzLQyiwH2fsn5hdGQ6c6k6meE=;
        b=D24aSp2Oos6q7DMygA7Ts9d/FlOSk1Sm0gPD5DTlSsul6rFS4rK+ieyVkQinG6KYUm
         gs08nyTlMt2mTOgTWaGu9IeAuX7ULWAPOFLzmxa1n8ZVx2zi0iJL3y5LfLBLb3NP9S2m
         uc85/EJJH3qyTa71atz84idaae7Sz4wea39I/DMkOXh0cupqIEz18gBeka0ILchez7Ag
         yK9LOQr5KyAb6lbyV/bsy1ZoPPIcpR4S1VxE0ixw3xoRkxORtYG91J+VPv+1QrQ9lCGp
         a5Kw37yx5sJ9fl+OMuZ3TOVtnLo9WSjDfk94paKPX0g2BbcAUguisPrH59Y8NBGmANuD
         /fCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUKFDJQ1bDF7g5skNbCzvWwqschMhuAyu0ag3sSbT20VZvl6oxQ3kkseaNpbnyn4nnjmuQumgqKcg4BaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlyoDR6UfxOpxyYm6z1UUaJ24iUN2xx6hsGSYFNnDK5RAxZF/2
	byDEf/Y2X1PdgcLH31Q7xScoKvfRNih2yrLeqH23s+zgZ0lXAl0yydEH75O53hVLRUY=
X-Gm-Gg: ASbGnctHOiD6ik1fwxs4fxl9JFlJ6R81BFMQj9x0JDYqL9KNCungA8fY7xPPNQl1f6o
	ZeKtIZQlv2g5IHAZyvhpgcfP0yNdsVjdPtXQyXd6sad9Q8WwI6Ff+yk+AG8q/Xh/mOpHZgATMmS
	ONFUjxvzOhvnL05DElo9WyteJ3cX83f1pwevCGFGT2zlQdiBX2oP6hv9ALQFv/SSnmE645W6Fim
	V998FjUC4RGKtZeJdCHzFId/15lRg9B0yDRfeCq6ppq07hy3fadSJN/+rdbER86119gV5+IMSkl
	wuYjTkgp7i00M+HW9h+15APFLEBDtwYmqEBzm33A+ZL7YU27uUBc1W5ZVzipNVBL5EVsgedhy+m
	pQlkMpb1Y9s23/CHhzPAiNWqRli7KMga+jr2AL/YVicGl
X-Google-Smtp-Source: AGHT+IEQOAV09VUkoOCWbGZzKYDg6z/Rsf+FbBvjdD/ytp4882J0wO/VEVZmUYXCK6vwgIVG7lTv5Q==
X-Received: by 2002:a05:6000:26c2:b0:3e1:9b75:f0b8 with SMTP id ffacd0b85a97d-4266e8dc01amr6986150f8f.47.1760081430237;
        Fri, 10 Oct 2025 00:30:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8b31sm2754132f8f.54.2025.10.10.00.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:30:29 -0700 (PDT)
Date: Fri, 10 Oct 2025 09:30:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
	laokz <laokz@foxmail.com>, Jiri Kosina <jikos@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Weinan Liu <wnliu@google.com>,
	Fazla Mehrab <a.mehrab@bytedance.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 00/63] objtool,livepatch: klp-build livepatch module
 generation
Message-ID: <aOi2E_8k9G1EnDzG@pathway.suse.cz>
References: <cover.1758067942.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758067942.git.jpoimboe@kernel.org>

On Wed 2025-09-17 09:03:08, Josh Poimboeuf wrote:
> This series introduces new objtool features and a klp-build script to
> generate livepatch modules using a source .patch as input.
> 
> This builds on concepts from the longstanding out-of-tree kpatch [1]
> project which began in 2012 and has been used for many years to generate
> livepatch modules for production kernels.  However, this is a complete
> rewrite which incorporates hard-earned lessons from 12+ years of
> maintaining kpatch.

The series seems to be in a pretty good state, ready for linux-next, ...

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

