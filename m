Return-Path: <linux-kernel+bounces-791760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FC4B3BB93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAF11635DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E711A3142;
	Fri, 29 Aug 2025 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thinkerfit-com.20230601.gappssmtp.com header.i=@thinkerfit-com.20230601.gappssmtp.com header.b="J9iEb4c1"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956D33F3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471568; cv=none; b=AOC6mLxg8BcSBpJOj2Jz7v1Wr3zcGdfUrPau25klL3pr9pS2RGvb1O1Xs0OqzAbFG1fwY/98K7CqSgzkynaSPOa9RTexQgEA7gn0vx4RvdavdSckRUpUyEzBXIf0FzY/C0vUkAoAvomkaePdB52D+n7ADsOKpjhBLgvXTY0ddrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471568; c=relaxed/simple;
	bh=DCmPo0Xp3wYWMUC/2gCJtOPgUTlTD7t+ZyelMNSIwiY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qnk8En+O/FIxCb4FxShdUc6SEIzuB+//6lmahKAFn0cHC/9X5CdPXpRPWpYuhdmYQ/HokgNt4EJ0j5lCpbbCkmIzyYkObxp49uBWJYAUZ5bvIVUfbCvV04CGOgX9naX6ket8BkHF3hk9kMnzgF87llT5L3pJoitIlwfCrd27Lh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=thinkerfit.com; spf=fail smtp.mailfrom=thinkerfit.com; dkim=pass (2048-bit key) header.d=thinkerfit-com.20230601.gappssmtp.com header.i=@thinkerfit-com.20230601.gappssmtp.com header.b=J9iEb4c1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=thinkerfit.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=thinkerfit.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71ff2b20039so18396217b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thinkerfit-com.20230601.gappssmtp.com; s=20230601; t=1756471564; x=1757076364; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCmPo0Xp3wYWMUC/2gCJtOPgUTlTD7t+ZyelMNSIwiY=;
        b=J9iEb4c1mYfhwYPRsecgcC6lmToHz6bEAlTOgM3vouvqYvGEvoyCgbMER2SdLoXmYQ
         mz+8yJfn0HmHTf9DsbLjivY/GSppXU2psYqjFdxP1omdPuqSf15bQt86UQ2UV22ZfWxw
         HMq6AdUZ9Y74A8QWTTkbdr7GMM3W0k6cY2rQn6kMdJiZbCZc89baKIRln1lRT7FbekZJ
         9hfl9/zHqFFNlYMFeEdfPwGYojG9aTXQX6u23+9RGZEHJbj0SCbkE22ssE4ePxcFKNXJ
         3AZOLKLy7jW8M2f7ejHkm15X5hH8cBpSgZecp+3zBbZspsH16eGQ89nSVr5Wv+YyV0ao
         z4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471564; x=1757076364;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCmPo0Xp3wYWMUC/2gCJtOPgUTlTD7t+ZyelMNSIwiY=;
        b=gWnnovRg4n4PrjeBMcjWYLzv8OwT0sUttRzM7TbdlIW8i7Nm8na+poe4C+MNCMRSSB
         ZEJwc6yrqTCN5xNDrmfA3Ozw/IzqVKLI0oB5m+eXkMe0dRdspEF9wXJ3pVydA2tDCLIN
         lmNCp2X5fobiUrp0lRwS2TbvUacE6efTN1bc4W1Af3/CIt7De8ZEyH1dpd/50ApWm5rb
         K0HT/L7GbNcNUK3NHwhqe+HQrRMro7Wrom6LJGZwq2Popc9C82ONVYbG18s7eXPt80Xy
         Lam6VtltGP+vZoiqaMAYHUc/unTP+evfR5kL3b7Aq7NAdoSeu+OonvqXzYWviCaoLnYa
         jGJQ==
X-Gm-Message-State: AOJu0Yyj5CBcpVj0BtWZeOUGz1fTiVgdzpSKYQ1oNFn0xgSISy+BpwKP
	XBUorAA3MUettDw1Rlp2FRWQW2gPbS0ino07BHvBE+o3uafQOND94gGVvO9rA/AqehSMQ306nbz
	Pcx1IrzlHg7PJfP5ngN+m+h8uQ7o1ASsnlKEViv/qK/vEw9HCX4v9
X-Gm-Gg: ASbGncvsP4UC00qp2I0eeW0O0HzzxosYTs7OVWWeCIQZ9v3j8tKYSP2cTe/AHG5kbF7
	wJGxxdq2BnTrYkIDJ9+3jMlW4ku880rEOstwGYgnN5dIuXfPnwHwUEOpR0PVzbGofT/MnE2s7Ju
	eBqEmh+eV5vZ0xzSn/pz1eVrfWTkdBYfognJTCvpOr/2QvVJKsFWawUB/B/SbyI3dZ4Bkb9tpBT
	agdQucCifaJOjtK2VN1Rw==
X-Google-Smtp-Source: AGHT+IE8ll6/1UFF4sKOJE90gQ6pV2k63GK5EC7rNPjevTRKLxBAv5PhyRq38/UIVX+QcdlRHvDpa3Q1teW4dutvlT8=
X-Received: by 2002:a05:690c:5:b0:71f:b871:da40 with SMTP id
 00721157ae682-71fdc2dd09bmr318935467b3.18.1756471563485; Fri, 29 Aug 2025
 05:46:03 -0700 (PDT)
Received: from 116403764881 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Aug 2025 05:46:02 -0700
Received: from 116403764881 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Aug 2025 05:46:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jonathan Warner <jonathan@thinkerfit.com>
Date: Fri, 29 Aug 2025 05:46:02 -0700
X-Gm-Features: Ac12FXzdx1WyaXxIxIEScDtoq_xbX5jncZcsP-CDfVT0mVX4Nt77pp3BVngXT2g
Message-ID: <CA+ULVCk6QAXQBUQiAqUrwKyEhNh3Uaq=-J8EjL0GaFR0Q+R7yg@mail.gmail.com>
Subject: Eager to hear your thoughts on this!
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey there!

It's easy to get caught up in habits that harm our physical and mental
well-being without even realizing it. Taking a break and reflecting on
your actions can help you chart a better course for the future.

By checking in with yourself, you can create a roadmap for ditching
unhealthy habits and focusing on ones that benefit you.

Would you be interested in an article on this topic for your readers?
I can provide tips on developing a health-improvement plan that can
help break bad habits and live healthier, happier lives. Let me know
if you'd like to publish this piece on your website.

Thanks for your time!
Jonathan Warner


Thinkerfit.com - Make learning engaging for everyone!

P.S. By the way, if you don=E2=80=99t like the suggested topic, do reach ou=
t
to me with a topic that=E2=80=99s a better fit for your website. If you don=
=E2=80=99t
want to hear from me again, please let me know.

