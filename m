Return-Path: <linux-kernel+bounces-878174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30850C1FF12
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504B64264ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8580337BAE;
	Thu, 30 Oct 2025 12:10:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51502FFF8F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826226; cv=none; b=tNYGaO9DV0Vd4tfv1LHt9HYaCLr8Abov0lN2VNYaJxtHt0nKW6kiasVYXWn3dzwdk6oyCoqCCecIr7oH4USJGTN/fkoeFbTUyWKlhRfwI8VbVRRe8CS549yzyU7O+avWRomz78ZGMTWg44KL03sOsKgOLVUR1+PtrApVwGVvWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826226; c=relaxed/simple;
	bh=9cDxoKCAtC5UJbyQWZCscB+65v+AruW1pVB6uNfkcFU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=CBSK4/87PW4cqjR6YCLQ1/pYxCM9h10jxd3H3toYe7A+vD4oyaeXihqOsAr8ZyTxOvWjmVz02yy7rGbnU9nN2Ko5kAgLvF3/1rkImnhcmo9jMfci3cRA58mfxFENAPNpPoazdEkuiv9RclFCGkAi9eTlgCv1fXUPzDWuUOI+Rd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430da49fcbbso12742285ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761826224; x=1762431024;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cDxoKCAtC5UJbyQWZCscB+65v+AruW1pVB6uNfkcFU=;
        b=PNAK5Gl0N6ZcBu79miOVIRyG2F3FJxDpCoASZ5mk6MKpn33M09DMs233Rmc7DXidc+
         Q7NKO4nOeUt8b0D3dk/r9bj6sQlFrXsh3+LbOGe0qMrORPfdpOpsiA+UlzPUN/iquozW
         MWN2UmnoJfKPq3cZmemoTvYaWi3YDi4IDPa6RJYPStXTAq6LjN/2mWUDahztg+0zjmy2
         2tHpsrzeU8Rq9xC7moGvIJvpVTPcKTUuKANIlU0KPozN8rtUL/DLV8EpaCHrRnPcqrFd
         f4D0C7m0vmgcxbAdQeRmEG24o/Nareud40ypLQgLFljnF1RzoXEwtygs0Rwl02kRC1LA
         PqCw==
X-Forwarded-Encrypted: i=1; AJvYcCW/+2S69BqxX2jvqyZIa/vkESM0Wu9XiepGyeJWDearw9X9Fn6Vq+BRbOkTC0D7BQsZK4v4b58BNe6uP3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGGvxg1xMCquk7bU7stdZw9R6Kd1kdcM5Jwt9G8OjBv88hkPVl
	YZ4KBaE1TZ33TuaMKCqs9IS4Ya5xr20L9CyRwGdfY0TelQhik24ZRwkjQYnAkn3OONdeYEru7jq
	ncXSatyj1BHKueI/PRUx7PV/pNmufSOV3zwsdCiqWCuEM25DpkzccsFeNPpk=
X-Google-Smtp-Source: AGHT+IFwS9ozil7l4peUIvxgc+2Wj1jpss3hOr+HGQvlnNpotP9xIcDZmlCg0Z+SXNx4yS9h/oz1BZ1z0XxSpRvQ6MYDLWzQYHVj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f13:b0:42e:7589:6290 with SMTP id
 e9e14a558f8ab-432f8fbe8b4mr94589405ab.12.1761826224035; Thu, 30 Oct 2025
 05:10:24 -0700 (PDT)
Date: Thu, 30 Oct 2025 05:10:24 -0700
In-Reply-To: <20251030121022.BXMn_%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690355b0.050a0220.3344a1.0440.GAE@google.com>
Subject: Re: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
From: syzbot <syzbot+a6969ef522a36d3344c9@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru
Cc: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"


This bug is already marked as fixed. No point in testing.


