Return-Path: <linux-kernel+bounces-784927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE664B343AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A83217F8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB70306D4B;
	Mon, 25 Aug 2025 14:19:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E1305E3B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131566; cv=none; b=NWeyL3tGdAJZGBXGpJVrOcL/6vFneApgFHSopO6fDyGDNY61ERmbiitk11ttnD+6fVTCYqyW2RVp0otXq7NIU0jjCCKB1ZvvUtgxwydyDjSJrhdPhuK7b35dywvidcVuj/gc7JDtg8dqLoNSuIVXN7NE8QSCxuIi2z9HcYX6jHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131566; c=relaxed/simple;
	bh=0OoyZAevQGUWuRtz/+g2GkwhEzG3VP40THnPKo1oYTI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=snj+V5/UIjJ1t/chNCr+cVwojQRmX4cBi/x+1cenLJiv4GZaeY+77E85zwDekVsTtKh4n8H3HJ6PVFVc6ou/Mhi0eoTCdnLP0HyBaosNy7aVC1A46208KF49TQDcTGynFP5oz3CZEs96r2oRgsJP1B7nX9G196LSy9I7d6lvKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3edfbb8d391so8324915ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131563; x=1756736363;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1rwYI62BaNAaG/PceXdFn6DBbUMKyUBjw2IAm0cJDs=;
        b=QTU994dY2DTxsVlHSSDCJABTJbUJQ52OkSmOsxfLTswgLZCIaQRwgjNlLfCkOAYHBB
         0SWv2QyDtpi8o9ioCmdd0Wk7WV3pixmHHB644Zwq4D8VuIjTW6LeuarPJ9skl0ybSA1i
         KKvc5rYhO010a1Pu5slywED7mHO0fWv84RyUy/6vSatptEJkV/VYpa62cgpLk5R+uwPe
         j2JvhXznU58GtBT/MrtS+kXf3kF7MNfB4mmm1P9RC3gmuWwf61rboLgHhVkPR0v/WG3H
         D9ITkEkozdwFes3Ysa6ZGhOscSA2s14IpDRgBGm6idFN08tpaAEn2Fwd1WHoDxy6Y/ES
         1Sug==
X-Forwarded-Encrypted: i=1; AJvYcCXxlN2NjpiFJQlzxLiyyvUDshOi2PrVfRRDZKyg8KepbRRhL6sxyy3yge21QaRzwHZDW7Dr3P6jBGQcFQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfdJAo7MCPae+cgMV5Uy8U2FYVomc6pcu73tUXOzsHJDeYPT2
	sY4XqyQCG+rfbNYFMnHNhDXiEDfbnqE1w57guSMGf7o6BCplL8dFcgJrhv3eMbqHyC7ITfpR0nc
	9oKHT4J3rofKKOZ8I2Je3gqmsQi3mbil12ltROZcJhy9Llm57X329KAf9hvU=
X-Google-Smtp-Source: AGHT+IEi85YmETPCUkCLWqWrTYUW1p/Y3YxFNB//qZ+98H555Ww/49bugmZGF8u9o+A3OO8WUcjooNoDFIq0UmzklOzY+komMMn6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3785:b0:3ec:f01:2d01 with SMTP id
 e9e14a558f8ab-3ec0f012f07mr16628915ab.29.1756131563221; Mon, 25 Aug 2025
 07:19:23 -0700 (PDT)
Date: Mon, 25 Aug 2025 07:19:23 -0700
In-Reply-To: <CABBYNZLdfvAtD+PX_gGsH5kYxmta4_dSKp-a_oKj4Et3PtzWEw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac70eb.050a0220.37038e.0093.GAE@google.com>
Subject: Re: 
From: syzbot <syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com>
To: luiz.dentz@gmail.com
Cc: luiz.dentz@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.

>
> -- 
> Luiz Augusto von Dentz

