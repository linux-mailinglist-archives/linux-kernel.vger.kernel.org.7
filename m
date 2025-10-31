Return-Path: <linux-kernel+bounces-879724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A97C23D11
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB798188C402
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF09922172E;
	Fri, 31 Oct 2025 08:31:48 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE841DF965
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899508; cv=none; b=OeWmNf/8K1Z9c+TwZmQGnqyLNaWkX8MPMJs0VYAeSO8Od+7Ri/wOW8YbnJ2T7NXtcF5v+lc+AVK30dQfqjBVNK5RB0pFbpmaq6juuWUr6tSYXW1X1AV2R8UWQKhYVQtpLlKnUGJ4WdHqMnoKVDEjC2QMHNQae9qWxTZ2cneT9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899508; c=relaxed/simple;
	bh=/nj/g94yZZoUqNOe9qhlTUKEsBSWuB2shnu8bOGcmak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFPnnxxFrnc+VMSxPHMmn08xjh+qc6B1/uvC1LEMAAK9XvCfNpItVdKHCJqxJDt110TEdhDo6YsL8G32VaH2LQQ/CnmfzD19MEeQpqKg4QJ48HZXIEQkMcbwluUrHxbUuKmM0AeQhO8FBIYORBGpmXPBs2J8RHtT1b4lU75L7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2951a817541so10780635ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899505; x=1762504305;
        h=content-transfer-encoding:fcc:user-agent:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJVYBJYk+QKdyleamEHH3mIJfj4KS62ZWWHJ+kEKnaM=;
        b=U7fJlpkpPSDu+pKxvyu7YE9iCKpSyiYT9mM8ZdRtPHVAhkC1NQ+Pv0TAPIkhkO3dZw
         Yr/7siZjhKhYNToWk15kuP/LmBPeJOT45XK0MB43frcttxaNQIxM3gRzo73lP0j3x5i4
         hXT7I4cD2ZhSIgjwGaOD4hLtYluJ4besboQ9ntoq2wlXle55+Co4fVfhcNUJ7eL3/o1B
         fXDFCPjb3Y13I1fDpcZRLD4HfDsXf0qnuq/AFJXLjCjMWkMSXj26HQDPnAmrmTRn31g2
         5I1auDVoWi97k1mJ0ct7OMZSxHtwbs+w+i+i944dGq7LSp+f7+B5Qd2RjgnZrCOBo7NJ
         Myow==
X-Forwarded-Encrypted: i=1; AJvYcCVu23xWBtHwwk2ui/dy2AwPTEyY0+X7vnBwCSXxKyzVB8SBTUZIi4wCkNGvRPmH2doXYI38cHNbX6Zle/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXckUFGtVIu06c4FnNw+qygQkV3iXpWLw1ztxONADYkC+gjcU
	+xKrVOjrgsVrft3j54TFSy8bD8SoQ71Z36QKeCHmtU9TdXgAaMcLxNCW
X-Gm-Gg: ASbGncuZya9BpsR7aaMEDy5NjYLoW65w88bDPRypt4ppfFbHg+vqssGQlUXhoZPeZPl
	Tw8v/NgkVwT49dbSqVjGoBODJaCxiMp5DgcTUAvT+2txd/XmIrSnhRu+phTjhl+0BQ9mgemUx7s
	NLfKz7qfqNQ66dCRrqgKwFyvzvf7Gavi5297ltGFDTcb8F2E729u02GvgT7CWBtKd/Q40F+I0Wx
	xnylr+U1Wd23s4k7gSXuZQNvennBADZcddnd8G4Hzci47fa9z7XXU4ocEmBxjb92KHLn3KEML6/
	qRjrEAg2b/gUMawrp2IQTihSTTMsAaC56hdR5VUYYNJts+I7Nqnh1JjtCX5g5C1L6XsgS2Oqevh
	0VC1wOAlj0/UmFsO3hm7Cc6fiCBDaLxzuP6gVfeiA1vZax2iMc+sQhKOjkFZ0Hv4OkpGk30zm0B
	rSxCzvgb6Ml/dDVy6SIJ1QXiT9ciM=
X-Google-Smtp-Source: AGHT+IFhrFcWVwSsDY9O9tnbi3AnONEYcOyTbNlOy4ib0hR+Xx5JwJTXrPODaa80OW89xOOnyyo+hg==
X-Received: by 2002:a17:903:11c3:b0:290:c5e5:4d90 with SMTP id d9443c01a7336-2951a524561mr32538655ad.42.1761899504891;
        Fri, 31 Oct 2025 01:31:44 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bc8d4sm14533205ad.102.2025.10.31.01.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:31:44 -0700 (PDT)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: mathias.nyman@linux.intel.com,
	mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	xiehongyu1@kylinos.cn
Subject: Re: [PATCH v1] usb: xhci: limit run_graceperiod for only usb 3.0
 devices
Date: Fri, 31 Oct 2025 16:31:37 +0800
Message-Id: <b8ac5a69-22e0-4581-85cb-e8a8130e005e@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7d19444c-930e-4f43-b7bc-00c746d38cc0@linux.intel.com>
References: <20251017121254.2887283-1-xiehongyu1@kylinos.cn>
 <7d19444c-930e-4f43-b7bc-00c746d38cc0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://xiehongyu1%40kylinos.cn@mail.kylinos.cn/Sent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,=0D
   Anything new about this patch?=0D
=0D
=E5=9C=A8 2025/10/20 19:20, Mathias Nyman =E5=86=99=E9=81=93:=0D
> On 10/17/25 15:12, Hongyu Xie wrote:=0D
>> run_graceperiod blocks usb 2.0 devices from auto suspending after=0D
>> xhci_start for 500ms.=0D
>>=0D
>> Log shows:=0D
>> [=C2=A0=C2=A0 13.387170] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get=
 port =0D
>> status 7-1 read: 0x2a0, return 0x100=0D
>> [=C2=A0=C2=A0 13.387177] hub_event:5779: hub 7-0:1.0: state 7 ports 1 ch=
g 0000 =0D
>> evt 0000=0D
>> [=C2=A0=C2=A0 13.387182] hub_suspend:3903: hub 7-0:1.0: hub_suspend=0D
>> [=C2=A0=C2=A0 13.387188] hcd_bus_suspend:2250: usb usb7: bus auto-suspen=
d, wakeup 1=0D
>> [=C2=A0=C2=A0 13.387191] hcd_bus_suspend:2279: usb usb7: suspend raced w=
ith =0D
>> wakeup event=0D
>> [=C2=A0=C2=A0 13.387193] hcd_bus_resume:2303: usb usb7: usb auto-resume=
=0D
>> [=C2=A0=C2=A0 13.387296] hub_event:5779: hub 3-0:1.0: state 7 ports 1 ch=
g 0000 =0D
>> evt 0000=0D
>> [=C2=A0=C2=A0 13.393343] handle_port_status:2034: xhci-hcd PNP0D10:02: =
=0D
>> handle_port_status: starting usb5 port polling.=0D
>> [=C2=A0=C2=A0 13.393353] xhci_hub_control:1271: xhci-hcd PNP0D10:02: Get=
 port =0D
>> status 5-1 read: 0x206e1, return 0x10101=0D
>> [=C2=A0=C2=A0 13.400047] hub_suspend:3903: hub 3-0:1.0: hub_suspend=0D
>> [=C2=A0=C2=A0 13.403077] hub_resume:3948: hub 7-0:1.0: hub_resume=0D
>> [=C2=A0=C2=A0 13.403080] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get=
 port =0D
>> status 7-1 read: 0x2a0, return 0x100=0D
>> [=C2=A0=C2=A0 13.403085] hub_event:5779: hub 7-0:1.0: state 7 ports 1 ch=
g 0000 =0D
>> evt 0000=0D
>> [=C2=A0=C2=A0 13.403087] hub_suspend:3903: hub 7-0:1.0: hub_suspend=0D
>> [=C2=A0=C2=A0 13.403090] hcd_bus_suspend:2250: usb usb7: bus auto-suspen=
d, wakeup 1=0D
>> [=C2=A0=C2=A0 13.403093] hcd_bus_suspend:2279: usb usb7: suspend raced w=
ith =0D
>> wakeup event=0D
>> [=C2=A0=C2=A0 13.403095] hcd_bus_resume:2303: usb usb7: usb auto-resume=
=0D
>> [=C2=A0=C2=A0 13.405002] handle_port_status:1913: xhci-hcd PNP0D10:04: P=
ort =0D
>> change event, 9-1, id 1, portsc: 0x6e1=0D
>> [=C2=A0=C2=A0 13.405016] hub_activate:1169: usb usb5-port1: status 0101 =
change 0001=0D
>> [=C2=A0=C2=A0 13.405026] xhci_clear_port_change_bit:658: xhci-hcd PNP0D1=
0:02: =0D
>> clear port1 connect change, portsc: 0x6e1=0D
>> [=C2=A0=C2=A0 13.413275] hcd_bus_suspend:2250: usb usb3: bus auto-suspen=
d, wakeup 1=0D
>> [=C2=A0=C2=A0 13.419081] hub_resume:3948: hub 7-0:1.0: hub_resume=0D
>> [=C2=A0=C2=A0 13.419086] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get=
 port =0D
>> status 7-1 read: 0x2a0, return 0x100=0D
>> [=C2=A0=C2=A0 13.419095] hub_event:5779: hub 7-0:1.0: state 7 ports 1 ch=
g 0000 =0D
>> evt 0000=0D
>> [=C2=A0=C2=A0 13.419100] hub_suspend:3903: hub 7-0:1.0: hub_suspend=0D
>> [=C2=A0=C2=A0 13.419106] hcd_bus_suspend:2250: usb usb7: bus auto-suspen=
d, wakeup 1=0D
>> [=C2=A0=C2=A0 13.419110] hcd_bus_suspend:2279: usb usb7: suspend raced w=
ith =0D
>> wakeup event=0D
>> [=C2=A0=C2=A0 13.419112] hcd_bus_resume:2303: usb usb7: usb auto-resume=
=0D
>> [=C2=A0=C2=A0 13.420455] handle_port_status:2034: xhci-hcd PNP0D10:04: =
=0D
>> handle_port_status: starting usb9 port polling.=0D
>> [=C2=A0=C2=A0 13.420493] handle_port_status:1913: xhci-hcd PNP0D10:05: P=
ort =0D
>> change event, 10-1, id 1, portsc: 0x6e1=0D
>> [=C2=A0=C2=A0 13.425332] hcd_bus_suspend:2279: usb usb3: suspend raced w=
ith =0D
>> wakeup event=0D
>> [=C2=A0=C2=A0 13.431931] handle_port_status:2034: xhci-hcd PNP0D10:05: =
=0D
>> handle_port_status: starting usb10 port polling.=0D
>> [=C2=A0=C2=A0 13.435080] hub_resume:3948: hub 7-0:1.0: hub_resume=0D
>> [=C2=A0=C2=A0 13.435084] xhci_hub_control:1271: xhci-hcd PNP0D10:03: Get=
 port =0D
>> status 7-1 read: 0x2a0, return 0x100=0D
>> [=C2=A0=C2=A0 13.435092] hub_event:5779: hub 7-0:1.0: state 7 ports 1 ch=
g 0000 =0D
>> evt 0000=0D
>> [=C2=A0=C2=A0 13.435096] hub_suspend:3903: hub 7-0:1.0: hub_suspend=0D
>> [=C2=A0=C2=A0 13.435102] hcd_bus_suspend:2250: usb usb7: bus auto-suspen=
d, wakeup 1=0D
>> [=C2=A0=C2=A0 13.435106] hcd_bus_suspend:2279: usb usb7: suspend raced w=
ith =0D
>> wakeup event=0D
>>=0D
>> usb7 and other usb 2.0 root hub were rapidly toggling between suspend=0D
>> and resume states. More, "suspend raced with wakeup event" confuses =0D
>> people.=0D
>>=0D
>> So, limit run_graceperiod for only usb 3.0 devices=0D
>>=0D
>> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>=0D
> =0D
> Sounds reasonable. I don't recall USB 2.0 devices needing this.=0D
> =0D
> Hub driver has also changed a bit since the xhci run_graceperiod was adde=
d.=0D
> USB 3 hubs are no longer aggressively runtime suspending after resume. Se=
e:=0D
> 8f5b7e2bec1c usb: hub: fix detection of high tier USB3 devices behind =0D
> suspended hubs=0D
> =0D
> We could possibly get rid of the whole xhci run_graceperiod by extending =
=0D
> the hub driver=0D
> change to cover both init and resume paths.=0D
> =0D
> This patch is a good step in that direction=0D
> =0D
> Thanks=0D
> Mathias=0D
=0D

