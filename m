Return-Path: <linux-kernel+bounces-797399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF1DB40FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46383702FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BE72773F3;
	Tue,  2 Sep 2025 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q9+Fmpy4"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F56223DFD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851768; cv=none; b=BYj16Pd4+VwsfOOocede/Z5b/hyKUbZdZkTkVx3VKXtlMzgYbRZMjPLa6TPIYMZh8Z+sxCpLS96zuNUMLX2ARHLkgrZifnyDF7kfsbl6wxYYZ7z2zd2mwuKriCIlEAOmQhlckOAZ7kk9iqRXlixKcxNOpTB09kpw/qfNa/DSmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851768; c=relaxed/simple;
	bh=1r8Dd1Vxp/ZfKTkV/+QQqeGZJ37/gBVxDRLdoNTobx4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fRVpzn+GBWq5nOLuhffd7vxg1lP+WtmbIiJBseRlg6JDwYYlHYQuRA+A2PQM/tg+2ar7+GWk+0E1leb0ljwmveemTVKOVj0Gnzo3A576/zOjiMnZMYyamdmFruWSV/EXsNRtv+EwsdMoSRVx4f0noDvnp84NU3NG+jjkwedOSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q9+Fmpy4; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3f453812254so2761835ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756851765; x=1757456565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsgHYoXl8XEDv6u9usSm/TLGj9iq5mbiFJJ4P4xGJcU=;
        b=Q9+Fmpy4dndieky0PudmQdsl/stk6Q+AweMcMIyn91LFVai3hbIioaqyiPam+zolFF
         1MIlPvd2jFCkwAJUjA5BZz5RE4sjQL/nDMbwe/DdEVQEXlDmdDwn8mbvO9r/K5UltAql
         wr74LPy5kZqFye4b5N1ZVMTxsYu8PLMcF/008/qTIixLJ7CkbfzYJETZzh9HvLLibltT
         icuq7aDYXD6r2zmOJSSOlgMbVoeBpWb/xqyvNmI733UOW/lMPiKV739cPFcXnwzwmrPL
         nMSBZQ1PVaPcD/5SCl+CbSsnlDLjKRxqPyusWDxMMzWGB9VqqwmE2uyJncyYemKJ1cHA
         k5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756851765; x=1757456565;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsgHYoXl8XEDv6u9usSm/TLGj9iq5mbiFJJ4P4xGJcU=;
        b=Z1+XNODBBEOLS4yJu3JGUCVKWd4TIc8OFjPdWhl5igV7BNqED9dJ1gH6k0P7RpjagT
         d+3qB5bfR7zi2loJ+Kp4Wze+SnefM1plcYwtBZun/782isgvuwocwbvKHVG3Sv63vqse
         H1af59QXc5i08+eWqZrk8IuTzXDnNFz3tEp77J5gU4dnUcqUeaK8ifH2JDGi0gI+MbTf
         IzDdPqYDCkzFhZAXJP5wLx7UR6KuV4+Ri3G0LNwQxrX22yaer6J6FglU2S3gD8VW4qOx
         VLtwPMrm51IzULhkLreonAYdSGDOThfxIjWyxMa6AwEu7Ov9mKLA/mH835I2EB/obVTU
         dn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXT7poN7nPd8eeLrsoPDLmsoa1fAmw4cyGeTJ2WVkEqfQLWYYrpZi1FAPsbGUDixG5MCeVB18eNcLjgXY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfSWZnN3b2hL8NyXdJZJkgpCW67eQJyU3RW7b0PGr0Nc521m2
	Zhcizo7H+lHgVtVZDcWBEOBZZqltkEZd0ywAifzUj/t8G/oEkETXBNRSJYqrsU1iiNQ=
X-Gm-Gg: ASbGnctNm0aVA4T3heu+752VKIW0dTuyV/F5jAHQC6MsGeDeFZTBv2k6OKZomYFaxZ8
	i1/Rl9RJjmogpD09qSyscG1tPl4kqE+rRhGhzNejFMhYOnx1Q6u0FheuFtxE6ahLYs1yuueWV2t
	pDOn8IxvVup78rIHyd2PkLVdcTRwX04SmO0S8skDiQ+ncanO0oyYO+ciG5PSpoGJl1nxsNDDCEN
	RgjBRiCySd8YXrYebXYEGXepDuEa2B8gwAeKDttC+KV+s2+l9GVpAwDwLmFm/UFZ9bN3z4mX3F8
	RKHHQRnAM6lyReXbWYWegy3oxFTHYNkKxp07s2U3kW7lSC7Orz/E50b3fV+czIUqMCD6sMLfRqJ
	l5znU/4FvrlY0R0Y9vsNUg7uIhaRnqRCwtm9CkFxGIYhqPSBvAvU5fRThxl+PZIPk
X-Google-Smtp-Source: AGHT+IFfI7hKWtDAOl7ZVodkkOkz+AIezL3CZ2BrlZMAw59f9+OYjXiNDkBRRbyrOg6biAgWIE7oTA==
X-Received: by 2002:a05:6e02:216c:b0:3e6:7ac1:b8bf with SMTP id e9e14a558f8ab-3f3d60dcb9fmr225041885ab.9.1756851765148;
        Tue, 02 Sep 2025 15:22:45 -0700 (PDT)
Received: from [127.0.0.1] (syn-047-044-098-030.biz.spectrum.com. [47.44.98.30])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3e136b841sm45322195ab.44.2025.09.02.15.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:22:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
Subject: Re: [PATCH v7 00/17] rnull: add configfs, remote completion to
 rnull
Message-Id: <175685176380.67509.14270978539673986925.b4-ty@kernel.dk>
Date: Tue, 02 Sep 2025 16:22:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 02 Sep 2025 11:54:54 +0200, Andreas Hindborg wrote:
> This series adds configuration via configfs and remote completion to
> the rnull driver. The series also includes a set of changes to the
> rust block device driver API: a few cleanup patches, and a few features
> supporting the rnull changes.
> 
> The series removes the raw buffer formatting logic from `kernel::block`
> and improves the logic available in `kernel::string` to support the same
> use as the removed logic.
> 
> [...]

Applied, thanks!

[01/17] rust: str: normalize imports in `str.rs`
        commit: d5d060d624e34c6ce1748a157cf2391e49af2a54
[02/17] rust: str: allow `str::Formatter` to format into `&mut [u8]`.
        commit: 87482d6d9104d087935592ebbf52b70f8a777c47
[03/17] rust: str: expose `str::{Formatter, RawFormatter}` publicly.
        commit: 8c5ac71cf19bc8a2ad5bc905d1fd3191d887d469
[04/17] rust: str: introduce `NullTerminatedFormatter`
        commit: cdde7a1951ff0600adc45718ba251559e4d3fd7c
[05/17] rust: str: introduce `kstrtobool` function
        commit: b1dae0be89278348e2c99ddca820d91292856b10
[06/17] rust: configfs: re-export `configfs_attrs` from `configfs` module
        commit: 60e1eeed8b53f65ef7919fd3f79cc9b7f20795c5
[07/17] rust: block: normalize imports for `gen_disk.rs`
        commit: f4b72f1558be1e2b173b6b1f93c09dc668592a26
[08/17] rust: block: use `NullTerminatedFormatter`
        commit: c3a54220b54a1bda0662f0e7ab90ffabf5036d50
[09/17] rust: block: remove `RawWriter`
        commit: f52689fcd8a2f78436b57d10ba742455431885a0
[10/17] rust: block: remove trait bound from `mq::Request` definition
        commit: 8c32697c4edd4180bc90d367e54fb64490c230c6
[11/17] rust: block: add block related constants
        commit: 19c37c91b4a0ff7abfc3dcfe165d1377939469ac
[12/17] rnull: move driver to separate directory
        commit: edd8650691c374bdce133af1b25ff4f3496f489f
[13/17] rnull: enable configuration via `configfs`
        commit: d969d504bc13b2f0c1f208e009e73f2625b421c0
[14/17] rust: block: add `GenDisk` private data support
        commit: 90d952fac8ac1aa6cb21aad7010d33af4d309f4a
[15/17] rust: block: mq: fix spelling in a safety comment
        commit: bde50e28f7c5fe874112fe9d98e84873548fa8de
[16/17] rust: block: add remote completion to `Request`
        commit: 4ec052841a545297a276e833817990f0e13b1b32
[17/17] rnull: add soft-irq completion support
        commit: 34585dc649fb255b40075dab56af063c1bfc9933

Best regards,
-- 
Jens Axboe




