Return-Path: <linux-kernel+bounces-891664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4BC43331
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 19:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044BB3AF4AB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F7255E43;
	Sat,  8 Nov 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWSuzOqw"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF43770FE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625772; cv=none; b=DOUCcdF0IAFOPICk9hXqmgmutsRPoVkWaHft1nmR6eM1LkQW37xXQZzwBPc10xvGCwVs+6IDw1b1AJ2jv1xikbBilQJk7FUoPAkPrc74oFDrNbAV4cFldnTg/ZvRRaxiUqOc62t3HPTuKEHXmqfE4rBrRnASOM2COxrZxYJhb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625772; c=relaxed/simple;
	bh=ZPjUommKJztOBHxthEBJJTdyLZRsZCkBgHvr26AmOpQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lr/nuwV/DZjLHXRO2Qtnd+eoOJH+HO8B4nEJ7DC/P7yWJepo+Eyeu4F6RifraGObf3LScpciX4+xZIH1Ggj1Gn0xpJKzPSFG2C6qCasxEFUV/NO/M743WiQQymyav6V5hotU1Ut1sPJdbTaeH1daXxKE+DX7R6rtvZUlhDu+Cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWSuzOqw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-882475d8851so254536d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 10:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762625768; x=1763230568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YpuhHnfYFh1OuHtBlzws854zn4cGJNw7nQ8ETfR9Qm0=;
        b=GWSuzOqwPE6UOysr5mvSmCbyswU+rS6V+E0gxmI1HcGsVqPz5918Z3tfY7Zlk/nyyC
         4EDmKYa4w6pg6QL4OTPg6hQpBvyGrup7N1eaVM4C59YlkX2F3P2I5mmX1QyfCiUl6o7U
         z9Q2ZJxO4uj3q4W6NvVFBWEdzutfqlb86ClDFgBntq3ZGFwffXJNA0J1FNHFIPvdHoUU
         aJ9oinGf8ffhCp+Xsi9aiFqyeMvZNcenszGrCzQ3315ovYZHDsvG9Tt7daAGij7/CyxK
         iKu7jiVuY2YkLLRNPbxysGKbGMkCOOgIzMEb5TDVMl0KPORpA0UDWGh3sz+f+Lry2ruC
         70Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625768; x=1763230568;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpuhHnfYFh1OuHtBlzws854zn4cGJNw7nQ8ETfR9Qm0=;
        b=wNL3BSjI2uECUNdPGKCf9KYj1bt8xaBtWLdWjaGsuSZshEe7tgLUPzbNVdoeYu0ODz
         YgUTGTWgN7BnSpY7BhzutLKOE1z7dbHP5rptKXPaGycWWJBT2/bQJKlsBeg7QdpD0RZC
         uBYOc1VRhWRyqsztjxksvmyGis0rF38ZUzUCCdD7TK+UguRUzOB9ge4+iBlcfKPsRiTU
         fxIcJw/CeSo5X40BpP1WdCexCcparJM1laLPOo1rh4pQWSfEuDx6wRFJqqi8crywk1U3
         MqZW4KqX33s/AFRihfo0b27wmiEDqQhIu4wU6ahwnm5nNB/B3HEW3Xsv/jcaKpeooJuV
         1W0g==
X-Forwarded-Encrypted: i=1; AJvYcCXhlKYwoVUvQBXT+GWrKfB596xqi+am6Yr/Zn/OtO+C1/XKdqf0hJQupS/sxVkZUpn+8ET2WUk9tvcMu8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYKL0cVpxnc3LNq04UycO4+ta9h3p6+cUsaSxnHvRj0p9UlUw
	lobr0aMNDwH5/UwcrUyVTIa9UuyhbHum/p3IDOVyw2XaHK13/nROZ2qSY4pAN5ZbpxzlShdOvrg
	cjb02o+RyeMmKV/e/Fn3Oqk9DsbuDk7U=
X-Gm-Gg: ASbGnct+LJ0ZsVSjkOhdL1dfKho+BXKgx7zzaC721Wj7rYDsmMPlM4R3fJpZghprXZG
	VUJ0AQle184PhbeBT1uZkVKm7x4hWUIZpVwrfSIZ5jT4fV7Ij1WyjNiCgWXve7W7KrzaDwL/ga6
	1vJ3n6YyXdzJvZAbbit7IclKmJynS2GIq7cc/xg4H6zW1AIbWFl8iIY3suEsVv8T6XrH9npPwmR
	Rci3+GLWxNhUSMButF6ZEf+4WOvoUtoOuWoZEpTQOnfbofzPiMQY1JgyzjgDEOwKH8dVcTHVQ/x
	l2wFpZCJBa75a27l+RqR85wHJ+PTqZa5gLc5ESbQ0ZHArEG9QZK8X6W+gygJvgYhh72ZHug/LuN
	Zih5gDNBCa+Yh+cMl57Efl45BYRQx4L937VvrnbuVwRzXWfrY3j3RETIr1rnvHGjLjemghJNUz7
	0AbCzLA1jPSA==
X-Google-Smtp-Source: AGHT+IGLP0vr9cIpKSHIEVh6wrvBWb8spM4WCyR4eNF9QEi5QisAGLNnyJVPq9/v7x8n7gYND2116ms7uTu+TimR9ko=
X-Received: by 2002:a05:6214:124f:b0:880:5813:1551 with SMTP id
 6a1803df08f44-8823861233bmr45789156d6.30.1762625768425; Sat, 08 Nov 2025
 10:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sat, 8 Nov 2025 12:15:57 -0600
X-Gm-Features: AWmQ_bnbraTGx_UJWPW4eq7AIIrgXBSBIEm2hU6QEBHRT6GLGfANddX7Us_1WdE
Message-ID: <CAH2r5ms=O10HuH9SvW59h=J50dmLUsqYTKoD8jqAvcn16aergw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/v6.18rc4-SMB-client-fixes

for you to fetch changes up to 4012abe8a78fbb8869634130024266eaef7081fe:

  smb: client: validate change notify buffer before copy (2025-11-07
10:15:43 -0600)

----------------------------------------------------------------
Three smb client fixes
- Fix change notify packet validation check
- Refcount fix (e.g. rename error paths)
- Fix potential UAF due to missing locks on directory lease refcount
----------------------------------------------------------------
Henrique Carvalho (1):
      smb: client: fix potential UAF in smb2_close_cached_fid()

Joshua Rogers (1):
      smb: client: validate change notify buffer before copy

Shuhao Fu (1):
      smb: client: fix refcount leak in smb2_set_path_attr

 fs/smb/client/cached_dir.c | 16 +++++++++-------
 fs/smb/client/smb2inode.c  |  2 ++
 fs/smb/client/smb2pdu.c    |  7 +++++--
 3 files changed, 16 insertions(+), 9 deletions(-)

-- 
Thanks,

Steve

