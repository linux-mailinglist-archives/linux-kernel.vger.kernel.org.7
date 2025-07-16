Return-Path: <linux-kernel+bounces-733877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4D0B07A21
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A853ADBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2A2273D72;
	Wed, 16 Jul 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3WYU0Hy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7A1A841F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680552; cv=none; b=YIxzApueLswCDiIpgzypOj+NOTiAO+fcHbeJBUxSdOuBIEfPRMCn3+87MTG6/M4icZ+z6eGdO+r8Qd12C1VRpCw4kGmI5YMX/ZhfyYHmHf3+Bsb3kafFkkUvFPoRSRUxiKlvvf7ty8nW9J+2TPsfHtFbFzBaLXRPbNppNR+lLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680552; c=relaxed/simple;
	bh=h76MNZpvg3PD3BP0hhcapb3tGEq/Jmn/n9Wy2CzLnd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tpAQpbCeEFib3jL+FZrd7Hjwo7zYY+iFGPjEaIA8fuA/2RGLjnTzQ7ogOAiebLx9W3jF0SZvF2Gz3poe9AEDLF+60CJlvy14o3pY81/FpVhkcO2tDNdO5IV92vqsl2Ec1O2VQUhaPYttROVB1HizRG87Q3Y+TixkMwkxufhhFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3WYU0Hy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752680549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rndApbRUJH/9ySRaZuvuddd+LJ0qzZtoIf8UZGoyWl0=;
	b=h3WYU0HyKzFrKjr1ghuXyPKFSXN2bSH2ZHjt68yEZj3KYQUEb6i10zaz8LjDm7bds5lk54
	TKGrMpNN1gQZGUr8XaRpWJxc35Ap5sWPD2V5jOTp31FfcNWbDOy0RZenGd5bKSq1iYDMhT
	94183THpDQCE9a2vNgoUXCqjP+WoLp8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-2FKpjNpOM36c8lyZ2_qC2w-1; Wed, 16 Jul 2025 11:42:26 -0400
X-MC-Unique: 2FKpjNpOM36c8lyZ2_qC2w-1
X-Mimecast-MFC-AGG-ID: 2FKpjNpOM36c8lyZ2_qC2w_1752680546
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-456013b59c1so26852185e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680545; x=1753285345;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rndApbRUJH/9ySRaZuvuddd+LJ0qzZtoIf8UZGoyWl0=;
        b=GqrCEhQK+q1HKJ+2VbOUhvSieAknHvFyI+JCjke9kJGGv1pr33ZtvA34VpfbryDRC9
         XSujnGuFIgwlVXHiHzk27sZAftGgI/Css2TuG/zS/x+ZNMpscx9qKRxNmSUJ2WR+2FaZ
         tjEkvks2elalNuCOS5jlZaL1W/6NgibzQrBfjRuF9QgD52fIwGdaYHRlQLO93HdsCbsO
         iDnPt8Aejkah97O+U0mMFs7RqQI3Xm/smtzrLv8KLuIF5j65Re+ygTz3Cu7F9smpbCkn
         U7INlbB3eKxJctMXCjXsC3jYk7Mcm92fUjQDif+OuuO+IOSUiZutsXaywixQRidYn9tH
         0viA==
X-Forwarded-Encrypted: i=1; AJvYcCWFMtLahR4mpBkiTyc9xVfcd0gx4HDlI0xAVe+0swTKPRkRL9l1sZ1avJ2ZI38WZo00lr5/1xh6AnXPUrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNtnnCwxF6CYyLUIvp6C+ayM+OyBpsahMyPcqvovg/4Gq5Lq5t
	N+uk7dc4EbZy+0Et7bqvxzYgmPjdL2DzhXFs7hzg2JKaqvki19YVbWGsCxffnTzQz6XNpDL4fDj
	PVchHKW0EKxEx9plsnzLSD06L5SM4agcw+Mg/FOs9AJ83Ko0JvFLF2jdCTFa3vZAc0A==
X-Gm-Gg: ASbGncv7uIpSpO1aD7gvQQUWeFnw1CeMyRJfKmO25ux6+LpdcfRiipjN0KvSkTi5A/c
	NXUQzb6CaxAi3DYg4wd2WrKXBbo+UYA3VWaIPd6Hla+yE1IeYXxRzME1nL4eUGHDBlv49U3K15B
	fzNo5XZpEoF2eTP171DlWfWgTF7y83Vs0mMGM1idTM0A0/2acHBFnv8+wEIEzIdDtBJGQBTUEAb
	lW/qtTJBlCLeC215jaf4rGIQbFIJU1cwcJeeb96vEVH5/OLAZl8z6u4ODz2ZBgqnr0TCN7ABfE2
	xoa7/21NgjAs1/X5CvPiLpQNfFb7AjML+BwaGyyZWBR55lcREx5RskNvT+DZzsKiNHnGR37Hr4V
	Rgh8549PNB2EmIXgGcifKCo0=
X-Received: by 2002:a05:600c:4f85:b0:456:43d:1198 with SMTP id 5b1f17b1804b1-4562e3801ddmr31526005e9.32.1752680545545;
        Wed, 16 Jul 2025 08:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkT6yS8w4ehV4jjOkM8mP1KeYO29OfS+l5HmUZtNYcvdpsyg0R71zObOMaHVlGlr5caUOuqQ==
X-Received: by 2002:a05:600c:4f85:b0:456:43d:1198 with SMTP id 5b1f17b1804b1-4562e3801ddmr31525855e9.32.1752680545168;
        Wed, 16 Jul 2025 08:42:25 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e819c01sm24635795e9.19.2025.07.16.08.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:42:24 -0700 (PDT)
Message-ID: <0591ddb7-d279-4b13-bf2f-ffb913e82720@redhat.com>
Date: Wed, 16 Jul 2025 16:42:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
Content-Language: en-US
To: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
References: <68754d09.a70a0220.5f69f.0001.GAE@google.com>
Cc: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <68754d09.a70a0220.5f69f.0001.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2025 19:31, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    347e9f5043c8 Linux 6.16-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11afb18c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
> dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172470f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d0fd82580000


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next


