Return-Path: <linux-kernel+bounces-786010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE49CB35377
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21831B626BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41A72F1FEC;
	Tue, 26 Aug 2025 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT/rfZWy"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0CA2F1FDB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186837; cv=none; b=uGs8Gp7MzXeH8c6shVlH+tlg9DrIqchLfRQKb4N29xF1U/KDDZnnqbuU3EiEOnI9yTuF1jpzZwnsxzOyX/H3ZILakkyygOhtAGPmEzd/KZQXRNOi3CWXMOj3qAMkf2ik/KE8srRQ6E9EKVB28GtL8KpOS1c9UFwWYmXRqGWfJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186837; c=relaxed/simple;
	bh=G54EX0e3rXxQsj+sPfalZAoak7M41yTkUlZz+KcUp4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NhUJv/gMa3yxaRM1e46vdMzGf37/MQ31Fro+b5Sr0FnL9TihnjdxYAy2bLmuJ2kuhgBdfBFCOwzE8PaOii4mFSzIatcmB6WbJSV8ThDtBAWRkgTAN+vCcn052m3fPf0MTPw4V/Z6dEhVSXNol0ZWBXT5Hh/c18E702cS5ZoiUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT/rfZWy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-244582738b5so46139175ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756186835; x=1756791635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt5BzKJWl1+VWLrk3wMeSjL67k1RqFJc11Gk5yw4aWc=;
        b=kT/rfZWy2wU7s3TDgF/PQzoQc/HAFCxJ3JqzeTH+oMjY1qk4R0hTzo0go57Q/uG5Iu
         ZxL238olKGoQGZ2EjGknBPNGXGNuRv0yj65IffKHVwn7vmv7rne1LhWi/tF45KCo67KG
         6790m0EiUkklKHlyMvFMTWQOOSfB7pB8JmUG8goQptnZGIh53qy3CkV0RVtSfqIqf1MU
         90nZzR3/DAW8LBAVNOqdfcuutKiChgYes7/HPV/FUhH73cMtVHUO+ejv5ZeaORyn1l1r
         A1wmfbPC7aLQ6Tg4PnjKuyACUGsXgsuPRJyXB8OqhPmZt3q3oUIKOxEiXznTyZXxDPVt
         VDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756186835; x=1756791635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lt5BzKJWl1+VWLrk3wMeSjL67k1RqFJc11Gk5yw4aWc=;
        b=kjRpGOc5iKiYh0cBSXRnmt1sY1R6WcsQMwBIDmKBSStjWHUo8o18LPOk5vFinIuW2v
         VGetWLGpqeY/mhL/lXKt80YCWR/ZPywJwmWcYvnMU3T2RdhLSjQ08cq9j6yszRrsdfW8
         WdU1KsLhNBLY/6aNlsdSuec5X61J+g4f31TC7o7oo3k0NAF+FTc8CAGsZTM/KyVaL+z1
         LXLvUvY/dEyZni3A4DqMX7dNLMAG1+o0Qb3ydZ/mAyUWNxS84UNo0LelZWABePhlnRTY
         9rrNBDPiA/OGUyg0lIQLmZBD8/VaOTe7605bbHgRABRk/MVJlyyjmGtt3So3v4TDT+GE
         xNUA==
X-Gm-Message-State: AOJu0YzzJonHycQBPSRVZ0OaVurKM9e6WQI6YTRKJ8FQqnxU4VDjEzW3
	yfNA2i+XOPudfwa5snsfAENPk2Shv8KUzDAi8Gfzfyibbro34jIvkJWF+WyYA+i2
X-Gm-Gg: ASbGnctm7GKszIMgKsEsqf7EdnbyhRqvm/ydMmMFsyZ1KAdJEiB/6O1VydIOUzY0cHW
	9bWr32ITamDO2F+YwaryL7USDtWZCrBUraYYXbElkPjkvcDVL23DQH9poP+3NYPv8ORaKzVB2Sw
	P7ivS/3/OW1Nzngm4e04/ruZuQpgvWsYRTxiHpZhBtiORQ2KMvucvj+zx74YvYRSZ2rUjY9AL/F
	uAVcZElPUSUaPbnBUnY9NDvZCNWfuyysiSd+LW7azqVOWlQWS/dRTfYQhcrwGR3RqyqbeGmly4v
	+2bon3Ng5usp5NnJXuBhIz4rMa9Q3y3YOl2086PU7+3CB+Et30dXu4dTMy+341KEU7JI/9P6jjG
	MYVAMUd8rwhhRm84yZTlJmMs9jq/yjF2bov9/wo+xjiU7382gZTpwPMw5hixZeqzPvqJy
X-Google-Smtp-Source: AGHT+IF+PqayXz2vZ0GEzChJqy+H3jeweUi9o4j991eMNNqDtKct772asgn7pcpUA/TzdZv/B1qdtQ==
X-Received: by 2002:a17:902:db0c:b0:240:3913:7c84 with SMTP id d9443c01a7336-2462edee79bmr187793305ad.4.1756186835059;
        Mon, 25 Aug 2025 22:40:35 -0700 (PDT)
Received: from MacBookPro.mynetworksettings.com ([2600:1011:a18d:b49:590e:7cd2:dbfb:7c35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a058sm84744225ad.32.2025.08.25.22.40.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 22:40:34 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: droidbittin@gmail.com
Cc: linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	rene.herman@gmail.com
Subject: Re: Linux 3.17-rc3
Date: Mon, 25 Aug 2025 22:40:33 -0700
Message-Id: <20250826054033.38175-1-pauldzim@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CADo9pHjbJw9HXBqboLHaywAAjeEmMjnQfZnCXjTRVF3nHZh8rw@mail.gmail.com>
References: <CADo9pHjbJw9HXBqboLHaywAAjeEmMjnQfZnCXjTRVF3nHZh8rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> As suspected, rc3 ends up being a bit larger than usual, to balance
>> out the tiny rc2. Yes, 3.17 seems to be generally in pretty good
>> shape (...)
> 
> One would hope so, it being one mere day under 11 years since -rc2...
> 
> https://lore.kernel.org/lkml/CA+55aFz+3JzdB+sZgOFfzd9zczL=borNgLwZykx=_tOMD6n4qw@mail.gmail.com/

I think maybe Linus has finally blown a fuse ;^)

-Paul

