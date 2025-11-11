Return-Path: <linux-kernel+bounces-895484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DECC4E127
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256073A2E62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318433AA1A0;
	Tue, 11 Nov 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kaist.ac.kr header.i=@kaist.ac.kr header.b="CYNkWLe0"
Received: from send004.gov-dooray.com (send004.gov-dooray.com [211.56.2.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E0324709
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.56.2.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866868; cv=none; b=e25cI/vxuiIM+OBMl8yjHqOl4DHZXc1KAb1WoHLu+/CMnCyJ0xbd1QQpK8D7iNMsrK6LJqCjTdfayWnPOG2kYT6jUP4SRYdNgZDosfBCEc6PXEGQvNgiYgCblFwdZ+HZg0G7myUdMCpkZ4wEb94UsIWDpYibwDhnX9blBIvbFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866868; c=relaxed/simple;
	bh=+d97qe4Ozg6+CARGN7PlepLEtORLA8RDjYFdmNbuuIQ=;
	h=From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:Date:
	 References:In-Reply-To; b=Eo2O841wdqQvJx+fwEidxOVuCfhCU95GCqGtcTCTMk5UP+kGLJgtInjKOv1YmBweG40t6fBcH4wUoJHcEVZU8MK6Bb46pSlZ3aBBGP4EP0ju5aWHBIRyzFBl59ubhodb7BfUixq3NcJtXwZky2PLocC0ioj7Len89lHh/+tkNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaist.ac.kr; spf=pass smtp.mailfrom=kaist.ac.kr; dkim=fail (2048-bit key) header.d=kaist.ac.kr header.i=@kaist.ac.kr header.b=CYNkWLe0 reason="signature verification failed"; arc=none smtp.client-ip=211.56.2.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaist.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaist.ac.kr
DKIM-Signature: a=rsa-sha256;
 b=CYNkWLe0/fo0Bi28NvIlW7aCdYUIGs6EnLzieVftf2vI59D0xxfy3W88xtG4kOA3jU0QroHZQo
  UqHLsrJMwxyUO6kjbwHiDz5WgaH/2fu03Cr01UV8QOKMyK3ZQl1NjL1mXZSgH2+n7bswNPGI5E2f
  kwTUO5xS0bTjNE9/OG0fIw6QGTUSAh8BcLZPbmCnWD7LJhdGO5Eoc4/BJX6vxXU7IjamDTtwr5Df
  Ioqkfpd6JMSMDkKWIy99QFzGzQNbCCpHhT5ElE9bo1sdh9u5A0qHQv1cZ8uny/uoAlWymxmSrr3u
  bW9xLzXhvVYxbsKFWW+SH1uydPWA5Cjv+UXv8orA==;
 c=relaxed/relaxed; s=dooray; d=kaist.ac.kr; v=1;
 bh=41GJSxcU6OWfbSONNktC6W0ijwqhQHehoeOBs6kSfj0=;
 h=From:To:Subject:Message-ID;
Dooray-Meta-Signature: 1dq+nyTPcs9b+QZCRibt3++Gj20u3kfxndJfQqrcUNt8j7aDbrn/y
  HiAWjjg7PTLpNdmjwyNDuTnnrvk3LuwAp67hZuqvy66co7oGDaA0i0WgJHQzW4jWuX1mgcPtBed/
  NuFTfC6HNwhX1jjTdswcHIam5CHwFtoykRBdU5EX1uWP6BSWAV7dIghyaNO21GTXaepDBzBm3B/o
  Rs/DDcetUIe3x3CdyqYJ1gZrXAmi1mg+kjelb3zJouvP7C4v1j51Y0KV1ffk2P53KiKMfD1HwPZQ
  Aehxjpcg4JLgzhjyTnT8MR9KdjfjYgdr7VvDY7PNYkVW4JjYdWal1rI7oZs1vkYeEBz05SvJC/I5
  xceVsY=
Received: from [143.248.56.91] (HELO 143.248.56.91) ([143.248.56.91]) by
 send004.gov-dooray.com with SMTP id 3be4630d691336ae; Tue, 11 Nov 2025
 22:14:22 +0900
From: Haein Lee <lhi0729@kaist.ac.kr>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Message-ID: <vwh7h2qfic1x.vwh7h2qc6b88.g5@dooray.com>
Subject: =?UTF-8?B?UkU6IFJlOiBbUEFUQ0hdIEFMU0E6IHVzYi1hdWRpbzogRml4IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiBzbmRfdXNiX21peGVyX2NvbnRyb2xzX2JhZGQ=?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_94736_393766498.1762866861171"
X-Dsn-Request: true
X-Dooray-Agent: mail-api
X-Dooray-Mail-Id: 4199017494367536261
Importance: Normal
X-Priority: Normal
X-MSMail-Priority: Normal
X-Dooray-Attached: c3+LUOpPU/IB7Wl+oemm0udz0DuzaG/UVv1SSLS4yUyKfjnsU60hSKwPf
 Y4gz0Q6GCtLup6YuKhROr6wpwSU3e3fIZrEWb7K08gJZe22Ki5MxfCGI8c9aLZVpAhAmNptL619s
 x43JQ9pxKCTKEPYKTeRKIdpBkgzqn5dzrNOm1bu6g0gI7VsBeEYW4z5x/JWcSnMNRqdQ8nDfUNDt
 0qioL1ZGhOCM1x7DPDYhQuJY0NNTZ5ql75Ys/LgklefEg215I4LSq9AMMrwOSZM5GNKpITb1Qp+X
 I8J6PZ4tey4zVN00P2wzXADuR6IeiZ5KyAXRlHgeV9nR+lDILSnDMGiCF+LcrCT6OjsjH3ejs6x5
 /jvWVptgcIPhNnzbnNEY6jYsUreuf5Cf/yHcgNzP/tFDtNwb0lVG8gN7bb6+bZkY9OXd4F04ec9V
 dkBKuajk79kv+r/cv8p3wF1zSXYMYnyufxKwEoWg5oSEtzVgul7nr8=
Sender: "Haein Lee" <lhi0729@kaist.ac.kr>
X-Dooray-Big-Attached: false
X-Dooray-ClientIp: 143.248.56.91
Date: Tue, 11 Nov 2025 22:14:21 +0900 (KST)
References: <vwh35su1p1d2.vwh35stxlm3p.g6@dooray.com>
	<874ir03fc6.wl-tiwai@suse.de>
In-Reply-To: <874ir03fc6.wl-tiwai@suse.de>

------=_Part_94736_393766498.1762866861171
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciB5b3VyIHF1aWNrIHJlc3BvbnNlLgoKVGhlIHByb2JsZW0gaXMgdGhhdCBg
YXNzb2NgIGluIHNuZF91c2JfY3JlYXRlX3N0cmVhbXMoKSBpcyBhIGxvY2FsIHZhcmlhYmxlLiBF
dmVuIHRob3VnaCBpdOKAmXMgYXNzaWduZWQgaW4gdGhlIE51Rm9yY2UgVURILTEwMCBjYXNlLCBp
dHMgc2NvcGUgaXMgbGltaXRlZCB0byB0aGUgZnVuY3Rpb24uIEFzIGEgcmVzdWx0LCB3aGVuIHNu
ZF91c2JfbWl4ZXJfY29udHJvbHNfYmFkZCgpIGxhdGVyIGFzc3VtZXMgdGhhdCBhc3NvYyBpcyB2
YWxpZCwgaXQgYWN0dWFsbHkgaXNu4oCZdC4KCkkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIHRoaXMg
YnVnIHVzaW5nIHN5emthbGxlciBvbiBteSBtYWNoaW5lLiBJ4oCZbGwgYXR0YWNoIHRoZSByZWxh
dGVkIG1hdGVyaWFscyDigJQgaXTigJlzIGJhc2ljYWxseSB0cmlnZ2VyZWQgYnkgc2VuZGluZyBh
IG1hbGljaW91cyBVU0IgZGV2aWNlIGRlc2NyaXB0b3IuCgpQZXJzb25hbGx5LCBJ4oCZbSBub3Qg
ZW50aXJlbHkgc2F0aXNmaWVkIHdpdGggdGhlIHBhdGNoLCBzaW5jZSBpdCBzdGlsbCBsZWF2ZXMg
dGhlIGNhc2Ugd2hlcmUgdXNiX2lmbnVtX3RvX2lmKGRldiwgY3RybGlmKS0+aW50Zl9hc3NvYyBp
cyBOVUxMIGV2ZW4gdGhvdWdoIHRoZSBCQUREIHByb2ZpbGUgaXMgdmFsaWQgKGFzIHNlZW4gaW4g
dGhlIE51Rm9yY2UgVURILTEwMCBjYXNlKS4gSG93ZXZlciwgSSBiZWxpZXZlIHRoaXMgaXMgdGhl
IG9ubHkgcmVtYWluaW5nIGNvZGUgb2YgdGhlIGlzc3VlLCBhbmQgYWRkaW5nIGEgZGVkaWNhdGVk
IGZ1bmN0aW9uIGp1c3QgZm9yIHRoaXMgY2FzZSB3b3VsZCBtYWtlIHRoZSBjb2RlIHVubmVjZXNz
YXJpbHkgY29tcGxleC4KClBsZWFzZSBjb3JyZWN0IG1lIGlmIEnigJltIHdyb25nLiBJZiB3ZSB3
cmFwIHVwIHRoaXMgZGlzY3Vzc2lvbiwgSeKAmWxsIHNlbmQgdGhlIHBhdGNoIGluIHRoZSBwcm9w
ZXIgZm9ybWF0LgoKVGhhbmtzLApIYWVpbiBMZWUKCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
CkZyb206ICAiVGFrYXNoaSBJd2FpIiA8dGl3YWlAc3VzZS5kZT4KVG86ICAgICAiSGFlaW4gTGVl
IiA8bGhpMDcyOUBrYWlzdC5hYy5rcj47IApDYzogICAgICA8cGVyZXhAcGVyZXguY3o+OyAgIDx0
aXdhaUBzdXNlLmNvbT47ICAgPGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZz47ICAgPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyAKU2VudDogIDIwMjUtMTEtMTEgKO2ZlCkgMjE6NDg6
MzAgKFVUQyswOTowMCkKU3ViamVjdDogUmU6IFtQQVRDSF0gQUxTQTogdXNiLWF1ZGlvOiBGaXgg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIHNuZF91c2JfbWl4ZXJfY29udHJvbHNfYmFkZAoK
T24gVHVlLCAxMSBOb3YgMjAyNSAxMzozNToxMyArMDEwMCwKSGFlaW4gTGVlIHdyb3RlOgo+IAo+
IAo+IEluIHNuZF91c2JfY3JlYXRlX3N0cmVhbXMoKSwgZm9yIFVBQyB2ZXJzaW9uIDMgZGV2aWNl
cywgdGhlIEludGVyZmFjZQo+IEFzc29jaWF0aW9uIERlc2NyaXB0b3IgKElBRCkgaXMgcmV0cmll
dmVkIHZpYSB1c2JfaWZudW1fdG9faWYoKS4gSWYgdGhpcwo+IGNhbGwgZmFpbHMsIGEgZmFsbGJh
Y2sgcm91dGluZSBhdHRlbXB0cyB0byBvYnRhaW4gdGhlIElBRCBmcm9tIHRoZSBuZXh0Cj4gaW50
ZXJmYWNlIGFuZCBzZXRzIGEgQkFERCBwcm9maWxlLiBIb3dldmVyLCBzbmRfdXNiX21peGVyX2Nv
bnRyb2xzX2JhZGQoKQo+IGFzc3VtZXMgdGhlIElBRCByZXRyaWV2ZWQgZnJvbSB1c2JfaWZudW1f
dG9faWYoKSBpcyBhbHdheXMgdmFsaWQgd2l0aG91dAo+IHBlcmZvcm1pbmcgYSBOVUxMIGNoZWNr
LiBUaGlzIGNhbiBsZWFkIHRvIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHdoZW4KPiB1c2Jf
aWZudW1fdG9faWYoKSBmYWlscyB0byBmaW5kIHRoZSBpbnRlcmZhY2UgZGVzY3JpcHRvci4KPiAK
PiBUaGlzIHBhdGNoIGFkZHMgYSBOVUxMIHBvaW50ZXIgY2hlY2sgYWZ0ZXIgY2FsbGluZyB1c2Jf
aWZudW1fdG9faWYoKSBpbgo+IHNuZF91c2JfbWl4ZXJfY29udHJvbHNfYmFkZCgpIHRvIHByZXZl
bnQgdGhlIGRlcmVmZXJlbmNlLgoKUHJhY3RpY2FsbHkgc2VlbiwgdGhpcyB3b24ndCBoYXBwZW4g
YmVjYXVzZSB0aGUgTlVMTCBpbnRmX2Fzc29jIGlzCmFscmVhZHkgY2hlY2tlZCBhdCBzbmRfdXNi
X2NyZWF0ZV9zdHJlYW1zKCkgYXMgYSBmYXRhbCBlcnJvciBiZWZvcmUKcmVhY2hpbmcgdGhpcyBw
b2ludC4gIEJ1dCBpdCB3b3VsZCBiZSBzdGlsbCBzYWZlciB0byBoYXZlIGEgc2FuaXR5CmNoZWNr
IGhlcmUsIHRvby4KCkluIGFueXdheSwgdGhlIHBhdGNoIHNlZW1zIHRvIGhhdmUgYSBiYWQgZm9y
bWF0IHRoYXQgY2FuJ3QgYmUKYXBwbGllZC4gIFRhYnMgYW5kIHNwYWNlcyBzZWVtIGNvcnJ1cHRl
ZCBieSB5b3VyIG1haWxlci4KCkNvdWxkIHlvdSByZXN1Ym1pdCB3aXRoIGEgcHJvcGVyIGZvcm1h
dCAoYW5kIGFkZCB0aGUgaW5mb3JtYXRpb24gSQptZW50aW9uZWQgaW4gdGhlIGFib3ZlKT8KCgp0
aGFua3MsCgpUYWthc2hpCgo+IC0tLQo+ICBzb3VuZC91c2IvbWl4ZXIuYyB8IDIgKysKPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9zb3VuZC91c2Iv
bWl4ZXIuYyBiL3NvdW5kL3VzYi9taXhlci5jCj4gaW5kZXggNmYwMGUwZDUyMzgyLi43MmI5MDA1
MDVkMmMgMTAwNjQ0Cj4gLS0tIGEvc291bmQvdXNiL21peGVyLmMKPiArKysgYi9zb3VuZC91c2Iv
bWl4ZXIuYwo+IEBAIC0zMDg2LDYgKzMwODYsOCBAQCBzdGF0aWMgaW50IHNuZF91c2JfbWl4ZXJf
Y29udHJvbHNfYmFkZChzdHJ1Y3QKPiB1c2JfbWl4ZXJfaW50ZXJmYWNlICptaXhlciwKPiAgICAg
IGludCBpOwo+ICAKPiAgICAgIGFzc29jID0gdXNiX2lmbnVtX3RvX2lmKGRldiwgY3RybGlmKS0+
aW50Zl9hc3NvYzsKPiArICAgIGlmICghYXNzb2MpCj4gKyAgICAgICAgcmV0dXJuIC1FSU5WQUw7
Cj4gIAo+ICAgICAgLyogRGV0ZWN0IEJBREQgY2FwdHVyZS9wbGF5YmFjayBjaGFubmVscyBmcm9t
IEFTIEVQIGRlc2NyaXB0b3JzICovCj4gICAgICBmb3IgKGkgPSAwOyBpIDwgYXNzb2MtPmJJbnRl
cmZhY2VDb3VudDsgaSsrKSB7Cj4gLS0gCj4gMi4zNC4xCj4gCj4gW21haWwtcl0KPiAK

------=_Part_94736_393766498.1762866861171
Content-Type: application/octet-stream; name=report0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=report0

usb 7-1: 0:4 : does not exist
usb 7-1: 0:5 : does not exist
usb 7-1: 0:6 : does not exist
usb 7-1: 0:7 : does not exist
usb 7-1: 0:8 : does not exist
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 8953 Comm: kworker/1:4 Not tainted 6.17.0-rc2-00013-g5003a65790ed #38 PREEMPT(voluntary) 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:snd_usb_mixer_controls_badd sound/usb/mixer.c:3078 [inline]
RIP: 0010:snd_usb_create_mixer+0xa4a/0x1ab0 sound/usb/mixer.c:3602
Code: 48 c1 e9 03 80 3c 11 00 0f 85 2d 0f 00 00 48 8b 40 18 48 8d 78 03 49 89 c7 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 19 0f 00 00
RSP: 0018:ffffc90005abee90 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11003d23a03
RDX: 0000000000000000 RSI: ffffffff849d60d1 RDI: 0000000000000003
RBP: ffff888021596600 R08: 0000000000000000 R09: ffff88806b196ab0
R10: 0000000000000000 R11: 00000000000630aa R12: ffff88801a8eaa18
R13: 0000000000000000 R14: ffff88801a8eaa18 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880df204000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd87d8fd750 CR3: 000000001bdf9000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 usb_audio_probe+0x78d/0x3b00 sound/usb/card.c:986
 usb_probe_interface+0x30b/0xa60 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x252/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1df/0x450 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:831
 __device_attach_driver+0x1db/0x2f0 drivers/base/dd.c:959
 bus_for_each_drv+0x148/0x1d0 drivers/base/bus.c:462
 __device_attach+0x1ee/0x4c0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1109/0x1a60 drivers/base/core.c:3689
 usb_set_configuration+0x1194/0x1c40 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb7/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xea/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x252/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1df/0x450 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:831
 __device_attach_driver+0x1db/0x2f0 drivers/base/dd.c:959
 bus_for_each_drv+0x148/0x1d0 drivers/base/bus.c:462
 __device_attach+0x1ee/0x4c0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1109/0x1a60 drivers/base/core.c:3689
 usb_new_device+0xd2c/0x1aa0 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2d99/0x4e60 drivers/usb/core/hub.c:5952
 process_one_work+0x98f/0x1b60 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x67e/0xe90 kernel/workqueue.c:3400
 kthread+0x3cd/0x780 kernel/kthread.c:463
 ret_from_fork+0x5b3/0x6c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:snd_usb_mixer_controls_badd sound/usb/mixer.c:3078 [inline]
RIP: 0010:snd_usb_create_mixer+0xa4a/0x1ab0 sound/usb/mixer.c:3602
Code: 48 c1 e9 03 80 3c 11 00 0f 85 2d 0f 00 00 48 8b 40 18 48 8d 78 03 49 89 c7 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 19 0f 00 00
RSP: 0018:ffffc90005abee90 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11003d23a03
RDX: 0000000000000000 RSI: ffffffff849d60d1 RDI: 0000000000000003
RBP: ffff888021596600 R08: 0000000000000000 R09: ffff88806b196ab0
R10: 0000000000000000 R11: 00000000000630aa R12: ffff88801a8eaa18
R13: 0000000000000000 R14: ffff88801a8eaa18 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880df204000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd87d8fd750 CR3: 000000001bdf9000 CR4: 0000000000750ef0
PKRU: 55555554
----------------
Code disassembly (best guess):
   0:	48 c1 e9 03          	shr    $0x3,%rcx
   4:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   8:	0f 85 2d 0f 00 00    	jne    0xf3b
   e:	48 8b 40 18          	mov    0x18(%rax),%rax
  12:	48 8d 78 03          	lea    0x3(%rax),%rdi
  16:	49 89 c7             	mov    %rax,%r15
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 08                	jg     0x40
  38:	84 c0                	test   %al,%al
  3a:	0f 85 19 0f 00 00    	jne    0xf59

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>


------=_Part_94736_393766498.1762866861171
Content-Type: application/octet-stream; name=repro.prog
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=repro.prog

# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false HandleSegv:false Trace:false CallComments:true LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
syz_usb_connect$uac1(0x4, 0x91, &(0x7f0000000000)=ANY=[@ANYBLOB="12010000010000104100410003000000000000007f00020109a001090400000001013000092401f7ff0a09000708240b040308750708240b0108012320090401000101023000072410080703000000000624400611050900082501ff0003d0030904020001010230000724100d06030600000006244003060f09058109c00001000008250102777c080000000000000000"], 0x0)
syz_usb_connect$uac1(0x3, 0x81, &(0x7f0000000000)=ANY=[@ANYBLOB="12010003010000080000000040000102030109026f00020104608f090400000001013000092401040009090003090401"], &(0x7f0000000580)={0x0, 0x0, 0x0, 0x0})

------=_Part_94736_393766498.1762866861171
Content-Type: application/octet-stream; name=repro.cprog
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=repro.cprog

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/usb/ch9.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...)
{
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1)
    return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

#define MAX_FDS 30

#define USB_MAX_IFACE_NUM 4
#define USB_MAX_EP_NUM 32
#define USB_MAX_FDS 6

struct usb_endpoint_index {
  struct usb_endpoint_descriptor desc;
  int handle;
};

struct usb_iface_index {
  struct usb_interface_descriptor* iface;
  uint8_t bInterfaceNumber;
  uint8_t bAlternateSetting;
  uint8_t bInterfaceClass;
  struct usb_endpoint_index eps[USB_MAX_EP_NUM];
  int eps_num;
};

struct usb_device_index {
  struct usb_device_descriptor* dev;
  struct usb_config_descriptor* config;
  uint8_t bDeviceClass;
  uint8_t bMaxPower;
  int config_length;
  struct usb_iface_index ifaces[USB_MAX_IFACE_NUM];
  int ifaces_num;
  int iface_cur;
};

struct usb_info {
  int fd;
  struct usb_device_index index;
};

static struct usb_info usb_devices[USB_MAX_FDS];

static struct usb_device_index* lookup_usb_index(int fd)
{
  for (int i = 0; i < USB_MAX_FDS; i++) {
    if (__atomic_load_n(&usb_devices[i].fd, __ATOMIC_ACQUIRE) == fd)
      return &usb_devices[i].index;
  }
  return NULL;
}

static int usb_devices_num;

static bool parse_usb_descriptor(const char* buffer, size_t length,
                                 struct usb_device_index* index)
{
  if (length < sizeof(*index->dev) + sizeof(*index->config))
    return false;
  memset(index, 0, sizeof(*index));
  index->dev = (struct usb_device_descriptor*)buffer;
  index->config = (struct usb_config_descriptor*)(buffer + sizeof(*index->dev));
  index->bDeviceClass = index->dev->bDeviceClass;
  index->bMaxPower = index->config->bMaxPower;
  index->config_length = length - sizeof(*index->dev);
  index->iface_cur = -1;
  size_t offset = 0;
  while (true) {
    if (offset + 1 >= length)
      break;
    uint8_t desc_length = buffer[offset];
    uint8_t desc_type = buffer[offset + 1];
    if (desc_length <= 2)
      break;
    if (offset + desc_length > length)
      break;
    if (desc_type == USB_DT_INTERFACE &&
        index->ifaces_num < USB_MAX_IFACE_NUM) {
      struct usb_interface_descriptor* iface =
          (struct usb_interface_descriptor*)(buffer + offset);
      index->ifaces[index->ifaces_num].iface = iface;
      index->ifaces[index->ifaces_num].bInterfaceNumber =
          iface->bInterfaceNumber;
      index->ifaces[index->ifaces_num].bAlternateSetting =
          iface->bAlternateSetting;
      index->ifaces[index->ifaces_num].bInterfaceClass = iface->bInterfaceClass;
      index->ifaces_num++;
    }
    if (desc_type == USB_DT_ENDPOINT && index->ifaces_num > 0) {
      struct usb_iface_index* iface = &index->ifaces[index->ifaces_num - 1];
      if (iface->eps_num < USB_MAX_EP_NUM) {
        memcpy(&iface->eps[iface->eps_num].desc, buffer + offset,
               sizeof(iface->eps[iface->eps_num].desc));
        iface->eps_num++;
      }
    }
    offset += desc_length;
  }
  return true;
}

static struct usb_device_index* add_usb_index(int fd, const char* dev,
                                              size_t dev_len)
{
  int i = __atomic_fetch_add(&usb_devices_num, 1, __ATOMIC_RELAXED);
  if (i >= USB_MAX_FDS)
    return NULL;
  if (!parse_usb_descriptor(dev, dev_len, &usb_devices[i].index))
    return NULL;
  __atomic_store_n(&usb_devices[i].fd, fd, __ATOMIC_RELEASE);
  return &usb_devices[i].index;
}

struct vusb_connect_string_descriptor {
  uint32_t len;
  char* str;
} __attribute__((packed));

struct vusb_connect_descriptors {
  uint32_t qual_len;
  char* qual;
  uint32_t bos_len;
  char* bos;
  uint32_t strs_len;
  struct vusb_connect_string_descriptor strs[0];
} __attribute__((packed));

static const char default_string[] = {8, USB_DT_STRING, 's', 0, 'y', 0, 'z', 0};

static const char default_lang_id[] = {4, USB_DT_STRING, 0x09, 0x04};

static bool
lookup_connect_response_in(int fd, const struct vusb_connect_descriptors* descs,
                           const struct usb_ctrlrequest* ctrl,
                           struct usb_qualifier_descriptor* qual,
                           char** response_data, uint32_t* response_length)
{
  struct usb_device_index* index = lookup_usb_index(fd);
  uint8_t str_idx;
  if (!index)
    return false;
  switch (ctrl->bRequestType & USB_TYPE_MASK) {
  case USB_TYPE_STANDARD:
    switch (ctrl->bRequest) {
    case USB_REQ_GET_DESCRIPTOR:
      switch (ctrl->wValue >> 8) {
      case USB_DT_DEVICE:
        *response_data = (char*)index->dev;
        *response_length = sizeof(*index->dev);
        return true;
      case USB_DT_CONFIG:
        *response_data = (char*)index->config;
        *response_length = index->config_length;
        return true;
      case USB_DT_STRING:
        str_idx = (uint8_t)ctrl->wValue;
        if (descs && str_idx < descs->strs_len) {
          *response_data = descs->strs[str_idx].str;
          *response_length = descs->strs[str_idx].len;
          return true;
        }
        if (str_idx == 0) {
          *response_data = (char*)&default_lang_id[0];
          *response_length = default_lang_id[0];
          return true;
        }
        *response_data = (char*)&default_string[0];
        *response_length = default_string[0];
        return true;
      case USB_DT_BOS:
        *response_data = descs->bos;
        *response_length = descs->bos_len;
        return true;
      case USB_DT_DEVICE_QUALIFIER:
        if (!descs->qual) {
          qual->bLength = sizeof(*qual);
          qual->bDescriptorType = USB_DT_DEVICE_QUALIFIER;
          qual->bcdUSB = index->dev->bcdUSB;
          qual->bDeviceClass = index->dev->bDeviceClass;
          qual->bDeviceSubClass = index->dev->bDeviceSubClass;
          qual->bDeviceProtocol = index->dev->bDeviceProtocol;
          qual->bMaxPacketSize0 = index->dev->bMaxPacketSize0;
          qual->bNumConfigurations = index->dev->bNumConfigurations;
          qual->bRESERVED = 0;
          *response_data = (char*)qual;
          *response_length = sizeof(*qual);
          return true;
        }
        *response_data = descs->qual;
        *response_length = descs->qual_len;
        return true;
      default:
        break;
      }
      break;
    default:
      break;
    }
    break;
  default:
    break;
  }
  return false;
}

typedef bool (*lookup_connect_out_response_t)(
    int fd, const struct vusb_connect_descriptors* descs,
    const struct usb_ctrlrequest* ctrl, bool* done);

static bool lookup_connect_response_out_generic(
    int fd, const struct vusb_connect_descriptors* descs,
    const struct usb_ctrlrequest* ctrl, bool* done)
{
  switch (ctrl->bRequestType & USB_TYPE_MASK) {
  case USB_TYPE_STANDARD:
    switch (ctrl->bRequest) {
    case USB_REQ_SET_CONFIGURATION:
      *done = true;
      return true;
    default:
      break;
    }
    break;
  }
  return false;
}

#define UDC_NAME_LENGTH_MAX 128

struct usb_raw_init {
  __u8 driver_name[UDC_NAME_LENGTH_MAX];
  __u8 device_name[UDC_NAME_LENGTH_MAX];
  __u8 speed;
};

enum usb_raw_event_type {
  USB_RAW_EVENT_INVALID = 0,
  USB_RAW_EVENT_CONNECT = 1,
  USB_RAW_EVENT_CONTROL = 2,
};

struct usb_raw_event {
  __u32 type;
  __u32 length;
  __u8 data[0];
};

struct usb_raw_ep_io {
  __u16 ep;
  __u16 flags;
  __u32 length;
  __u8 data[0];
};

#define USB_RAW_EPS_NUM_MAX 30
#define USB_RAW_EP_NAME_MAX 16
#define USB_RAW_EP_ADDR_ANY 0xff

struct usb_raw_ep_caps {
  __u32 type_control : 1;
  __u32 type_iso : 1;
  __u32 type_bulk : 1;
  __u32 type_int : 1;
  __u32 dir_in : 1;
  __u32 dir_out : 1;
};

struct usb_raw_ep_limits {
  __u16 maxpacket_limit;
  __u16 max_streams;
  __u32 reserved;
};

struct usb_raw_ep_info {
  __u8 name[USB_RAW_EP_NAME_MAX];
  __u32 addr;
  struct usb_raw_ep_caps caps;
  struct usb_raw_ep_limits limits;
};

struct usb_raw_eps_info {
  struct usb_raw_ep_info eps[USB_RAW_EPS_NUM_MAX];
};

#define USB_RAW_IOCTL_INIT _IOW('U', 0, struct usb_raw_init)
#define USB_RAW_IOCTL_RUN _IO('U', 1)
#define USB_RAW_IOCTL_EVENT_FETCH _IOR('U', 2, struct usb_raw_event)
#define USB_RAW_IOCTL_EP0_WRITE _IOW('U', 3, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP0_READ _IOWR('U', 4, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_ENABLE _IOW('U', 5, struct usb_endpoint_descriptor)
#define USB_RAW_IOCTL_EP_DISABLE _IOW('U', 6, __u32)
#define USB_RAW_IOCTL_EP_WRITE _IOW('U', 7, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_READ _IOWR('U', 8, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_CONFIGURE _IO('U', 9)
#define USB_RAW_IOCTL_VBUS_DRAW _IOW('U', 10, __u32)
#define USB_RAW_IOCTL_EPS_INFO _IOR('U', 11, struct usb_raw_eps_info)
#define USB_RAW_IOCTL_EP0_STALL _IO('U', 12)
#define USB_RAW_IOCTL_EP_SET_HALT _IOW('U', 13, __u32)
#define USB_RAW_IOCTL_EP_CLEAR_HALT _IOW('U', 14, __u32)
#define USB_RAW_IOCTL_EP_SET_WEDGE _IOW('U', 15, __u32)

static int usb_raw_open()
{
  return open("/dev/raw-gadget", O_RDWR);
}

static int usb_raw_init(int fd, uint32_t speed, const char* driver,
                        const char* device)
{
  struct usb_raw_init arg;
  strncpy((char*)&arg.driver_name[0], driver, sizeof(arg.driver_name));
  strncpy((char*)&arg.device_name[0], device, sizeof(arg.device_name));
  arg.speed = speed;
  return ioctl(fd, USB_RAW_IOCTL_INIT, &arg);
}

static int usb_raw_run(int fd)
{
  return ioctl(fd, USB_RAW_IOCTL_RUN, 0);
}

static int usb_raw_configure(int fd)
{
  return ioctl(fd, USB_RAW_IOCTL_CONFIGURE, 0);
}

static int usb_raw_vbus_draw(int fd, uint32_t power)
{
  return ioctl(fd, USB_RAW_IOCTL_VBUS_DRAW, power);
}

static int usb_raw_ep0_write(int fd, struct usb_raw_ep_io* io)
{
  return ioctl(fd, USB_RAW_IOCTL_EP0_WRITE, io);
}

static int usb_raw_ep0_read(int fd, struct usb_raw_ep_io* io)
{
  return ioctl(fd, USB_RAW_IOCTL_EP0_READ, io);
}

static int usb_raw_event_fetch(int fd, struct usb_raw_event* event)
{
  return ioctl(fd, USB_RAW_IOCTL_EVENT_FETCH, event);
}

static int usb_raw_ep_enable(int fd, struct usb_endpoint_descriptor* desc)
{
  return ioctl(fd, USB_RAW_IOCTL_EP_ENABLE, desc);
}

static int usb_raw_ep_disable(int fd, int ep)
{
  return ioctl(fd, USB_RAW_IOCTL_EP_DISABLE, ep);
}

static int usb_raw_ep0_stall(int fd)
{
  return ioctl(fd, USB_RAW_IOCTL_EP0_STALL, 0);
}

#define USB_MAX_PACKET_SIZE 4096

struct usb_raw_control_event {
  struct usb_raw_event inner;
  struct usb_ctrlrequest ctrl;
  char data[USB_MAX_PACKET_SIZE];
};

struct usb_raw_ep_io_data {
  struct usb_raw_ep_io inner;
  char data[USB_MAX_PACKET_SIZE];
};

static void set_interface(int fd, int n)
{
  struct usb_device_index* index = lookup_usb_index(fd);
  if (!index)
    return;
  if (index->iface_cur >= 0 && index->iface_cur < index->ifaces_num) {
    for (int ep = 0; ep < index->ifaces[index->iface_cur].eps_num; ep++) {
      int rv = usb_raw_ep_disable(
          fd, index->ifaces[index->iface_cur].eps[ep].handle);
      if (rv < 0) {
      } else {
      }
    }
  }
  if (n >= 0 && n < index->ifaces_num) {
    for (int ep = 0; ep < index->ifaces[n].eps_num; ep++) {
      int rv = usb_raw_ep_enable(fd, &index->ifaces[n].eps[ep].desc);
      if (rv < 0) {
      } else {
        index->ifaces[n].eps[ep].handle = rv;
      }
    }
    index->iface_cur = n;
  }
}

static int configure_device(int fd)
{
  struct usb_device_index* index = lookup_usb_index(fd);
  if (!index)
    return -1;
  int rv = usb_raw_vbus_draw(fd, index->bMaxPower);
  if (rv < 0) {
    return rv;
  }
  rv = usb_raw_configure(fd);
  if (rv < 0) {
    return rv;
  }
  set_interface(fd, 0);
  return 0;
}

static volatile long
syz_usb_connect_impl(uint64_t speed, uint64_t dev_len, const char* dev,
                     const struct vusb_connect_descriptors* descs,
                     lookup_connect_out_response_t lookup_connect_response_out)
{
  if (!dev) {
    return -1;
  }
  int fd = usb_raw_open();
  if (fd < 0) {
    return fd;
  }
  if (fd >= MAX_FDS) {
    close(fd);
    return -1;
  }
  struct usb_device_index* index = add_usb_index(fd, dev, dev_len);
  if (!index) {
    return -1;
  }
  char device[32];
  sprintf(&device[0], "dummy_udc.%llu", procid);
  int rv = usb_raw_init(fd, speed, "dummy_udc", &device[0]);
  if (rv < 0) {
    return rv;
  }
  rv = usb_raw_run(fd);
  if (rv < 0) {
    return rv;
  }
  bool done = false;
  while (!done) {
    struct usb_raw_control_event event;
    event.inner.type = 0;
    event.inner.length = sizeof(event.ctrl);
    rv = usb_raw_event_fetch(fd, (struct usb_raw_event*)&event);
    if (rv < 0) {
      return rv;
    }
    if (event.inner.type != USB_RAW_EVENT_CONTROL)
      continue;
    char* response_data = NULL;
    uint32_t response_length = 0;
    struct usb_qualifier_descriptor qual;
    if (event.ctrl.bRequestType & USB_DIR_IN) {
      if (!lookup_connect_response_in(fd, descs, &event.ctrl, &qual,
                                      &response_data, &response_length)) {
        usb_raw_ep0_stall(fd);
        continue;
      }
    } else {
      if (!lookup_connect_response_out(fd, descs, &event.ctrl, &done)) {
        usb_raw_ep0_stall(fd);
        continue;
      }
      response_data = NULL;
      response_length = event.ctrl.wLength;
    }
    if ((event.ctrl.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD &&
        event.ctrl.bRequest == USB_REQ_SET_CONFIGURATION) {
      rv = configure_device(fd);
      if (rv < 0) {
        return rv;
      }
    }
    struct usb_raw_ep_io_data response;
    response.inner.ep = 0;
    response.inner.flags = 0;
    if (response_length > sizeof(response.data))
      response_length = 0;
    if (event.ctrl.wLength < response_length)
      response_length = event.ctrl.wLength;
    response.inner.length = response_length;
    if (response_data)
      memcpy(&response.data[0], response_data, response_length);
    else
      memset(&response.data[0], 0, response_length);
    if (event.ctrl.bRequestType & USB_DIR_IN) {
      rv = usb_raw_ep0_write(fd, (struct usb_raw_ep_io*)&response);
    } else {
      rv = usb_raw_ep0_read(fd, (struct usb_raw_ep_io*)&response);
    }
    if (rv < 0) {
      return rv;
    }
  }
  sleep_ms(200);
  return fd;
}

static volatile long syz_usb_connect(volatile long a0, volatile long a1,
                                     volatile long a2, volatile long a3)
{
  uint64_t speed = a0;
  uint64_t dev_len = a1;
  const char* dev = (const char*)a2;
  const struct vusb_connect_descriptors* descs =
      (const struct vusb_connect_descriptors*)a3;
  return syz_usb_connect_impl(speed, dev_len, dev, descs,
                              &lookup_connect_response_out_generic);
}

static void kill_and_wait(int pid, int* status)
{
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid)
      return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) != pid) {
  }
}

static void setup_test()
{
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
  int iter = 0;
  for (;; iter++) {
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      sleep_ms(10);
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
        break;
      if (current_time_ms() - start < 5000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

void execute_one(void)
{
  if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {
  }
  //  syz_usb_connect$uac3 arguments: [
  //    speed: usb_device_speed = 0x4 (8 bytes)
  //    dev_len: len = 0x91 (8 bytes)
  //    dev: ptr[inout, array[ANYUNION]] {
  //      array[ANYUNION] {
  //        union ANYUNION {
  //          ANYBLOB: buffer: {12 01 00 00 01 00 00 10 41 00 41 00 03 00 00 00
  //          00 00 00 00 7f 00 02 01 09 a0 01 09 04 00 00 00 01 01 30 00 09 24
  //          01 f7 ff 0a 09 00 07 08 24 0b 04 03 08 75 07 08 24 0b 01 08 01 23
  //          20 09 04 01 00 01 01 02 30 00 07 24 10 08 07 03 00 00 00 00 06 24
  //          40 06 11 05 09 00 08 25 01 ff 00 03 d0 03 09 04 02 00 01 01 02 30
  //          00 07 24 10 0d 06 03 06 00 00 00 06 24 40 03 06 0f 09 05 81 09 c0
  //          00 01 00 00 08 25 01 02 77 7c 08 00 00 00 00 00 00 00 00} (length
  //          0x91)
  //        }
  //      }
  //    }
  //    conn_descs: nil
  //  ]
  //  returns fd_usb_uac3
  memcpy((void*)0x200000000000,
         "\x12\x01\x00\x00\x01\x00\x00\x10\x41\x00\x41\x00\x03\x00\x00\x00\x00"
         "\x00\x00\x00\x7f\x00\x02\x01\x09\xa0\x01\x09\x04\x00\x00\x00\x01\x01"
         "\x30\x00\x09\x24\x01\xf7\xff\x0a\x09\x00\x07\x08\x24\x0b\x04\x03\x08"
         "\x75\x07\x08\x24\x0b\x01\x08\x01\x23\x20\x09\x04\x01\x00\x01\x01\x02"
         "\x30\x00\x07\x24\x10\x08\x07\x03\x00\x00\x00\x00\x06\x24\x40\x06\x11"
         "\x05\x09\x00\x08\x25\x01\xff\x00\x03\xd0\x03\x09\x04\x02\x00\x01\x01"
         "\x02\x30\x00\x07\x24\x10\x0d\x06\x03\x06\x00\x00\x00\x06\x24\x40\x03"
         "\x06\x0f\x09\x05\x81\x09\xc0\x00\x01\x00\x00\x08\x25\x01\x02\x77\x7c"
         "\x08\x00\x00\x00\x00\x00\x00\x00\x00",
         145);
  syz_usb_connect(/*speed=USB_SPEED_WIRELESS*/ 4, /*dev_len=*/0x91,
                  /*dev=*/0x200000000000, /*conn_descs=*/0);
  //  syz_usb_connect$uac3 arguments: [
  //    speed: usb_device_speed = 0x3 (8 bytes)
  //    dev_len: len = 0x81 (8 bytes)
  //    dev: ptr[inout, array[ANYUNION]] {
  //      array[ANYUNION] {
  //        union ANYUNION {
  //          ANYBLOB: buffer: {12 01 00 03 01 00 00 08 00 00 00 00 40 00 01 02
  //          03 01 09 02 6f 00 02 01 04 60 8f 09 04 00 00 00 01 01 30 00 09 24
  //          01 04 00 09 09 00 03 09 04 01} (length 0x30)
  //        }
  //      }
  //    }
  //    conn_descs: ptr[in, vusb_connect_descriptors] {
  //      vusb_connect_descriptors {
  //        qual_len: len = 0x0 (4 bytes)
  //        qual: nil
  //        bos_len: len = 0x0 (4 bytes)
  //        bos: nil
  //        strs_len: len = 0x0 (4 bytes)
  //        strs: array[vusb_connect_string_descriptor] {
  //        }
  //      }
  //    }
  //  ]
  //  returns fd_usb_uac3
  memcpy((void*)0x200000000000,
         "\x12\x01\x00\x03\x01\x00\x00\x08\x00\x00\x00\x00\x40\x00\x01\x02\x03"
         "\x01\x09\x02\x6f\x00\x02\x01\x04\x60\x8f\x09\x04\x00\x00\x00\x01\x01"
         "\x30\x00\x09\x24\x01\x04\x00\x09\x09\x00\x03\x09\x04\x01",
         48);
  *(uint32_t*)0x200000000580 = 0;
  *(uint64_t*)0x200000000584 = 0;
  *(uint32_t*)0x20000000058c = 0;
  *(uint64_t*)0x200000000590 = 0;
  *(uint32_t*)0x200000000598 = 0;
  syz_usb_connect(/*speed=USB_SPEED_HIGH*/ 3, /*dev_len=*/0x81,
                  /*dev=*/0x200000000000, /*conn_descs=*/0x200000000580);
}
int main(void)
{
  syscall(__NR_mmap, /*addr=*/0x1ffffffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=*/(intptr_t)-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x200000000000ul, /*len=*/0x1000000ul,
          /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=*/(intptr_t)-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x200001000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=*/(intptr_t)-1, /*offset=*/0ul);
  const char* reason;
  (void)reason;
  loop();
  return 0;
}

------=_Part_94736_393766498.1762866861171
Content-Type: application/xml; name=.config
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=.config

#=0D=0A#=20Automatically=20generated=20file;=20DO=20NOT=20EDIT=2E=0D=0A#=20=
Linux/x86=206=2E18=2E0-rc5=20Kernel=20Configuration=0D=0A#=0D=0ACONFIG_CC_V=
ERSION_TEXT=3D"gcc=20(Ubuntu=2011=2E4=2E0-1ubuntu1~22=2E04=2E2)=2011=2E4=2E=
0"=0D=0ACONFIG_CC_IS_GCC=3Dy=0D=0ACONFIG_GCC_VERSION=3D110400=0D=0ACONFIG_C=
LANG_VERSION=3D0=0D=0ACONFIG_AS_IS_GNU=3Dy=0D=0ACONFIG_AS_VERSION=3D23800=
=0D=0ACONFIG_LD_IS_BFD=3Dy=0D=0ACONFIG_LD_VERSION=3D23800=0D=0ACONFIG_LLD_V=
ERSION=3D0=0D=0ACONFIG_RUSTC_VERSION=3D109000=0D=0ACONFIG_RUSTC_LLVM_VERSIO=
N=3D200108=0D=0ACONFIG_CC_CAN_LINK=3Dy=0D=0ACONFIG_GCC_ASM_GOTO_OUTPUT_BROK=
EN=3Dy=0D=0ACONFIG_TOOLS_SUPPORT_RELR=3Dy=0D=0ACONFIG_CC_HAS_ASM_INLINE=3Dy=
=0D=0ACONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy=0D=0ACONFIG_LD_CAN_USE_KEEP_IN_O=
VERLAY=3Dy=0D=0ACONFIG_RUSTC_HAS_COERCE_POINTEE=3Dy=0D=0ACONFIG_RUSTC_HAS_S=
PAN_FILE=3Dy=0D=0ACONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES=3Dy=0D=0ACONFIG_R=
USTC_HAS_FILE_WITH_NUL=3Dy=0D=0ACONFIG_PAHOLE_VERSION=3D125=0D=0ACONFIG_CON=
STRUCTORS=3Dy=0D=0ACONFIG_IRQ_WORK=3Dy=0D=0ACONFIG_BUILDTIME_TABLE_SORT=3Dy=
=0D=0ACONFIG_THREAD_INFO_IN_TASK=3Dy=0D=0A=0D=0A#=0D=0A#=20General=20setup=
=0D=0A#=0D=0ACONFIG_INIT_ENV_ARG_LIMIT=3D32=0D=0A#=20CONFIG_COMPILE_TEST=20=
is=20not=20set=0D=0A#=20CONFIG_WERROR=20is=20not=20set=0D=0ACONFIG_LOCALVER=
SION=3D""=0D=0ACONFIG_LOCALVERSION_AUTO=3Dy=0D=0ACONFIG_BUILD_SALT=3D""=0D=
=0ACONFIG_HAVE_KERNEL_GZIP=3Dy=0D=0ACONFIG_HAVE_KERNEL_BZIP2=3Dy=0D=0ACONFI=
G_HAVE_KERNEL_LZMA=3Dy=0D=0ACONFIG_HAVE_KERNEL_XZ=3Dy=0D=0ACONFIG_HAVE_KERN=
EL_LZO=3Dy=0D=0ACONFIG_HAVE_KERNEL_LZ4=3Dy=0D=0ACONFIG_HAVE_KERNEL_ZSTD=3Dy=
=0D=0ACONFIG_KERNEL_GZIP=3Dy=0D=0A#=20CONFIG_KERNEL_BZIP2=20is=20not=20set=
=0D=0A#=20CONFIG_KERNEL_LZMA=20is=20not=20set=0D=0A#=20CONFIG_KERNEL_XZ=20i=
s=20not=20set=0D=0A#=20CONFIG_KERNEL_LZO=20is=20not=20set=0D=0A#=20CONFIG_K=
ERNEL_LZ4=20is=20not=20set=0D=0A#=20CONFIG_KERNEL_ZSTD=20is=20not=20set=0D=
=0ACONFIG_DEFAULT_INIT=3D""=0D=0ACONFIG_DEFAULT_HOSTNAME=3D"(none)"=0D=0ACO=
NFIG_SYSVIPC=3Dy=0D=0ACONFIG_SYSVIPC_SYSCTL=3Dy=0D=0ACONFIG_SYSVIPC_COMPAT=
=3Dy=0D=0ACONFIG_POSIX_MQUEUE=3Dy=0D=0ACONFIG_POSIX_MQUEUE_SYSCTL=3Dy=0D=0A=
#=20CONFIG_WATCH_QUEUE=20is=20not=20set=0D=0ACONFIG_CROSS_MEMORY_ATTACH=3Dy=
=0D=0ACONFIG_AUDIT=3Dy=0D=0ACONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy=0D=0ACONFIG_A=
UDITSYSCALL=3Dy=0D=0A=0D=0A#=0D=0A#=20IRQ=20subsystem=0D=0A#=0D=0ACONFIG_GE=
NERIC_IRQ_PROBE=3Dy=0D=0ACONFIG_GENERIC_IRQ_SHOW=3Dy=0D=0ACONFIG_GENERIC_IR=
Q_EFFECTIVE_AFF_MASK=3Dy=0D=0ACONFIG_GENERIC_PENDING_IRQ=3Dy=0D=0ACONFIG_GE=
NERIC_IRQ_MIGRATION=3Dy=0D=0ACONFIG_HARDIRQS_SW_RESEND=3Dy=0D=0ACONFIG_IRQ_=
DOMAIN=3Dy=0D=0ACONFIG_IRQ_DOMAIN_HIERARCHY=3Dy=0D=0ACONFIG_GENERIC_MSI_IRQ=
=3Dy=0D=0ACONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy=0D=0ACONFIG_GENERIC_IRQ_R=
ESERVATION_MODE=3Dy=0D=0ACONFIG_IRQ_FORCED_THREADING=3Dy=0D=0ACONFIG_SPARSE=
_IRQ=3Dy=0D=0A#=20CONFIG_GENERIC_IRQ_DEBUGFS=20is=20not=20set=0D=0A#=20end=
=20of=20IRQ=20subsystem=0D=0A=0D=0ACONFIG_CLOCKSOURCE_WATCHDOG=3Dy=0D=0ACON=
FIG_ARCH_CLOCKSOURCE_INIT=3Dy=0D=0ACONFIG_GENERIC_TIME_VSYSCALL=3Dy=0D=0ACO=
NFIG_GENERIC_CLOCKEVENTS=3Dy=0D=0ACONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy=
=0D=0ACONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE=3Dy=0D=0ACONFIG_GENERIC_CLO=
CKEVENTS_MIN_ADJUST=3Dy=0D=0ACONFIG_GENERIC_CMOS_UPDATE=3Dy=0D=0ACONFIG_HAV=
E_POSIX_CPU_TIMERS_TASK_WORK=3Dy=0D=0ACONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy=
=0D=0ACONFIG_CONTEXT_TRACKING=3Dy=0D=0ACONFIG_CONTEXT_TRACKING_IDLE=3Dy=0D=
=0A=0D=0A#=0D=0A#=20Timers=20subsystem=0D=0A#=0D=0ACONFIG_TICK_ONESHOT=3Dy=
=0D=0ACONFIG_NO_HZ_COMMON=3Dy=0D=0A#=20CONFIG_HZ_PERIODIC=20is=20not=20set=
=0D=0ACONFIG_NO_HZ_IDLE=3Dy=0D=0A#=20CONFIG_NO_HZ_FULL=20is=20not=20set=0D=
=0ACONFIG_CONTEXT_TRACKING_USER=3Dy=0D=0A#=20CONFIG_CONTEXT_TRACKING_USER_F=
ORCE=20is=20not=20set=0D=0ACONFIG_NO_HZ=3Dy=0D=0ACONFIG_HIGH_RES_TIMERS=3Dy=
=0D=0ACONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=3D125=0D=0A#=20CONFIG_POSIX_A=
UX_CLOCKS=20is=20not=20set=0D=0A#=20end=20of=20Timers=20subsystem=0D=0A=0D=
=0ACONFIG_BPF=3Dy=0D=0ACONFIG_HAVE_EBPF_JIT=3Dy=0D=0ACONFIG_ARCH_WANT_DEFAU=
LT_BPF_JIT=3Dy=0D=0A=0D=0A#=0D=0A#=20BPF=20subsystem=0D=0A#=0D=0ACONFIG_BPF=
_SYSCALL=3Dy=0D=0ACONFIG_BPF_JIT=3Dy=0D=0A#=20CONFIG_BPF_JIT_ALWAYS_ON=20is=
=20not=20set=0D=0ACONFIG_BPF_JIT_DEFAULT_ON=3Dy=0D=0A#=20CONFIG_BPF_UNPRIV_=
DEFAULT_OFF=20is=20not=20set=0D=0A#=20CONFIG_BPF_PRELOAD=20is=20not=20set=
=0D=0A#=20CONFIG_BPF_LSM=20is=20not=20set=0D=0A#=20end=20of=20BPF=20subsyst=
em=0D=0A=0D=0ACONFIG_PREEMPT_BUILD=3Dy=0D=0ACONFIG_ARCH_HAS_PREEMPT_LAZY=3D=
y=0D=0A#=20CONFIG_PREEMPT_NONE=20is=20not=20set=0D=0ACONFIG_PREEMPT_VOLUNTA=
RY=3Dy=0D=0A#=20CONFIG_PREEMPT=20is=20not=20set=0D=0A#=20CONFIG_PREEMPT_LAZ=
Y=20is=20not=20set=0D=0A#=20CONFIG_PREEMPT_RT=20is=20not=20set=0D=0ACONFIG_=
PREEMPT_COUNT=3Dy=0D=0ACONFIG_PREEMPTION=3Dy=0D=0ACONFIG_PREEMPT_DYNAMIC=3D=
y=0D=0A#=20CONFIG_SCHED_CORE=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20CPU/Tas=
k=20time=20and=20stats=20accounting=0D=0A#=0D=0ACONFIG_VIRT_CPU_ACCOUNTING=
=3Dy=0D=0A#=20CONFIG_TICK_CPU_ACCOUNTING=20is=20not=20set=0D=0ACONFIG_VIRT_=
CPU_ACCOUNTING_GEN=3Dy=0D=0A#=20CONFIG_IRQ_TIME_ACCOUNTING=20is=20not=20set=
=0D=0ACONFIG_BSD_PROCESS_ACCT=3Dy=0D=0A#=20CONFIG_BSD_PROCESS_ACCT_V3=20is=
=20not=20set=0D=0ACONFIG_TASKSTATS=3Dy=0D=0ACONFIG_TASK_DELAY_ACCT=3Dy=0D=
=0ACONFIG_TASK_XACCT=3Dy=0D=0ACONFIG_TASK_IO_ACCOUNTING=3Dy=0D=0A#=20CONFIG=
_PSI=20is=20not=20set=0D=0A#=20end=20of=20CPU/Task=20time=20and=20stats=20a=
ccounting=0D=0A=0D=0ACONFIG_CPU_ISOLATION=3Dy=0D=0A=0D=0A#=0D=0A#=20RCU=20S=
ubsystem=0D=0A#=0D=0ACONFIG_TREE_RCU=3Dy=0D=0ACONFIG_PREEMPT_RCU=3Dy=0D=0A#=
=20CONFIG_RCU_EXPERT=20is=20not=20set=0D=0ACONFIG_TREE_SRCU=3Dy=0D=0ACONFIG=
_TASKS_RCU_GENERIC=3Dy=0D=0ACONFIG_NEED_TASKS_RCU=3Dy=0D=0ACONFIG_TASKS_RCU=
=3Dy=0D=0ACONFIG_TASKS_TRACE_RCU=3Dy=0D=0ACONFIG_RCU_STALL_COMMON=3Dy=0D=0A=
CONFIG_RCU_NEED_SEGCBLIST=3Dy=0D=0A#=20end=20of=20RCU=20Subsystem=0D=0A=0D=
=0A#=20CONFIG_IKCONFIG=20is=20not=20set=0D=0A#=20CONFIG_IKHEADERS=20is=20no=
t=20set=0D=0ACONFIG_LOG_BUF_SHIFT=3D18=0D=0ACONFIG_LOG_CPU_MAX_BUF_SHIFT=3D=
12=0D=0A#=20CONFIG_PRINTK_INDEX=20is=20not=20set=0D=0ACONFIG_HAVE_UNSTABLE_=
SCHED_CLOCK=3Dy=0D=0A=0D=0A#=0D=0A#=20Scheduler=20features=0D=0A#=0D=0A#=20=
CONFIG_UCLAMP_TASK=20is=20not=20set=0D=0A#=20CONFIG_SCHED_PROXY_EXEC=20is=
=20not=20set=0D=0A#=20end=20of=20Scheduler=20features=0D=0A=0D=0ACONFIG_ARC=
H_SUPPORTS_NUMA_BALANCING=3Dy=0D=0ACONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=
=3Dy=0D=0ACONFIG_CC_HAS_INT128=3Dy=0D=0ACONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-=
Wimplicit-fallthrough=3D5"=0D=0ACONFIG_GCC10_NO_ARRAY_BOUNDS=3Dy=0D=0ACONFI=
G_CC_NO_ARRAY_BOUNDS=3Dy=0D=0ACONFIG_GCC_NO_STRINGOP_OVERFLOW=3Dy=0D=0ACONF=
IG_CC_NO_STRINGOP_OVERFLOW=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_INT128=3Dy=0D=0A#=
=20CONFIG_NUMA_BALANCING=20is=20not=20set=0D=0ACONFIG_SLAB_OBJ_EXT=3Dy=0D=
=0ACONFIG_CGROUPS=3Dy=0D=0ACONFIG_PAGE_COUNTER=3Dy=0D=0A#=20CONFIG_CGROUP_F=
AVOR_DYNMODS=20is=20not=20set=0D=0ACONFIG_MEMCG=3Dy=0D=0ACONFIG_MEMCG_V1=3D=
y=0D=0ACONFIG_BLK_CGROUP=3Dy=0D=0ACONFIG_CGROUP_WRITEBACK=3Dy=0D=0ACONFIG_C=
GROUP_SCHED=3Dy=0D=0ACONFIG_GROUP_SCHED_WEIGHT=3Dy=0D=0ACONFIG_FAIR_GROUP_S=
CHED=3Dy=0D=0A#=20CONFIG_CFS_BANDWIDTH=20is=20not=20set=0D=0A#=20CONFIG_RT_=
GROUP_SCHED=20is=20not=20set=0D=0ACONFIG_SCHED_MM_CID=3Dy=0D=0ACONFIG_CGROU=
P_PIDS=3Dy=0D=0ACONFIG_CGROUP_RDMA=3Dy=0D=0A#=20CONFIG_CGROUP_DMEM=20is=20n=
ot=20set=0D=0ACONFIG_CGROUP_FREEZER=3Dy=0D=0ACONFIG_CGROUP_HUGETLB=3Dy=0D=
=0ACONFIG_CPUSETS=3Dy=0D=0A#=20CONFIG_CPUSETS_V1=20is=20not=20set=0D=0ACONF=
IG_CGROUP_DEVICE=3Dy=0D=0ACONFIG_CGROUP_CPUACCT=3Dy=0D=0ACONFIG_CGROUP_PERF=
=3Dy=0D=0A#=20CONFIG_CGROUP_BPF=20is=20not=20set=0D=0ACONFIG_CGROUP_MISC=3D=
y=0D=0ACONFIG_CGROUP_DEBUG=3Dy=0D=0ACONFIG_SOCK_CGROUP_DATA=3Dy=0D=0ACONFIG=
_NAMESPACES=3Dy=0D=0ACONFIG_UTS_NS=3Dy=0D=0ACONFIG_TIME_NS=3Dy=0D=0ACONFIG_=
IPC_NS=3Dy=0D=0ACONFIG_USER_NS=3Dy=0D=0ACONFIG_PID_NS=3Dy=0D=0ACONFIG_NET_N=
S=3Dy=0D=0A#=20CONFIG_CHECKPOINT_RESTORE=20is=20not=20set=0D=0A#=20CONFIG_S=
CHED_AUTOGROUP=20is=20not=20set=0D=0ACONFIG_RELAY=3Dy=0D=0ACONFIG_BLK_DEV_I=
NITRD=3Dy=0D=0ACONFIG_INITRAMFS_SOURCE=3D""=0D=0ACONFIG_RD_GZIP=3Dy=0D=0ACO=
NFIG_RD_BZIP2=3Dy=0D=0ACONFIG_RD_LZMA=3Dy=0D=0ACONFIG_RD_XZ=3Dy=0D=0ACONFIG=
_RD_LZO=3Dy=0D=0ACONFIG_RD_LZ4=3Dy=0D=0ACONFIG_RD_ZSTD=3Dy=0D=0A#=20CONFIG_=
BOOT_CONFIG=20is=20not=20set=0D=0ACONFIG_INITRAMFS_PRESERVE_MTIME=3Dy=0D=0A=
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy=0D=0A#=20CONFIG_CC_OPTIMIZE_FOR_SIZE=
=20is=20not=20set=0D=0ACONFIG_LD_ORPHAN_WARN=3Dy=0D=0ACONFIG_LD_ORPHAN_WARN=
_LEVEL=3D"warn"=0D=0ACONFIG_SYSCTL=3Dy=0D=0ACONFIG_HAVE_UID16=3Dy=0D=0ACONF=
IG_SYSCTL_EXCEPTION_TRACE=3Dy=0D=0A#=20CONFIG_SYSFS_SYSCALL=20is=20not=20se=
t=0D=0ACONFIG_HAVE_PCSPKR_PLATFORM=3Dy=0D=0ACONFIG_EXPERT=3Dy=0D=0ACONFIG_U=
ID16=3Dy=0D=0ACONFIG_MULTIUSER=3Dy=0D=0ACONFIG_SGETMASK_SYSCALL=3Dy=0D=0ACO=
NFIG_FHANDLE=3Dy=0D=0ACONFIG_POSIX_TIMERS=3Dy=0D=0ACONFIG_PRINTK=3Dy=0D=0AC=
ONFIG_BUG=3Dy=0D=0ACONFIG_ELF_CORE=3Dy=0D=0ACONFIG_PCSPKR_PLATFORM=3Dy=0D=
=0A#=20CONFIG_BASE_SMALL=20is=20not=20set=0D=0ACONFIG_FUTEX=3Dy=0D=0ACONFIG=
_FUTEX_PI=3Dy=0D=0ACONFIG_FUTEX_PRIVATE_HASH=3Dy=0D=0ACONFIG_FUTEX_MPOL=3Dy=
=0D=0ACONFIG_EPOLL=3Dy=0D=0ACONFIG_SIGNALFD=3Dy=0D=0ACONFIG_TIMERFD=3Dy=0D=
=0ACONFIG_EVENTFD=3Dy=0D=0ACONFIG_SHMEM=3Dy=0D=0ACONFIG_AIO=3Dy=0D=0ACONFIG=
_IO_URING=3Dy=0D=0A#=20CONFIG_IO_URING_MOCK_FILE=20is=20not=20set=0D=0ACONF=
IG_ADVISE_SYSCALLS=3Dy=0D=0ACONFIG_MEMBARRIER=3Dy=0D=0ACONFIG_KCMP=3Dy=0D=
=0ACONFIG_RSEQ=3Dy=0D=0A#=20CONFIG_DEBUG_RSEQ=20is=20not=20set=0D=0ACONFIG_=
CACHESTAT_SYSCALL=3Dy=0D=0ACONFIG_KALLSYMS=3Dy=0D=0A#=20CONFIG_KALLSYMS_SEL=
FTEST=20is=20not=20set=0D=0ACONFIG_KALLSYMS_ALL=3Dy=0D=0ACONFIG_ARCH_HAS_ME=
MBARRIER_SYNC_CORE=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS=3Dy=
=0D=0ACONFIG_HAVE_PERF_EVENTS=3Dy=0D=0A=0D=0A#=0D=0A#=20Kernel=20Performanc=
e=20Events=20And=20Counters=0D=0A#=0D=0ACONFIG_PERF_EVENTS=3Dy=0D=0A#=20CON=
FIG_DEBUG_PERF_USE_VMALLOC=20is=20not=20set=0D=0A#=20end=20of=20Kernel=20Pe=
rformance=20Events=20And=20Counters=0D=0A=0D=0ACONFIG_SYSTEM_DATA_VERIFICAT=
ION=3Dy=0D=0ACONFIG_PROFILING=3Dy=0D=0ACONFIG_TRACEPOINTS=3Dy=0D=0A=0D=0A#=
=0D=0A#=20Kexec=20and=20crash=20features=0D=0A#=0D=0ACONFIG_CRASH_RESERVE=
=3Dy=0D=0ACONFIG_VMCORE_INFO=3Dy=0D=0ACONFIG_KEXEC_CORE=3Dy=0D=0ACONFIG_KEX=
EC=3Dy=0D=0A#=20CONFIG_KEXEC_FILE=20is=20not=20set=0D=0A#=20CONFIG_KEXEC_JU=
MP=20is=20not=20set=0D=0A#=20CONFIG_KEXEC_HANDOVER=20is=20not=20set=0D=0ACO=
NFIG_CRASH_DUMP=3Dy=0D=0ACONFIG_CRASH_HOTPLUG=3Dy=0D=0ACONFIG_CRASH_MAX_MEM=
ORY_RANGES=3D8192=0D=0A#=20end=20of=20Kexec=20and=20crash=20features=0D=0A#=
=20end=20of=20General=20setup=0D=0A=0D=0ACONFIG_64BIT=3Dy=0D=0ACONFIG_X86_6=
4=3Dy=0D=0ACONFIG_X86=3Dy=0D=0ACONFIG_INSTRUCTION_DECODER=3Dy=0D=0ACONFIG_O=
UTPUT_FORMAT=3D"elf64-x86-64"=0D=0ACONFIG_LOCKDEP_SUPPORT=3Dy=0D=0ACONFIG_S=
TACKTRACE_SUPPORT=3Dy=0D=0ACONFIG_MMU=3Dy=0D=0ACONFIG_ARCH_MMAP_RND_BITS_MI=
N=3D28=0D=0ACONFIG_ARCH_MMAP_RND_BITS_MAX=3D32=0D=0ACONFIG_ARCH_MMAP_RND_CO=
MPAT_BITS_MIN=3D8=0D=0ACONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16=0D=0ACONFI=
G_GENERIC_ISA_DMA=3Dy=0D=0ACONFIG_GENERIC_CSUM=3Dy=0D=0ACONFIG_GENERIC_BUG=
=3Dy=0D=0ACONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy=0D=0ACONFIG_ARCH_MAY_HAV=
E_PC_FDC=3Dy=0D=0ACONFIG_GENERIC_CALIBRATE_DELAY=3Dy=0D=0ACONFIG_ARCH_HAS_C=
PU_RELAX=3Dy=0D=0ACONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy=0D=0ACONFIG_ARCH_SUS=
PEND_POSSIBLE=3Dy=0D=0ACONFIG_AUDIT_ARCH=3Dy=0D=0ACONFIG_KASAN_SHADOW_OFFSE=
T=3D0xdffffc0000000000=0D=0ACONFIG_HAVE_INTEL_TXT=3Dy=0D=0ACONFIG_ARCH_SUPP=
ORTS_UPROBES=3Dy=0D=0ACONFIG_FIX_EARLYCON_MEM=3Dy=0D=0ACONFIG_PGTABLE_LEVEL=
S=3D5=0D=0A=0D=0A#=0D=0A#=20Processor=20type=20and=20features=0D=0A#=0D=0AC=
ONFIG_SMP=3Dy=0D=0ACONFIG_X86_X2APIC=3Dy=0D=0ACONFIG_X86_MPPARSE=3Dy=0D=0A#=
=20CONFIG_X86_CPU_RESCTRL=20is=20not=20set=0D=0A#=20CONFIG_X86_FRED=20is=20=
not=20set=0D=0ACONFIG_X86_EXTENDED_PLATFORM=3Dy=0D=0A#=20CONFIG_X86_NUMACHI=
P=20is=20not=20set=0D=0A#=20CONFIG_X86_VSMP=20is=20not=20set=0D=0A#=20CONFI=
G_X86_INTEL_MID=20is=20not=20set=0D=0A#=20CONFIG_X86_GOLDFISH=20is=20not=20=
set=0D=0A#=20CONFIG_X86_INTEL_LPSS=20is=20not=20set=0D=0A#=20CONFIG_X86_AMD=
_PLATFORM_DEVICE=20is=20not=20set=0D=0ACONFIG_IOSF_MBI=3Dy=0D=0A#=20CONFIG_=
IOSF_MBI_DEBUG=20is=20not=20set=0D=0ACONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy=
=0D=0ACONFIG_SCHED_OMIT_FRAME_POINTER=3Dy=0D=0ACONFIG_HYPERVISOR_GUEST=3Dy=
=0D=0ACONFIG_PARAVIRT=3Dy=0D=0ACONFIG_PARAVIRT_DEBUG=3Dy=0D=0ACONFIG_PARAVI=
RT_SPINLOCKS=3Dy=0D=0ACONFIG_X86_HV_CALLBACK_VECTOR=3Dy=0D=0A#=20CONFIG_XEN=
=20is=20not=20set=0D=0ACONFIG_KVM_GUEST=3Dy=0D=0ACONFIG_ARCH_CPUIDLE_HALTPO=
LL=3Dy=0D=0ACONFIG_PVH=3Dy=0D=0A#=20CONFIG_PARAVIRT_TIME_ACCOUNTING=20is=20=
not=20set=0D=0ACONFIG_PARAVIRT_CLOCK=3Dy=0D=0A#=20CONFIG_JAILHOUSE_GUEST=20=
is=20not=20set=0D=0A#=20CONFIG_ACRN_GUEST=20is=20not=20set=0D=0A#=20CONFIG_=
BHYVE_GUEST=20is=20not=20set=0D=0ACONFIG_CC_HAS_MARCH_NATIVE=3Dy=0D=0A#=20C=
ONFIG_X86_NATIVE_CPU=20is=20not=20set=0D=0ACONFIG_X86_INTERNODE_CACHE_SHIFT=
=3D6=0D=0ACONFIG_X86_L1_CACHE_SHIFT=3D6=0D=0ACONFIG_X86_TSC=3Dy=0D=0ACONFIG=
_X86_HAVE_PAE=3Dy=0D=0ACONFIG_X86_CX8=3Dy=0D=0ACONFIG_X86_CMOV=3Dy=0D=0ACON=
FIG_X86_MINIMUM_CPU_FAMILY=3D64=0D=0ACONFIG_X86_DEBUGCTLMSR=3Dy=0D=0ACONFIG=
_IA32_FEAT_CTL=3Dy=0D=0ACONFIG_X86_VMX_FEATURE_NAMES=3Dy=0D=0ACONFIG_PROCES=
SOR_SELECT=3Dy=0D=0ACONFIG_BROADCAST_TLB_FLUSH=3Dy=0D=0ACONFIG_CPU_SUP_INTE=
L=3Dy=0D=0ACONFIG_CPU_SUP_AMD=3Dy=0D=0A#=20CONFIG_CPU_SUP_HYGON=20is=20not=
=20set=0D=0A#=20CONFIG_CPU_SUP_CENTAUR=20is=20not=20set=0D=0A#=20CONFIG_CPU=
_SUP_ZHAOXIN=20is=20not=20set=0D=0ACONFIG_HPET_TIMER=3Dy=0D=0ACONFIG_HPET_E=
MULATE_RTC=3Dy=0D=0ACONFIG_DMI=3Dy=0D=0A#=20CONFIG_GART_IOMMU=20is=20not=20=
set=0D=0A#=20CONFIG_MAXSMP=20is=20not=20set=0D=0ACONFIG_NR_CPUS_RANGE_BEGIN=
=3D2=0D=0ACONFIG_NR_CPUS_RANGE_END=3D512=0D=0ACONFIG_NR_CPUS_DEFAULT=3D64=
=0D=0ACONFIG_NR_CPUS=3D8=0D=0ACONFIG_SCHED_MC_PRIO=3Dy=0D=0ACONFIG_X86_LOCA=
L_APIC=3Dy=0D=0ACONFIG_ACPI_MADT_WAKEUP=3Dy=0D=0ACONFIG_X86_IO_APIC=3Dy=0D=
=0ACONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy=0D=0ACONFIG_X86_MCE=3Dy=0D=
=0A#=20CONFIG_X86_MCELOG_LEGACY=20is=20not=20set=0D=0ACONFIG_X86_MCE_INTEL=
=3Dy=0D=0ACONFIG_X86_MCE_AMD=3Dy=0D=0ACONFIG_X86_MCE_THRESHOLD=3Dy=0D=0A#=
=20CONFIG_X86_MCE_INJECT=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Performance=
=20monitoring=0D=0A#=0D=0ACONFIG_PERF_EVENTS_INTEL_UNCORE=3Dy=0D=0ACONFIG_P=
ERF_EVENTS_INTEL_RAPL=3Dy=0D=0ACONFIG_PERF_EVENTS_INTEL_CSTATE=3Dy=0D=0A#=
=20CONFIG_PERF_EVENTS_AMD_POWER=20is=20not=20set=0D=0ACONFIG_PERF_EVENTS_AM=
D_UNCORE=3Dy=0D=0A#=20CONFIG_PERF_EVENTS_AMD_BRS=20is=20not=20set=0D=0A#=20=
end=20of=20Performance=20monitoring=0D=0A=0D=0ACONFIG_X86_16BIT=3Dy=0D=0ACO=
NFIG_X86_ESPFIX64=3Dy=0D=0ACONFIG_X86_VSYSCALL_EMULATION=3Dy=0D=0ACONFIG_X8=
6_IOPL_IOPERM=3Dy=0D=0ACONFIG_MICROCODE=3Dy=0D=0A#=20CONFIG_MICROCODE_LATE_=
LOADING=20is=20not=20set=0D=0A#=20CONFIG_MICROCODE_DBG=20is=20not=20set=0D=
=0ACONFIG_X86_MSR=3Dy=0D=0ACONFIG_X86_CPUID=3Dy=0D=0ACONFIG_X86_DIRECT_GBPA=
GES=3Dy=0D=0A#=20CONFIG_X86_CPA_STATISTICS=20is=20not=20set=0D=0ACONFIG_NUM=
A=3Dy=0D=0ACONFIG_AMD_NUMA=3Dy=0D=0ACONFIG_X86_64_ACPI_NUMA=3Dy=0D=0ACONFIG=
_NODES_SHIFT=3D6=0D=0ACONFIG_ARCH_SPARSEMEM_ENABLE=3Dy=0D=0ACONFIG_ARCH_SPA=
RSEMEM_DEFAULT=3Dy=0D=0ACONFIG_ARCH_PROC_KCORE_TEXT=3Dy=0D=0ACONFIG_ILLEGAL=
_POINTER_VALUE=3D0xdead000000000000=0D=0A#=20CONFIG_X86_PMEM_LEGACY=20is=20=
not=20set=0D=0A#=20CONFIG_X86_CHECK_BIOS_CORRUPTION=20is=20not=20set=0D=0AC=
ONFIG_MTRR=3Dy=0D=0A#=20CONFIG_MTRR_SANITIZER=20is=20not=20set=0D=0ACONFIG_=
X86_PAT=3Dy=0D=0ACONFIG_X86_UMIP=3Dy=0D=0ACONFIG_CC_HAS_IBT=3Dy=0D=0ACONFIG=
_X86_CET=3Dy=0D=0ACONFIG_X86_KERNEL_IBT=3Dy=0D=0ACONFIG_X86_INTEL_MEMORY_PR=
OTECTION_KEYS=3Dy=0D=0ACONFIG_ARCH_PKEY_BITS=3D4=0D=0A#=20CONFIG_X86_INTEL_=
TSX_MODE_OFF=20is=20not=20set=0D=0ACONFIG_X86_INTEL_TSX_MODE_ON=3Dy=0D=0A#=
=20CONFIG_X86_INTEL_TSX_MODE_AUTO=20is=20not=20set=0D=0A#=20CONFIG_X86_SGX=
=20is=20not=20set=0D=0A#=20CONFIG_X86_USER_SHADOW_STACK=20is=20not=20set=0D=
=0A#=20CONFIG_EFI=20is=20not=20set=0D=0ACONFIG_HZ_100=3Dy=0D=0A#=20CONFIG_H=
Z_250=20is=20not=20set=0D=0A#=20CONFIG_HZ_300=20is=20not=20set=0D=0A#=20CON=
FIG_HZ_1000=20is=20not=20set=0D=0ACONFIG_HZ=3D100=0D=0ACONFIG_SCHED_HRTICK=
=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_KEXEC=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_KEXEC_FI=
LE=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=3Dy=0D=0ACONFIG_ARCH_SUPPO=
RTS_KEXEC_SIG=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=3Dy=0D=0ACONFIG=
_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_KEXEC=
_JUMP=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_KEXEC_HANDOVER=3Dy=0D=0ACONFIG_ARCH_SUP=
PORTS_CRASH_DUMP=3Dy=0D=0ACONFIG_ARCH_DEFAULT_CRASH_DUMP=3Dy=0D=0ACONFIG_AR=
CH_SUPPORTS_CRASH_HOTPLUG=3Dy=0D=0ACONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESE=
RVATION=3Dy=0D=0ACONFIG_PHYSICAL_START=3D0x1000000=0D=0A#=20CONFIG_RELOCATA=
BLE=20is=20not=20set=0D=0ACONFIG_PHYSICAL_ALIGN=3D0x200000=0D=0ACONFIG_HOTP=
LUG_CPU=3Dy=0D=0A#=20CONFIG_COMPAT_VDSO=20is=20not=20set=0D=0ACONFIG_LEGACY=
_VSYSCALL_XONLY=3Dy=0D=0A#=20CONFIG_LEGACY_VSYSCALL_NONE=20is=20not=20set=
=0D=0ACONFIG_CMDLINE_BOOL=3Dy=0D=0ACONFIG_CMDLINE=3D"earlyprintk=3Dserial=
=20net=2Eifnames=3D0=20sysctl=2Ekernel=2Ehung_task_all_cpu_backtrace=3D1=20=
ima_policy=3Dtcb=20nf-conntrack-ftp=2Eports=3D20000=20nf-conntrack-tftp=2Ep=
orts=3D20000=20nf-conntrack-sip=2Eports=3D20000=20nf-conntrack-irc=2Eports=
=3D20000=20nf-conntrack-sane=2Eports=3D20000=20binder=2Edebug_mask=3D0=20rc=
update=2Ercu_expedited=3D1=20rcupdate=2Ercu_cpu_stall_cputime=3D1=20no_hash=
_pointers=20page_owner=3Don=20sysctl=2Evm=2Enr_hugepages=3D4=20sysctl=2Evm=
=2Enr_overcommit_hugepages=3D4=20secretmem=2Eenable=3D1=20sysctl=2Emax_rcu_=
stall_to_panic=3D1=20msr=2Eallow_writes=3Doff=20coredump_filter=3D0xffff=20=
root=3D/dev/sda=20console=3DttyS0=20vsyscall=3Dnative=20numa=3Dfake=3D2=20k=
vm-intel=2Enested=3D1=20spec_store_bypass_disable=3Dprctl=20nopcid=20vivid=
=2En_devs=3D64=20vivid=2Emultiplanar=3D1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,=
1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2=
,1,2,1,2,1,2,1,2=20netrom=2Enr_ndevs=3D32=20rose=2Erose_ndevs=3D32=20smp=2E=
csd_lock_timeout=3D100000=20watchdog_thresh=3D55=20workqueue=2Ewatchdog_thr=
esh=3D140=20sysctl=2Enet=2Ecore=2Enetdev_unregister_timeout_secs=3D140=20du=
mmy_hcd=2Enum=3D32=20max_loop=3D32=20nbds_max=3D32=20panic_on_warn=3D1"=0D=
=0A#=20CONFIG_CMDLINE_OVERRIDE=20is=20not=20set=0D=0ACONFIG_MODIFY_LDT_SYSC=
ALL=3Dy=0D=0A#=20CONFIG_STRICT_SIGALTSTACK_SIZE=20is=20not=20set=0D=0ACONFI=
G_HAVE_LIVEPATCH=3Dy=0D=0ACONFIG_X86_BUS_LOCK_DETECT=3Dy=0D=0A#=20end=20of=
=20Processor=20type=20and=20features=0D=0A=0D=0ACONFIG_CC_HAS_NAMED_AS=3Dy=
=0D=0ACONFIG_CC_HAS_SLS=3Dy=0D=0ACONFIG_CC_HAS_RETURN_THUNK=3Dy=0D=0ACONFIG=
_CC_HAS_ENTRY_PADDING=3Dy=0D=0ACONFIG_FUNCTION_PADDING_CFI=3D11=0D=0ACONFIG=
_FUNCTION_PADDING_BYTES=3D16=0D=0ACONFIG_CALL_PADDING=3Dy=0D=0ACONFIG_HAVE_=
CALL_THUNKS=3Dy=0D=0ACONFIG_CALL_THUNKS=3Dy=0D=0ACONFIG_PREFIX_SYMBOLS=3Dy=
=0D=0ACONFIG_CPU_MITIGATIONS=3Dy=0D=0ACONFIG_MITIGATION_PAGE_TABLE_ISOLATIO=
N=3Dy=0D=0ACONFIG_MITIGATION_RETPOLINE=3Dy=0D=0ACONFIG_MITIGATION_RETHUNK=
=3Dy=0D=0ACONFIG_MITIGATION_UNRET_ENTRY=3Dy=0D=0ACONFIG_MITIGATION_CALL_DEP=
TH_TRACKING=3Dy=0D=0A#=20CONFIG_CALL_THUNKS_DEBUG=20is=20not=20set=0D=0ACON=
FIG_MITIGATION_IBPB_ENTRY=3Dy=0D=0ACONFIG_MITIGATION_IBRS_ENTRY=3Dy=0D=0ACO=
NFIG_MITIGATION_SRSO=3Dy=0D=0A#=20CONFIG_MITIGATION_SLS=20is=20not=20set=0D=
=0ACONFIG_MITIGATION_GDS=3Dy=0D=0ACONFIG_MITIGATION_RFDS=3Dy=0D=0ACONFIG_MI=
TIGATION_SPECTRE_BHI=3Dy=0D=0ACONFIG_MITIGATION_MDS=3Dy=0D=0ACONFIG_MITIGAT=
ION_TAA=3Dy=0D=0ACONFIG_MITIGATION_MMIO_STALE_DATA=3Dy=0D=0ACONFIG_MITIGATI=
ON_L1TF=3Dy=0D=0ACONFIG_MITIGATION_RETBLEED=3Dy=0D=0ACONFIG_MITIGATION_SPEC=
TRE_V1=3Dy=0D=0ACONFIG_MITIGATION_SPECTRE_V2=3Dy=0D=0ACONFIG_MITIGATION_SRB=
DS=3Dy=0D=0ACONFIG_MITIGATION_SSB=3Dy=0D=0ACONFIG_MITIGATION_ITS=3Dy=0D=0AC=
ONFIG_MITIGATION_TSA=3Dy=0D=0ACONFIG_ARCH_HAS_ADD_PAGES=3Dy=0D=0A=0D=0A#=0D=
=0A#=20Power=20management=20and=20ACPI=20options=0D=0A#=0D=0ACONFIG_ARCH_HI=
BERNATION_HEADER=3Dy=0D=0ACONFIG_SUSPEND=3Dy=0D=0ACONFIG_SUSPEND_FREEZER=3D=
y=0D=0A#=20CONFIG_SUSPEND_SKIP_SYNC=20is=20not=20set=0D=0ACONFIG_HIBERNATE_=
CALLBACKS=3Dy=0D=0ACONFIG_HIBERNATION=3Dy=0D=0ACONFIG_HIBERNATION_SNAPSHOT_=
DEV=3Dy=0D=0ACONFIG_HIBERNATION_COMP_LZO=3Dy=0D=0ACONFIG_HIBERNATION_DEF_CO=
MP=3D"lzo"=0D=0ACONFIG_PM_STD_PARTITION=3D""=0D=0ACONFIG_PM_SLEEP=3Dy=0D=0A=
CONFIG_PM_SLEEP_SMP=3Dy=0D=0A#=20CONFIG_PM_AUTOSLEEP=20is=20not=20set=0D=0A=
#=20CONFIG_PM_USERSPACE_AUTOSLEEP=20is=20not=20set=0D=0A#=20CONFIG_PM_WAKEL=
OCKS=20is=20not=20set=0D=0ACONFIG_PM=3Dy=0D=0ACONFIG_PM_DEBUG=3Dy=0D=0A#=20=
CONFIG_PM_ADVANCED_DEBUG=20is=20not=20set=0D=0A#=20CONFIG_PM_TEST_SUSPEND=
=20is=20not=20set=0D=0ACONFIG_PM_SLEEP_DEBUG=3Dy=0D=0ACONFIG_PM_TRACE=3Dy=
=0D=0ACONFIG_PM_TRACE_RTC=3Dy=0D=0ACONFIG_PM_CLK=3Dy=0D=0A#=20CONFIG_WQ_POW=
ER_EFFICIENT_DEFAULT=20is=20not=20set=0D=0A#=20CONFIG_ENERGY_MODEL=20is=20n=
ot=20set=0D=0ACONFIG_ARCH_SUPPORTS_ACPI=3Dy=0D=0ACONFIG_ACPI=3Dy=0D=0ACONFI=
G_ACPI_LEGACY_TABLES_LOOKUP=3Dy=0D=0ACONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy=0D=
=0ACONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy=0D=0ACONFIG_ACPI_THERMAL_LIB=
=3Dy=0D=0A#=20CONFIG_ACPI_DEBUGGER=20is=20not=20set=0D=0ACONFIG_ACPI_SPCR_T=
ABLE=3Dy=0D=0A#=20CONFIG_ACPI_FPDT=20is=20not=20set=0D=0ACONFIG_ACPI_LPIT=
=3Dy=0D=0ACONFIG_ACPI_SLEEP=3Dy=0D=0ACONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy=
=0D=0ACONFIG_ACPI_EC=3Dy=0D=0A#=20CONFIG_ACPI_EC_DEBUGFS=20is=20not=20set=
=0D=0ACONFIG_ACPI_AC=3Dy=0D=0ACONFIG_ACPI_BATTERY=3Dy=0D=0ACONFIG_ACPI_BUTT=
ON=3Dy=0D=0ACONFIG_ACPI_VIDEO=3Dy=0D=0ACONFIG_ACPI_FAN=3Dy=0D=0A#=20CONFIG_=
ACPI_TAD=20is=20not=20set=0D=0ACONFIG_ACPI_DOCK=3Dy=0D=0ACONFIG_ACPI_CPU_FR=
EQ_PSS=3Dy=0D=0ACONFIG_ACPI_PROCESSOR_CSTATE=3Dy=0D=0ACONFIG_ACPI_PROCESSOR=
_IDLE=3Dy=0D=0ACONFIG_ACPI_CPPC_LIB=3Dy=0D=0ACONFIG_ACPI_PROCESSOR=3Dy=0D=
=0ACONFIG_ACPI_HOTPLUG_CPU=3Dy=0D=0A#=20CONFIG_ACPI_PROCESSOR_AGGREGATOR=20=
is=20not=20set=0D=0ACONFIG_ACPI_THERMAL=3Dy=0D=0ACONFIG_ACPI_PLATFORM_PROFI=
LE=3Dy=0D=0ACONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy=0D=0ACONFIG_ACPI_TABLE_U=
PGRADE=3Dy=0D=0ACONFIG_ACPI_DEBUG=3Dy=0D=0A#=20CONFIG_ACPI_PCI_SLOT=20is=20=
not=20set=0D=0ACONFIG_ACPI_CONTAINER=3Dy=0D=0ACONFIG_ACPI_HOTPLUG_IOAPIC=3D=
y=0D=0A#=20CONFIG_ACPI_SBS=20is=20not=20set=0D=0A#=20CONFIG_ACPI_HED=20is=
=20not=20set=0D=0A#=20CONFIG_ACPI_REDUCED_HARDWARE_ONLY=20is=20not=20set=0D=
=0ACONFIG_ACPI_NHLT=3Dy=0D=0A#=20CONFIG_ACPI_NFIT=20is=20not=20set=0D=0ACON=
FIG_ACPI_NUMA=3Dy=0D=0A#=20CONFIG_ACPI_HMAT=20is=20not=20set=0D=0ACONFIG_HA=
VE_ACPI_APEI=3Dy=0D=0ACONFIG_HAVE_ACPI_APEI_NMI=3Dy=0D=0A#=20CONFIG_ACPI_AP=
EI=20is=20not=20set=0D=0A#=20CONFIG_ACPI_DPTF=20is=20not=20set=0D=0A#=20CON=
FIG_ACPI_EXTLOG=20is=20not=20set=0D=0A#=20CONFIG_ACPI_CONFIGFS=20is=20not=
=20set=0D=0A#=20CONFIG_ACPI_PFRUT=20is=20not=20set=0D=0ACONFIG_ACPI_PCC=3Dy=
=0D=0A#=20CONFIG_ACPI_FFH=20is=20not=20set=0D=0ACONFIG_ACPI_MRRM=3Dy=0D=0AC=
ONFIG_PMIC_OPREGION=3Dy=0D=0ACONFIG_BXT_WC_PMIC_OPREGION=3Dy=0D=0A#=20CONFI=
G_CHT_WC_PMIC_OPREGION=20is=20not=20set=0D=0ACONFIG_X86_PM_TIMER=3Dy=0D=0A=
=0D=0A#=0D=0A#=20CPU=20Frequency=20scaling=0D=0A#=0D=0ACONFIG_CPU_FREQ=3Dy=
=0D=0ACONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy=0D=0ACONFIG_CPU_FREQ_GOV_COMMON=3Dy=
=0D=0A#=20CONFIG_CPU_FREQ_STAT=20is=20not=20set=0D=0A#=20CONFIG_CPU_FREQ_DE=
FAULT_GOV_PERFORMANCE=20is=20not=20set=0D=0A#=20CONFIG_CPU_FREQ_DEFAULT_GOV=
_POWERSAVE=20is=20not=20set=0D=0ACONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy=
=0D=0A#=20CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=20is=20not=20set=0D=0ACONFI=
G_CPU_FREQ_GOV_PERFORMANCE=3Dy=0D=0A#=20CONFIG_CPU_FREQ_GOV_POWERSAVE=20is=
=20not=20set=0D=0ACONFIG_CPU_FREQ_GOV_USERSPACE=3Dy=0D=0ACONFIG_CPU_FREQ_GO=
V_ONDEMAND=3Dy=0D=0A#=20CONFIG_CPU_FREQ_GOV_CONSERVATIVE=20is=20not=20set=
=0D=0ACONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy=0D=0A=0D=0A#=0D=0A#=20CPU=20frequen=
cy=20scaling=20drivers=0D=0A#=0D=0A#=20CONFIG_CPUFREQ_DT=20is=20not=20set=
=0D=0A#=20CONFIG_CPUFREQ_DT_PLATDEV=20is=20not=20set=0D=0ACONFIG_X86_INTEL_=
PSTATE=3Dy=0D=0A#=20CONFIG_X86_PCC_CPUFREQ=20is=20not=20set=0D=0ACONFIG_X86=
_AMD_PSTATE=3Dy=0D=0ACONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3=0D=0A#=20CONFIG=
_X86_AMD_PSTATE_UT=20is=20not=20set=0D=0ACONFIG_X86_ACPI_CPUFREQ=3Dy=0D=0AC=
ONFIG_X86_ACPI_CPUFREQ_CPB=3Dy=0D=0A#=20CONFIG_X86_POWERNOW_K8=20is=20not=
=20set=0D=0A#=20CONFIG_X86_AMD_FREQ_SENSITIVITY=20is=20not=20set=0D=0A#=20C=
ONFIG_X86_SPEEDSTEP_CENTRINO=20is=20not=20set=0D=0A#=20CONFIG_X86_P4_CLOCKM=
OD=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20shared=20options=0D=0A#=0D=0ACONF=
IG_CPUFREQ_ARCH_CUR_FREQ=3Dy=0D=0A#=20end=20of=20CPU=20Frequency=20scaling=
=0D=0A=0D=0A#=0D=0A#=20CPU=20Idle=0D=0A#=0D=0ACONFIG_CPU_IDLE=3Dy=0D=0A#=20=
CONFIG_CPU_IDLE_GOV_LADDER=20is=20not=20set=0D=0ACONFIG_CPU_IDLE_GOV_MENU=
=3Dy=0D=0A#=20CONFIG_CPU_IDLE_GOV_TEO=20is=20not=20set=0D=0ACONFIG_CPU_IDLE=
_GOV_HALTPOLL=3Dy=0D=0ACONFIG_HALTPOLL_CPUIDLE=3Dy=0D=0A#=20end=20of=20CPU=
=20Idle=0D=0A=0D=0ACONFIG_INTEL_IDLE=3Dy=0D=0A#=20end=20of=20Power=20manage=
ment=20and=20ACPI=20options=0D=0A=0D=0A#=0D=0A#=20Bus=20options=20(PCI=20et=
c=2E)=0D=0A#=0D=0ACONFIG_PCI_DIRECT=3Dy=0D=0ACONFIG_PCI_MMCONFIG=3Dy=0D=0AC=
ONFIG_MMCONF_FAM10H=3Dy=0D=0A#=20CONFIG_ISA_BUS=20is=20not=20set=0D=0ACONFI=
G_ISA_DMA_API=3Dy=0D=0ACONFIG_AMD_NB=3Dy=0D=0ACONFIG_AMD_NODE=3Dy=0D=0A#=20=
end=20of=20Bus=20options=20(PCI=20etc=2E)=0D=0A=0D=0A#=0D=0A#=20Binary=20Em=
ulations=0D=0A#=0D=0ACONFIG_IA32_EMULATION=3Dy=0D=0A#=20CONFIG_IA32_EMULATI=
ON_DEFAULT_DISABLED=20is=20not=20set=0D=0ACONFIG_X86_X32_ABI=3Dy=0D=0ACONFI=
G_COMPAT_32=3Dy=0D=0ACONFIG_COMPAT=3Dy=0D=0ACONFIG_COMPAT_FOR_U64_ALIGNMENT=
=3Dy=0D=0A#=20end=20of=20Binary=20Emulations=0D=0A=0D=0ACONFIG_VIRTUALIZATI=
ON=3Dy=0D=0A#=20CONFIG_KVM=20is=20not=20set=0D=0ACONFIG_X86_REQUIRED_FEATUR=
E_ALWAYS=3Dy=0D=0ACONFIG_X86_REQUIRED_FEATURE_NOPL=3Dy=0D=0ACONFIG_X86_REQU=
IRED_FEATURE_CX8=3Dy=0D=0ACONFIG_X86_REQUIRED_FEATURE_CMOV=3Dy=0D=0ACONFIG_=
X86_REQUIRED_FEATURE_CPUID=3Dy=0D=0ACONFIG_X86_REQUIRED_FEATURE_FPU=3Dy=0D=
=0ACONFIG_X86_REQUIRED_FEATURE_PAE=3Dy=0D=0ACONFIG_X86_REQUIRED_FEATURE_PSE=
=3Dy=0D=0ACONFIG_X86_REQUIRED_FEATURE_PGE=3Dy=0D=0ACONFIG_X86_REQUIRED_FEAT=
URE_MSR=3Dy=0D=0ACONFIG_X86_REQUIRED_FEATURE_FXSR=3Dy=0D=0ACONFIG_X86_REQUI=
RED_FEATURE_XMM=3Dy=0D=0ACONFIG_X86_REQUIRED_FEATURE_XMM2=3Dy=0D=0ACONFIG_X=
86_REQUIRED_FEATURE_LM=3Dy=0D=0ACONFIG_X86_DISABLED_FEATURE_VME=3Dy=0D=0ACO=
NFIG_X86_DISABLED_FEATURE_K6_MTRR=3Dy=0D=0ACONFIG_X86_DISABLED_FEATURE_CYRI=
X_ARR=3Dy=0D=0ACONFIG_X86_DISABLED_FEATURE_CENTAUR_MCR=3Dy=0D=0ACONFIG_X86_=
DISABLED_FEATURE_LAM=3Dy=0D=0ACONFIG_X86_DISABLED_FEATURE_ENQCMD=3Dy=0D=0AC=
ONFIG_X86_DISABLED_FEATURE_SGX=3Dy=0D=0ACONFIG_X86_DISABLED_FEATURE_XENPV=
=3Dy=0D=0ACONFIG_X86_DISABLED_FEATURE_TDX_GUEST=3Dy=0D=0ACONFIG_X86_DISABLE=
D_FEATURE_USER_SHSTK=3Dy=0D=0ACONFIG_X86_DISABLED_FEATURE_FRED=3Dy=0D=0ACON=
FIG_X86_DISABLED_FEATURE_SEV_SNP=3Dy=0D=0ACONFIG_AS_WRUSS=3Dy=0D=0ACONFIG_A=
RCH_CONFIGURES_CPU_MITIGATIONS=3Dy=0D=0A=0D=0A#=0D=0A#=20General=20architec=
ture-dependent=20options=0D=0A#=0D=0ACONFIG_HOTPLUG_SMT=3Dy=0D=0ACONFIG_ARC=
H_SUPPORTS_SCHED_SMT=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_SCHED_CLUSTER=3Dy=0D=0AC=
ONFIG_ARCH_SUPPORTS_SCHED_MC=3Dy=0D=0ACONFIG_SCHED_SMT=3Dy=0D=0ACONFIG_SCHE=
D_CLUSTER=3Dy=0D=0ACONFIG_SCHED_MC=3Dy=0D=0ACONFIG_HOTPLUG_CORE_SYNC=3Dy=0D=
=0ACONFIG_HOTPLUG_CORE_SYNC_DEAD=3Dy=0D=0ACONFIG_HOTPLUG_CORE_SYNC_FULL=3Dy=
=0D=0ACONFIG_HOTPLUG_SPLIT_STARTUP=3Dy=0D=0ACONFIG_HOTPLUG_PARALLEL=3Dy=0D=
=0ACONFIG_GENERIC_IRQ_ENTRY=3Dy=0D=0ACONFIG_GENERIC_SYSCALL=3Dy=0D=0ACONFIG=
_GENERIC_ENTRY=3Dy=0D=0A#=20CONFIG_KPROBES=20is=20not=20set=0D=0ACONFIG_JUM=
P_LABEL=3Dy=0D=0A#=20CONFIG_STATIC_KEYS_SELFTEST=20is=20not=20set=0D=0A#=20=
CONFIG_STATIC_CALL_SELFTEST=20is=20not=20set=0D=0ACONFIG_UPROBES=3Dy=0D=0AC=
ONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy=0D=0ACONFIG_ARCH_USE_BUILTIN_BSWA=
P=3Dy=0D=0ACONFIG_HAVE_IOREMAP_PROT=3Dy=0D=0ACONFIG_HAVE_KPROBES=3Dy=0D=0AC=
ONFIG_HAVE_KRETPROBES=3Dy=0D=0ACONFIG_HAVE_OPTPROBES=3Dy=0D=0ACONFIG_HAVE_K=
PROBES_ON_FTRACE=3Dy=0D=0ACONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=3Dy=
=0D=0ACONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy=0D=0ACONFIG_HAVE_NMI=3Dy=0D=
=0ACONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy=0D=0ACONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=
=3Dy=0D=0ACONFIG_HAVE_ARCH_TRACEHOOK=3Dy=0D=0ACONFIG_HAVE_DMA_CONTIGUOUS=3D=
y=0D=0ACONFIG_GENERIC_SMP_IDLE_THREAD=3Dy=0D=0ACONFIG_ARCH_HAS_FORTIFY_SOUR=
CE=3Dy=0D=0ACONFIG_ARCH_HAS_SET_MEMORY=3Dy=0D=0ACONFIG_ARCH_HAS_SET_DIRECT_=
MAP=3Dy=0D=0ACONFIG_ARCH_HAS_CPU_FINALIZE_INIT=3Dy=0D=0ACONFIG_ARCH_HAS_CPU=
_PASID=3Dy=0D=0ACONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy=0D=0ACONFIG_AR=
CH_WANTS_DYNAMIC_TASK_STRUCT=3Dy=0D=0ACONFIG_ARCH_WANTS_NO_INSTR=3Dy=0D=0AC=
ONFIG_HAVE_ASM_MODVERSIONS=3Dy=0D=0ACONFIG_HAVE_REGS_AND_STACK_ACCESS_API=
=3Dy=0D=0ACONFIG_HAVE_RSEQ=3Dy=0D=0ACONFIG_HAVE_RUST=3Dy=0D=0ACONFIG_HAVE_F=
UNCTION_ARG_ACCESS_API=3Dy=0D=0ACONFIG_HAVE_HW_BREAKPOINT=3Dy=0D=0ACONFIG_H=
AVE_MIXED_BREAKPOINTS_REGS=3Dy=0D=0ACONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy=0D=
=0ACONFIG_HAVE_PERF_EVENTS_NMI=3Dy=0D=0ACONFIG_HAVE_HARDLOCKUP_DETECTOR_PER=
F=3Dy=0D=0ACONFIG_HAVE_PERF_REGS=3Dy=0D=0ACONFIG_HAVE_PERF_USER_STACK_DUMP=
=3Dy=0D=0ACONFIG_HAVE_ARCH_JUMP_LABEL=3Dy=0D=0ACONFIG_HAVE_ARCH_JUMP_LABEL_=
RELATIVE=3Dy=0D=0ACONFIG_MMU_GATHER_TABLE_FREE=3Dy=0D=0ACONFIG_MMU_GATHER_R=
CU_TABLE_FREE=3Dy=0D=0ACONFIG_MMU_GATHER_MERGE_VMAS=3Dy=0D=0ACONFIG_ARCH_WA=
NT_IRQS_OFF_ACTIVATE_MM=3Dy=0D=0ACONFIG_MMU_LAZY_TLB_REFCOUNT=3Dy=0D=0ACONF=
IG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy=0D=0ACONFIG_ARCH_HAVE_EXTRA_ELF_NOTES=3Dy=
=0D=0ACONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=3Dy=0D=0ACONFIG_HAVE_ALIGNED_ST=
RUCT_PAGE=3Dy=0D=0ACONFIG_HAVE_CMPXCHG_LOCAL=3Dy=0D=0ACONFIG_HAVE_CMPXCHG_D=
OUBLE=3Dy=0D=0ACONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy=0D=0ACONFIG_AR=
CH_WANT_OLD_COMPAT_IPC=3Dy=0D=0ACONFIG_HAVE_ARCH_SECCOMP=3Dy=0D=0ACONFIG_HA=
VE_ARCH_SECCOMP_FILTER=3Dy=0D=0ACONFIG_SECCOMP=3Dy=0D=0ACONFIG_SECCOMP_FILT=
ER=3Dy=0D=0A#=20CONFIG_SECCOMP_CACHE_DEBUG=20is=20not=20set=0D=0ACONFIG_HAV=
E_ARCH_KSTACK_ERASE=3Dy=0D=0ACONFIG_HAVE_STACKPROTECTOR=3Dy=0D=0ACONFIG_STA=
CKPROTECTOR=3Dy=0D=0ACONFIG_STACKPROTECTOR_STRONG=3Dy=0D=0ACONFIG_ARCH_SUPP=
ORTS_LTO_CLANG=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy=0D=0ACONFIG=
_LTO_NONE=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_AUTOFDO_CLANG=3Dy=0D=0ACONFIG_ARCH_=
SUPPORTS_PROPELLER_CLANG=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_CFI=3Dy=0D=0ACONFIG_=
HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy=0D=0ACONFIG_HAVE_CONTEXT_TRACKING_USER=3D=
y=0D=0ACONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=3Dy=0D=0ACONFIG_HAVE_VIRT=
_CPU_ACCOUNTING_GEN=3Dy=0D=0ACONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy=0D=0ACONFI=
G_HAVE_MOVE_PUD=3Dy=0D=0ACONFIG_HAVE_MOVE_PMD=3Dy=0D=0ACONFIG_HAVE_ARCH_TRA=
NSPARENT_HUGEPAGE=3Dy=0D=0ACONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy=0D=
=0ACONFIG_HAVE_ARCH_HUGE_VMAP=3Dy=0D=0ACONFIG_HAVE_ARCH_HUGE_VMALLOC=3Dy=0D=
=0ACONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy=0D=0ACONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy=
=0D=0ACONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy=0D=0ACONFIG_MODULES_USE_ELF_RELA=3D=
y=0D=0ACONFIG_ARCH_HAS_EXECMEM_ROX=3Dy=0D=0ACONFIG_HAVE_IRQ_EXIT_ON_IRQ_STA=
CK=3Dy=0D=0ACONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy=0D=0ACONFIG_SOFTIRQ_ON_OWN=
_STACK=3Dy=0D=0ACONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy=0D=0ACONFIG_HAVE_ARCH_MMA=
P_RND_BITS=3Dy=0D=0ACONFIG_HAVE_EXIT_THREAD=3Dy=0D=0ACONFIG_ARCH_MMAP_RND_B=
ITS=3D28=0D=0ACONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy=0D=0ACONFIG_ARCH_MM=
AP_RND_COMPAT_BITS=3D8=0D=0ACONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy=0D=0ACON=
FIG_HAVE_PAGE_SIZE_4KB=3Dy=0D=0ACONFIG_PAGE_SIZE_4KB=3Dy=0D=0ACONFIG_PAGE_S=
IZE_LESS_THAN_64KB=3Dy=0D=0ACONFIG_PAGE_SIZE_LESS_THAN_256KB=3Dy=0D=0ACONFI=
G_PAGE_SHIFT=3D12=0D=0ACONFIG_HAVE_OBJTOOL=3Dy=0D=0ACONFIG_HAVE_JUMP_LABEL_=
HACK=3Dy=0D=0ACONFIG_HAVE_NOINSTR_HACK=3Dy=0D=0ACONFIG_HAVE_NOINSTR_VALIDAT=
ION=3Dy=0D=0ACONFIG_HAVE_UACCESS_VALIDATION=3Dy=0D=0ACONFIG_HAVE_STACK_VALI=
DATION=3Dy=0D=0ACONFIG_HAVE_RELIABLE_STACKTRACE=3Dy=0D=0ACONFIG_OLD_SIGSUSP=
END3=3Dy=0D=0ACONFIG_COMPAT_OLD_SIGACTION=3Dy=0D=0ACONFIG_COMPAT_32BIT_TIME=
=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_RT=3Dy=0D=0ACONFIG_HAVE_ARCH_VMAP_STACK=3Dy=
=0D=0ACONFIG_VMAP_STACK=3Dy=0D=0ACONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=
=3Dy=0D=0ACONFIG_RANDOMIZE_KSTACK_OFFSET=3Dy=0D=0A#=20CONFIG_RANDOMIZE_KSTA=
CK_OFFSET_DEFAULT=20is=20not=20set=0D=0ACONFIG_ARCH_HAS_STRICT_KERNEL_RWX=
=3Dy=0D=0ACONFIG_STRICT_KERNEL_RWX=3Dy=0D=0ACONFIG_ARCH_HAS_STRICT_MODULE_R=
WX=3Dy=0D=0ACONFIG_STRICT_MODULE_RWX=3Dy=0D=0ACONFIG_HAVE_ARCH_PREL32_RELOC=
ATIONS=3Dy=0D=0A#=20CONFIG_LOCK_EVENT_COUNTS=20is=20not=20set=0D=0ACONFIG_A=
RCH_HAS_MEM_ENCRYPT=3Dy=0D=0ACONFIG_HAVE_STATIC_CALL=3Dy=0D=0ACONFIG_HAVE_S=
TATIC_CALL_INLINE=3Dy=0D=0ACONFIG_HAVE_PREEMPT_DYNAMIC=3Dy=0D=0ACONFIG_HAVE=
_PREEMPT_DYNAMIC_CALL=3Dy=0D=0ACONFIG_ARCH_WANT_LD_ORPHAN_WARN=3Dy=0D=0ACON=
FIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_PAGE_TABLE_=
CHECK=3Dy=0D=0ACONFIG_ARCH_HAS_ELFCORE_COMPAT=3Dy=0D=0ACONFIG_ARCH_HAS_PARA=
NOID_L1D_FLUSH=3Dy=0D=0ACONFIG_DYNAMIC_SIGFRAME=3Dy=0D=0ACONFIG_ARCH_HAS_HW=
_PTE_YOUNG=3Dy=0D=0ACONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=3Dy=0D=0ACONFIG_ARCH_=
HAS_KERNEL_FPU_SUPPORT=3Dy=0D=0ACONFIG_HAVE_GENERIC_TIF_BITS=3Dy=0D=0A=0D=
=0A#=0D=0A#=20GCOV-based=20kernel=20profiling=0D=0A#=0D=0A#=20CONFIG_GCOV_K=
ERNEL=20is=20not=20set=0D=0ACONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy=0D=0A#=20e=
nd=20of=20GCOV-based=20kernel=20profiling=0D=0A=0D=0ACONFIG_HAVE_GCC_PLUGIN=
S=3Dy=0D=0ACONFIG_FUNCTION_ALIGNMENT_4B=3Dy=0D=0ACONFIG_FUNCTION_ALIGNMENT_=
16B=3Dy=0D=0ACONFIG_FUNCTION_ALIGNMENT=3D16=0D=0ACONFIG_ARCH_HAS_CPU_ATTACK=
_VECTORS=3Dy=0D=0A#=20end=20of=20General=20architecture-dependent=20options=
=0D=0A=0D=0ACONFIG_RT_MUTEXES=3Dy=0D=0ACONFIG_MODULES=3Dy=0D=0A#=20CONFIG_M=
ODULE_DEBUG=20is=20not=20set=0D=0A#=20CONFIG_MODULE_FORCE_LOAD=20is=20not=
=20set=0D=0ACONFIG_MODULE_UNLOAD=3Dy=0D=0ACONFIG_MODULE_FORCE_UNLOAD=3Dy=0D=
=0A#=20CONFIG_MODULE_UNLOAD_TAINT_TRACKING=20is=20not=20set=0D=0ACONFIG_MOD=
VERSIONS=3Dy=0D=0A#=20CONFIG_GENKSYMS=20is=20not=20set=0D=0ACONFIG_GENDWARF=
KSYMS=3Dy=0D=0ACONFIG_ASM_MODVERSIONS=3Dy=0D=0A#=20CONFIG_EXTENDED_MODVERSI=
ONS=20is=20not=20set=0D=0A#=20CONFIG_BASIC_MODVERSIONS=20is=20not=20set=0D=
=0A#=20CONFIG_MODULE_SRCVERSION_ALL=20is=20not=20set=0D=0A#=20CONFIG_MODULE=
_SIG=20is=20not=20set=0D=0A#=20CONFIG_MODULE_COMPRESS=20is=20not=20set=0D=
=0A#=20CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=20is=20not=20set=0D=0A=
CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"=0D=0A#=20CONFIG_TRIM_UNUSED_KSYMS=
=20is=20not=20set=0D=0ACONFIG_MODULES_TREE_LOOKUP=3Dy=0D=0ACONFIG_BLOCK=3Dy=
=0D=0ACONFIG_BLOCK_LEGACY_AUTOLOAD=3Dy=0D=0ACONFIG_BLK_RQ_ALLOC_TIME=3Dy=0D=
=0ACONFIG_BLK_DEV_BSG_COMMON=3Dy=0D=0A#=20CONFIG_BLK_DEV_BSGLIB=20is=20not=
=20set=0D=0A#=20CONFIG_BLK_DEV_INTEGRITY=20is=20not=20set=0D=0A#=20CONFIG_B=
LK_DEV_WRITE_MOUNTED=20is=20not=20set=0D=0A#=20CONFIG_BLK_DEV_ZONED=20is=20=
not=20set=0D=0A#=20CONFIG_BLK_DEV_THROTTLING=20is=20not=20set=0D=0A#=20CONF=
IG_BLK_WBT=20is=20not=20set=0D=0ACONFIG_BLK_CGROUP_IOLATENCY=3Dy=0D=0ACONFI=
G_BLK_CGROUP_IOCOST=3Dy=0D=0ACONFIG_BLK_CGROUP_IOPRIO=3Dy=0D=0ACONFIG_BLK_D=
EBUG_FS=3Dy=0D=0A#=20CONFIG_BLK_SED_OPAL=20is=20not=20set=0D=0A#=20CONFIG_B=
LK_INLINE_ENCRYPTION=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Partition=20Typ=
es=0D=0A#=0D=0A#=20CONFIG_PARTITION_ADVANCED=20is=20not=20set=0D=0ACONFIG_M=
SDOS_PARTITION=3Dy=0D=0ACONFIG_EFI_PARTITION=3Dy=0D=0A#=20end=20of=20Partit=
ion=20Types=0D=0A=0D=0ACONFIG_BLK_PM=3Dy=0D=0ACONFIG_BLOCK_HOLDER_DEPRECATE=
D=3Dy=0D=0ACONFIG_BLK_MQ_STACKING=3Dy=0D=0A=0D=0A#=0D=0A#=20IO=20Schedulers=
=0D=0A#=0D=0ACONFIG_MQ_IOSCHED_DEADLINE=3Dy=0D=0ACONFIG_MQ_IOSCHED_KYBER=3D=
y=0D=0A#=20CONFIG_IOSCHED_BFQ=20is=20not=20set=0D=0A#=20end=20of=20IO=20Sch=
edulers=0D=0A=0D=0ACONFIG_PADATA=3Dy=0D=0ACONFIG_ASN1=3Dy=0D=0ACONFIG_UNINL=
INE_SPIN_UNLOCK=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy=0D=0ACONFIG_MU=
TEX_SPIN_ON_OWNER=3Dy=0D=0ACONFIG_RWSEM_SPIN_ON_OWNER=3Dy=0D=0ACONFIG_LOCK_=
SPIN_ON_OWNER=3Dy=0D=0ACONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy=0D=0ACONFIG_QUE=
UED_SPINLOCKS=3Dy=0D=0ACONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy=0D=0ACONFIG_QUEUE=
D_RWLOCKS=3Dy=0D=0ACONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy=0D=0AC=
ONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy=0D=0ACONFIG_ARCH_HAS_SYSCALL_W=
RAPPER=3Dy=0D=0ACONFIG_FREEZER=3Dy=0D=0A=0D=0A#=0D=0A#=20Executable=20file=
=20formats=0D=0A#=0D=0ACONFIG_BINFMT_ELF=3Dy=0D=0ACONFIG_COMPAT_BINFMT_ELF=
=3Dy=0D=0ACONFIG_ELFCORE=3Dy=0D=0ACONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy=
=0D=0ACONFIG_BINFMT_SCRIPT=3Dy=0D=0ACONFIG_BINFMT_MISC=3Dy=0D=0ACONFIG_CORE=
DUMP=3Dy=0D=0A#=20end=20of=20Executable=20file=20formats=0D=0A=0D=0A#=0D=0A=
#=20Memory=20Management=20options=0D=0A#=0D=0ACONFIG_SWAP=3Dy=0D=0A#=20CONF=
IG_ZSWAP=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Slab=20allocator=20options=
=0D=0A#=0D=0ACONFIG_SLUB=3Dy=0D=0ACONFIG_KVFREE_RCU_BATCHED=3Dy=0D=0A#=20CO=
NFIG_SLUB_TINY=20is=20not=20set=0D=0ACONFIG_SLAB_MERGE_DEFAULT=3Dy=0D=0A#=
=20CONFIG_SLAB_FREELIST_RANDOM=20is=20not=20set=0D=0A#=20CONFIG_SLAB_FREELI=
ST_HARDENED=20is=20not=20set=0D=0A#=20CONFIG_SLAB_BUCKETS=20is=20not=20set=
=0D=0A#=20CONFIG_SLUB_STATS=20is=20not=20set=0D=0ACONFIG_SLUB_CPU_PARTIAL=
=3Dy=0D=0A#=20CONFIG_RANDOM_KMALLOC_CACHES=20is=20not=20set=0D=0A#=20end=20=
of=20Slab=20allocator=20options=0D=0A=0D=0A#=20CONFIG_SHUFFLE_PAGE_ALLOCATO=
R=20is=20not=20set=0D=0A#=20CONFIG_COMPAT_BRK=20is=20not=20set=0D=0ACONFIG_=
SPARSEMEM=3Dy=0D=0ACONFIG_SPARSEMEM_EXTREME=3Dy=0D=0ACONFIG_SPARSEMEM_VMEMM=
AP_ENABLE=3Dy=0D=0ACONFIG_SPARSEMEM_VMEMMAP=3Dy=0D=0ACONFIG_SPARSEMEM_VMEMM=
AP_PREINIT=3Dy=0D=0ACONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=3Dy=0D=0ACONFIG_A=
RCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=3Dy=0D=0ACONFIG_ARCH_WANT_HUGETLB_VMEMMAP=
_PREINIT=3Dy=0D=0ACONFIG_HAVE_GUP_FAST=3Dy=0D=0ACONFIG_EXCLUSIVE_SYSTEM_RAM=
=3Dy=0D=0ACONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy=0D=0A#=20CONFIG_MEMORY_HOTP=
LUG=20is=20not=20set=0D=0ACONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=3Dy=0D=0A=
CONFIG_SPLIT_PTE_PTLOCKS=3Dy=0D=0ACONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy=
=0D=0ACONFIG_SPLIT_PMD_PTLOCKS=3Dy=0D=0ACONFIG_COMPACTION=3Dy=0D=0ACONFIG_C=
OMPACT_UNEVICTABLE_DEFAULT=3D1=0D=0A#=20CONFIG_PAGE_REPORTING=20is=20not=20=
set=0D=0ACONFIG_MIGRATION=3Dy=0D=0ACONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3D=
y=0D=0ACONFIG_PCP_BATCH_SCALE_MAX=3D5=0D=0ACONFIG_PHYS_ADDR_T_64BIT=3Dy=0D=
=0ACONFIG_MMU_NOTIFIER=3Dy=0D=0A#=20CONFIG_KSM=20is=20not=20set=0D=0ACONFIG=
_DEFAULT_MMAP_MIN_ADDR=3D4096=0D=0ACONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy=
=0D=0A#=20CONFIG_MEMORY_FAILURE=20is=20not=20set=0D=0ACONFIG_ARCH_WANT_GENE=
RAL_HUGETLB=3Dy=0D=0ACONFIG_ARCH_WANTS_THP_SWAP=3Dy=0D=0A#=20CONFIG_TRANSPA=
RENT_HUGEPAGE=20is=20not=20set=0D=0ACONFIG_PAGE_MAPCOUNT=3Dy=0D=0ACONFIG_PG=
TABLE_HAS_HUGE_LEAVES=3Dy=0D=0ACONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy=0D=
=0ACONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy=0D=0ACONFIG_USE_PERCPU_NUMA_NOD=
E_ID=3Dy=0D=0ACONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy=0D=0A#=20CONFIG_CMA=20is=
=20not=20set=0D=0ACONFIG_PAGE_BLOCK_MAX_ORDER=3D10=0D=0ACONFIG_GENERIC_EARL=
Y_IOREMAP=3Dy=0D=0A#=20CONFIG_DEFERRED_STRUCT_PAGE_INIT=20is=20not=20set=0D=
=0A#=20CONFIG_IDLE_PAGE_TRACKING=20is=20not=20set=0D=0ACONFIG_ARCH_HAS_CACH=
E_LINE_SIZE=3Dy=0D=0ACONFIG_ARCH_HAS_CURRENT_STACK_POINTER=3Dy=0D=0ACONFIG_=
ARCH_HAS_ZONE_DMA_SET=3Dy=0D=0ACONFIG_ZONE_DMA=3Dy=0D=0ACONFIG_ZONE_DMA32=
=3Dy=0D=0ACONFIG_VMAP_PFN=3Dy=0D=0ACONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy=0D=
=0ACONFIG_ARCH_HAS_PKEYS=3Dy=0D=0ACONFIG_ARCH_USES_PG_ARCH_2=3Dy=0D=0ACONFI=
G_VM_EVENT_COUNTERS=3Dy=0D=0A#=20CONFIG_PERCPU_STATS=20is=20not=20set=0D=0A=
#=20CONFIG_GUP_TEST=20is=20not=20set=0D=0A#=20CONFIG_DMAPOOL_TEST=20is=20no=
t=20set=0D=0ACONFIG_ARCH_HAS_PTE_SPECIAL=3Dy=0D=0ACONFIG_KMAP_LOCAL=3Dy=0D=
=0ACONFIG_MEMFD_CREATE=3Dy=0D=0ACONFIG_SECRETMEM=3Dy=0D=0A#=20CONFIG_ANON_V=
MA_NAME=20is=20not=20set=0D=0A#=20CONFIG_USERFAULTFD=20is=20not=20set=0D=0A=
CONFIG_LRU_GEN=3Dy=0D=0ACONFIG_LRU_GEN_ENABLED=3Dy=0D=0A#=20CONFIG_LRU_GEN_=
STATS=20is=20not=20set=0D=0ACONFIG_LRU_GEN_WALKS_MMU=3Dy=0D=0ACONFIG_ARCH_S=
UPPORTS_PER_VMA_LOCK=3Dy=0D=0ACONFIG_PER_VMA_LOCK=3Dy=0D=0ACONFIG_LOCK_MM_A=
ND_FIND_VMA=3Dy=0D=0ACONFIG_IOMMU_MM_DATA=3Dy=0D=0ACONFIG_EXECMEM=3Dy=0D=0A=
CONFIG_NUMA_MEMBLKS=3Dy=0D=0A#=20CONFIG_NUMA_EMU=20is=20not=20set=0D=0ACONF=
IG_ARCH_SUPPORTS_PT_RECLAIM=3Dy=0D=0ACONFIG_PT_RECLAIM=3Dy=0D=0A=0D=0A#=0D=
=0A#=20Data=20Access=20Monitoring=0D=0A#=0D=0A#=20CONFIG_DAMON=20is=20not=
=20set=0D=0A#=20end=20of=20Data=20Access=20Monitoring=0D=0A#=20end=20of=20M=
emory=20Management=20options=0D=0A=0D=0ACONFIG_NET=3Dy=0D=0ACONFIG_NET_INGR=
ESS=3Dy=0D=0ACONFIG_NET_EGRESS=3Dy=0D=0ACONFIG_NET_XGRESS=3Dy=0D=0ACONFIG_S=
KB_EXTENSIONS=3Dy=0D=0ACONFIG_NET_DEVMEM=3Dy=0D=0A=0D=0A#=0D=0A#=20Networki=
ng=20options=0D=0A#=0D=0ACONFIG_PACKET=3Dy=0D=0A#=20CONFIG_PACKET_DIAG=20is=
=20not=20set=0D=0A#=20CONFIG_INET_PSP=20is=20not=20set=0D=0ACONFIG_UNIX=3Dy=
=0D=0ACONFIG_AF_UNIX_OOB=3Dy=0D=0A#=20CONFIG_UNIX_DIAG=20is=20not=20set=0D=
=0A#=20CONFIG_TLS=20is=20not=20set=0D=0ACONFIG_XFRM=3Dy=0D=0ACONFIG_XFRM_AL=
GO=3Dy=0D=0ACONFIG_XFRM_USER=3Dy=0D=0A#=20CONFIG_XFRM_USER_COMPAT=20is=20no=
t=20set=0D=0A#=20CONFIG_XFRM_INTERFACE=20is=20not=20set=0D=0A#=20CONFIG_XFR=
M_SUB_POLICY=20is=20not=20set=0D=0A#=20CONFIG_XFRM_MIGRATE=20is=20not=20set=
=0D=0A#=20CONFIG_XFRM_STATISTICS=20is=20not=20set=0D=0ACONFIG_XFRM_AH=3Dy=
=0D=0ACONFIG_XFRM_ESP=3Dy=0D=0A#=20CONFIG_NET_KEY=20is=20not=20set=0D=0A#=
=20CONFIG_XFRM_IPTFS=20is=20not=20set=0D=0A#=20CONFIG_DIBS=20is=20not=20set=
=0D=0A#=20CONFIG_XDP_SOCKETS=20is=20not=20set=0D=0ACONFIG_NET_HANDSHAKE=3Dy=
=0D=0ACONFIG_INET=3Dy=0D=0ACONFIG_IP_MULTICAST=3Dy=0D=0ACONFIG_IP_ADVANCED_=
ROUTER=3Dy=0D=0A#=20CONFIG_IP_FIB_TRIE_STATS=20is=20not=20set=0D=0ACONFIG_I=
P_MULTIPLE_TABLES=3Dy=0D=0ACONFIG_IP_ROUTE_MULTIPATH=3Dy=0D=0ACONFIG_IP_ROU=
TE_VERBOSE=3Dy=0D=0ACONFIG_IP_PNP=3Dy=0D=0ACONFIG_IP_PNP_DHCP=3Dy=0D=0ACONF=
IG_IP_PNP_BOOTP=3Dy=0D=0ACONFIG_IP_PNP_RARP=3Dy=0D=0A#=20CONFIG_NET_IPIP=20=
is=20not=20set=0D=0A#=20CONFIG_NET_IPGRE_DEMUX=20is=20not=20set=0D=0ACONFIG=
_NET_IP_TUNNEL=3Dy=0D=0ACONFIG_IP_MROUTE_COMMON=3Dy=0D=0ACONFIG_IP_MROUTE=
=3Dy=0D=0A#=20CONFIG_IP_MROUTE_MULTIPLE_TABLES=20is=20not=20set=0D=0ACONFIG=
_IP_PIMSM_V1=3Dy=0D=0ACONFIG_IP_PIMSM_V2=3Dy=0D=0ACONFIG_SYN_COOKIES=3Dy=0D=
=0A#=20CONFIG_NET_IPVTI=20is=20not=20set=0D=0A#=20CONFIG_NET_FOU=20is=20not=
=20set=0D=0A#=20CONFIG_NET_FOU_IP_TUNNELS=20is=20not=20set=0D=0A#=20CONFIG_=
INET_AH=20is=20not=20set=0D=0A#=20CONFIG_INET_ESP=20is=20not=20set=0D=0A#=
=20CONFIG_INET_IPCOMP=20is=20not=20set=0D=0ACONFIG_INET_TABLE_PERTURB_ORDER=
=3D16=0D=0ACONFIG_INET_TUNNEL=3Dy=0D=0A#=20CONFIG_INET_DIAG=20is=20not=20se=
t=0D=0ACONFIG_TCP_CONG_ADVANCED=3Dy=0D=0A#=20CONFIG_TCP_CONG_BIC=20is=20not=
=20set=0D=0ACONFIG_TCP_CONG_CUBIC=3Dy=0D=0A#=20CONFIG_TCP_CONG_WESTWOOD=20i=
s=20not=20set=0D=0A#=20CONFIG_TCP_CONG_HTCP=20is=20not=20set=0D=0A#=20CONFI=
G_TCP_CONG_HSTCP=20is=20not=20set=0D=0A#=20CONFIG_TCP_CONG_HYBLA=20is=20not=
=20set=0D=0A#=20CONFIG_TCP_CONG_VEGAS=20is=20not=20set=0D=0A#=20CONFIG_TCP_=
CONG_NV=20is=20not=20set=0D=0A#=20CONFIG_TCP_CONG_SCALABLE=20is=20not=20set=
=0D=0A#=20CONFIG_TCP_CONG_LP=20is=20not=20set=0D=0A#=20CONFIG_TCP_CONG_VENO=
=20is=20not=20set=0D=0A#=20CONFIG_TCP_CONG_YEAH=20is=20not=20set=0D=0A#=20C=
ONFIG_TCP_CONG_ILLINOIS=20is=20not=20set=0D=0A#=20CONFIG_TCP_CONG_DCTCP=20i=
s=20not=20set=0D=0A#=20CONFIG_TCP_CONG_CDG=20is=20not=20set=0D=0A#=20CONFIG=
_TCP_CONG_BBR=20is=20not=20set=0D=0ACONFIG_DEFAULT_CUBIC=3Dy=0D=0A#=20CONFI=
G_DEFAULT_RENO=20is=20not=20set=0D=0ACONFIG_DEFAULT_TCP_CONG=3D"cubic"=0D=
=0ACONFIG_TCP_SIGPOOL=3Dy=0D=0A#=20CONFIG_TCP_AO=20is=20not=20set=0D=0ACONF=
IG_TCP_MD5SIG=3Dy=0D=0ACONFIG_IPV6=3Dy=0D=0A#=20CONFIG_IPV6_ROUTER_PREF=20i=
s=20not=20set=0D=0A#=20CONFIG_IPV6_OPTIMISTIC_DAD=20is=20not=20set=0D=0ACON=
FIG_INET6_AH=3Dy=0D=0ACONFIG_INET6_ESP=3Dy=0D=0A#=20CONFIG_INET6_ESP_OFFLOA=
D=20is=20not=20set=0D=0A#=20CONFIG_INET6_ESPINTCP=20is=20not=20set=0D=0A#=
=20CONFIG_INET6_IPCOMP=20is=20not=20set=0D=0A#=20CONFIG_IPV6_MIP6=20is=20no=
t=20set=0D=0A#=20CONFIG_IPV6_ILA=20is=20not=20set=0D=0A#=20CONFIG_IPV6_VTI=
=20is=20not=20set=0D=0ACONFIG_IPV6_SIT=3Dy=0D=0A#=20CONFIG_IPV6_SIT_6RD=20i=
s=20not=20set=0D=0ACONFIG_IPV6_NDISC_NODETYPE=3Dy=0D=0A#=20CONFIG_IPV6_TUNN=
EL=20is=20not=20set=0D=0A#=20CONFIG_IPV6_MULTIPLE_TABLES=20is=20not=20set=
=0D=0A#=20CONFIG_IPV6_MROUTE=20is=20not=20set=0D=0A#=20CONFIG_IPV6_SEG6_LWT=
UNNEL=20is=20not=20set=0D=0A#=20CONFIG_IPV6_SEG6_HMAC=20is=20not=20set=0D=
=0A#=20CONFIG_IPV6_RPL_LWTUNNEL=20is=20not=20set=0D=0A#=20CONFIG_IPV6_IOAM6=
_LWTUNNEL=20is=20not=20set=0D=0ACONFIG_NETLABEL=3Dy=0D=0A#=20CONFIG_MPTCP=
=20is=20not=20set=0D=0ACONFIG_NETWORK_SECMARK=3Dy=0D=0ACONFIG_NET_PTP_CLASS=
IFY=3Dy=0D=0A#=20CONFIG_NETWORK_PHY_TIMESTAMPING=20is=20not=20set=0D=0ACONF=
IG_NETFILTER=3Dy=0D=0A#=20CONFIG_NETFILTER_ADVANCED=20is=20not=20set=0D=0A=
=0D=0A#=0D=0A#=20Core=20Netfilter=20Configuration=0D=0A#=0D=0ACONFIG_NETFIL=
TER_INGRESS=3Dy=0D=0ACONFIG_NETFILTER_EGRESS=3Dy=0D=0ACONFIG_NETFILTER_SKIP=
_EGRESS=3Dy=0D=0ACONFIG_NETFILTER_NETLINK=3Dy=0D=0ACONFIG_NETFILTER_BPF_LIN=
K=3Dy=0D=0ACONFIG_NETFILTER_NETLINK_LOG=3Dy=0D=0ACONFIG_NF_CONNTRACK=3Dy=0D=
=0ACONFIG_NF_LOG_SYSLOG=3Dy=0D=0ACONFIG_NF_CONNTRACK_SECMARK=3Dy=0D=0A#=20C=
ONFIG_NF_CONNTRACK_PROCFS=20is=20not=20set=0D=0A#=20CONFIG_NF_CONNTRACK_LAB=
ELS=20is=20not=20set=0D=0ACONFIG_NF_CONNTRACK_FTP=3Dy=0D=0ACONFIG_NF_CONNTR=
ACK_IRC=3Dy=0D=0A#=20CONFIG_NF_CONNTRACK_NETBIOS_NS=20is=20not=20set=0D=0AC=
ONFIG_NF_CONNTRACK_SIP=3Dy=0D=0ACONFIG_NF_CT_NETLINK=3Dy=0D=0A#=20CONFIG_NE=
TFILTER_NETLINK_GLUE_CT=20is=20not=20set=0D=0ACONFIG_NF_NAT=3Dy=0D=0ACONFIG=
_NF_NAT_FTP=3Dy=0D=0ACONFIG_NF_NAT_IRC=3Dy=0D=0ACONFIG_NF_NAT_SIP=3Dy=0D=0A=
CONFIG_NF_NAT_MASQUERADE=3Dy=0D=0A#=20CONFIG_NF_TABLES=20is=20not=20set=0D=
=0ACONFIG_NETFILTER_XTABLES=3Dy=0D=0A#=20CONFIG_NETFILTER_XTABLES_COMPAT=20=
is=20not=20set=0D=0A#=20CONFIG_NETFILTER_XTABLES_LEGACY=20is=20not=20set=0D=
=0A=0D=0A#=0D=0A#=20Xtables=20combined=20modules=0D=0A#=0D=0ACONFIG_NETFILT=
ER_XT_MARK=3Dy=0D=0A=0D=0A#=0D=0A#=20Xtables=20targets=0D=0A#=0D=0ACONFIG_N=
ETFILTER_XT_TARGET_CONNSECMARK=3Dy=0D=0ACONFIG_NETFILTER_XT_TARGET_LOG=3Dy=
=0D=0A#=20CONFIG_NETFILTER_XT_NAT=20is=20not=20set=0D=0A#=20CONFIG_NETFILTE=
R_XT_TARGET_NETMAP=20is=20not=20set=0D=0ACONFIG_NETFILTER_XT_TARGET_NFLOG=
=3Dy=0D=0A#=20CONFIG_NETFILTER_XT_TARGET_REDIRECT=20is=20not=20set=0D=0ACON=
FIG_NETFILTER_XT_TARGET_MASQUERADE=3Dy=0D=0ACONFIG_NETFILTER_XT_TARGET_SECM=
ARK=3Dy=0D=0ACONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dy=0D=0A=0D=0A#=0D=0A#=20Xt=
ables=20matches=0D=0A#=0D=0ACONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dy=0D=0ACON=
FIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy=0D=0ACONFIG_NETFILTER_XT_MATCH_POLICY=
=3Dy=0D=0ACONFIG_NETFILTER_XT_MATCH_STATE=3Dy=0D=0A#=20end=20of=20Core=20Ne=
tfilter=20Configuration=0D=0A=0D=0A#=20CONFIG_IP_SET=20is=20not=20set=0D=0A=
#=20CONFIG_IP_VS=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20IP:=20Netfilter=20C=
onfiguration=0D=0A#=0D=0ACONFIG_NF_DEFRAG_IPV4=3Dy=0D=0A#=20CONFIG_NF_SOCKE=
T_IPV4=20is=20not=20set=0D=0A#=20CONFIG_NF_TPROXY_IPV4=20is=20not=20set=0D=
=0A#=20CONFIG_NF_DUP_IPV4=20is=20not=20set=0D=0ACONFIG_NF_LOG_ARP=3Dy=0D=0A=
CONFIG_NF_LOG_IPV4=3Dy=0D=0ACONFIG_NF_REJECT_IPV4=3Dy=0D=0ACONFIG_IP_NF_IPT=
ABLES=3Dy=0D=0A#=20end=20of=20IP:=20Netfilter=20Configuration=0D=0A=0D=0A#=
=0D=0A#=20IPv6:=20Netfilter=20Configuration=0D=0A#=0D=0A#=20CONFIG_NF_SOCKE=
T_IPV6=20is=20not=20set=0D=0A#=20CONFIG_NF_TPROXY_IPV6=20is=20not=20set=0D=
=0A#=20CONFIG_NF_DUP_IPV6=20is=20not=20set=0D=0ACONFIG_NF_REJECT_IPV6=3Dy=
=0D=0ACONFIG_NF_LOG_IPV6=3Dy=0D=0ACONFIG_IP6_NF_IPTABLES=3Dy=0D=0ACONFIG_IP=
6_NF_MATCH_IPV6HEADER=3Dy=0D=0A#=20end=20of=20IPv6:=20Netfilter=20Configura=
tion=0D=0A=0D=0ACONFIG_NF_DEFRAG_IPV6=3Dy=0D=0A#=20CONFIG_NF_CONNTRACK_BRID=
GE=20is=20not=20set=0D=0A#=20CONFIG_IP_SCTP=20is=20not=20set=0D=0A#=20CONFI=
G_RDS=20is=20not=20set=0D=0A#=20CONFIG_TIPC=20is=20not=20set=0D=0ACONFIG_AT=
M=3Dy=0D=0A#=20CONFIG_ATM_CLIP=20is=20not=20set=0D=0A#=20CONFIG_ATM_LANE=20=
is=20not=20set=0D=0A#=20CONFIG_ATM_BR2684=20is=20not=20set=0D=0A#=20CONFIG_=
L2TP=20is=20not=20set=0D=0A#=20CONFIG_BRIDGE=20is=20not=20set=0D=0A#=20CONF=
IG_NET_DSA=20is=20not=20set=0D=0A#=20CONFIG_VLAN_8021Q=20is=20not=20set=0D=
=0A#=20CONFIG_LLC2=20is=20not=20set=0D=0A#=20CONFIG_ATALK=20is=20not=20set=
=0D=0A#=20CONFIG_X25=20is=20not=20set=0D=0A#=20CONFIG_LAPB=20is=20not=20set=
=0D=0ACONFIG_PHONET=3Dy=0D=0A#=20CONFIG_6LOWPAN=20is=20not=20set=0D=0ACONFI=
G_IEEE802154=3Dy=0D=0A#=20CONFIG_IEEE802154_NL802154_EXPERIMENTAL=20is=20no=
t=20set=0D=0A#=20CONFIG_IEEE802154_SOCKET=20is=20not=20set=0D=0ACONFIG_MAC8=
02154=3Dy=0D=0ACONFIG_NET_SCHED=3Dy=0D=0A=0D=0A#=0D=0A#=20Queueing/Scheduli=
ng=0D=0A#=0D=0A#=20CONFIG_NET_SCH_HTB=20is=20not=20set=0D=0A#=20CONFIG_NET_=
SCH_HFSC=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_PRIO=20is=20not=20set=0D=
=0A#=20CONFIG_NET_SCH_MULTIQ=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_RED=
=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_SFB=20is=20not=20set=0D=0A#=20CON=
FIG_NET_SCH_SFQ=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_TEQL=20is=20not=20=
set=0D=0A#=20CONFIG_NET_SCH_TBF=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_CB=
S=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_ETF=20is=20not=20set=0D=0A#=20CO=
NFIG_NET_SCH_TAPRIO=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_GRED=20is=20no=
t=20set=0D=0A#=20CONFIG_NET_SCH_NETEM=20is=20not=20set=0D=0A#=20CONFIG_NET_=
SCH_DRR=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_MQPRIO=20is=20not=20set=0D=
=0A#=20CONFIG_NET_SCH_SKBPRIO=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_CHOK=
E=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_QFQ=20is=20not=20set=0D=0A#=20CO=
NFIG_NET_SCH_CODEL=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_FQ_CODEL=20is=
=20not=20set=0D=0A#=20CONFIG_NET_SCH_CAKE=20is=20not=20set=0D=0A#=20CONFIG_=
NET_SCH_FQ=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_HHF=20is=20not=20set=0D=
=0A#=20CONFIG_NET_SCH_PIE=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_INGRESS=
=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_PLUG=20is=20not=20set=0D=0A#=20CO=
NFIG_NET_SCH_ETS=20is=20not=20set=0D=0A#=20CONFIG_NET_SCH_DUALPI2=20is=20no=
t=20set=0D=0A#=20CONFIG_NET_SCH_DEFAULT=20is=20not=20set=0D=0A=0D=0A#=0D=0A=
#=20Classification=0D=0A#=0D=0ACONFIG_NET_CLS=3Dy=0D=0A#=20CONFIG_NET_CLS_B=
ASIC=20is=20not=20set=0D=0A#=20CONFIG_NET_CLS_ROUTE4=20is=20not=20set=0D=0A=
#=20CONFIG_NET_CLS_FW=20is=20not=20set=0D=0A#=20CONFIG_NET_CLS_U32=20is=20n=
ot=20set=0D=0A#=20CONFIG_NET_CLS_FLOW=20is=20not=20set=0D=0ACONFIG_NET_CLS_=
CGROUP=3Dy=0D=0A#=20CONFIG_NET_CLS_BPF=20is=20not=20set=0D=0A#=20CONFIG_NET=
_CLS_FLOWER=20is=20not=20set=0D=0A#=20CONFIG_NET_CLS_MATCHALL=20is=20not=20=
set=0D=0ACONFIG_NET_EMATCH=3Dy=0D=0ACONFIG_NET_EMATCH_STACK=3D32=0D=0A#=20C=
ONFIG_NET_EMATCH_CMP=20is=20not=20set=0D=0A#=20CONFIG_NET_EMATCH_NBYTE=20is=
=20not=20set=0D=0A#=20CONFIG_NET_EMATCH_U32=20is=20not=20set=0D=0A#=20CONFI=
G_NET_EMATCH_META=20is=20not=20set=0D=0A#=20CONFIG_NET_EMATCH_TEXT=20is=20n=
ot=20set=0D=0A#=20CONFIG_NET_EMATCH_CANID=20is=20not=20set=0D=0A#=20CONFIG_=
NET_EMATCH_IPT=20is=20not=20set=0D=0ACONFIG_NET_CLS_ACT=3Dy=0D=0A#=20CONFIG=
_NET_ACT_POLICE=20is=20not=20set=0D=0A#=20CONFIG_NET_ACT_GACT=20is=20not=20=
set=0D=0A#=20CONFIG_NET_ACT_MIRRED=20is=20not=20set=0D=0A#=20CONFIG_NET_ACT=
_SAMPLE=20is=20not=20set=0D=0A#=20CONFIG_NET_ACT_NAT=20is=20not=20set=0D=0A=
#=20CONFIG_NET_ACT_PEDIT=20is=20not=20set=0D=0A#=20CONFIG_NET_ACT_SIMP=20is=
=20not=20set=0D=0A#=20CONFIG_NET_ACT_SKBEDIT=20is=20not=20set=0D=0A#=20CONF=
IG_NET_ACT_CSUM=20is=20not=20set=0D=0A#=20CONFIG_NET_ACT_MPLS=20is=20not=20=
set=0D=0A#=20CONFIG_NET_ACT_VLAN=20is=20not=20set=0D=0A#=20CONFIG_NET_ACT_B=
PF=20is=20not=20set=0D=0A#=20CONFIG_NET_ACT_SKBMOD=20is=20not=20set=0D=0A#=
=20CONFIG_NET_ACT_IFE=20is=20not=20set=0D=0A#=20CONFIG_NET_ACT_TUNNEL_KEY=
=20is=20not=20set=0D=0A#=20CONFIG_NET_ACT_GATE=20is=20not=20set=0D=0A#=20CO=
NFIG_NET_TC_SKB_EXT=20is=20not=20set=0D=0ACONFIG_NET_SCH_FIFO=3Dy=0D=0A#=20=
CONFIG_DCB=20is=20not=20set=0D=0ACONFIG_DNS_RESOLVER=3Dy=0D=0A#=20CONFIG_BA=
TMAN_ADV=20is=20not=20set=0D=0A#=20CONFIG_OPENVSWITCH=20is=20not=20set=0D=
=0A#=20CONFIG_VSOCKETS=20is=20not=20set=0D=0A#=20CONFIG_NETLINK_DIAG=20is=
=20not=20set=0D=0A#=20CONFIG_MPLS=20is=20not=20set=0D=0A#=20CONFIG_NET_NSH=
=20is=20not=20set=0D=0A#=20CONFIG_HSR=20is=20not=20set=0D=0A#=20CONFIG_NET_=
SWITCHDEV=20is=20not=20set=0D=0A#=20CONFIG_NET_L3_MASTER_DEV=20is=20not=20s=
et=0D=0A#=20CONFIG_QRTR=20is=20not=20set=0D=0A#=20CONFIG_NET_NCSI=20is=20no=
t=20set=0D=0A#=20CONFIG_PCPU_DEV_REFCNT=20is=20not=20set=0D=0ACONFIG_MAX_SK=
B_FRAGS=3D17=0D=0ACONFIG_RPS=3Dy=0D=0ACONFIG_RFS_ACCEL=3Dy=0D=0ACONFIG_SOCK=
_RX_QUEUE_MAPPING=3Dy=0D=0ACONFIG_XPS=3Dy=0D=0ACONFIG_CGROUP_NET_PRIO=3Dy=
=0D=0ACONFIG_CGROUP_NET_CLASSID=3Dy=0D=0ACONFIG_NET_RX_BUSY_POLL=3Dy=0D=0AC=
ONFIG_BQL=3Dy=0D=0ACONFIG_NET_FLOW_LIMIT=3Dy=0D=0A=0D=0A#=0D=0A#=20Network=
=20testing=0D=0A#=0D=0A#=20CONFIG_NET_PKTGEN=20is=20not=20set=0D=0A#=20CONF=
IG_NET_DROP_MONITOR=20is=20not=20set=0D=0A#=20end=20of=20Network=20testing=
=0D=0A#=20end=20of=20Networking=20options=0D=0A=0D=0A#=20CONFIG_HAMRADIO=20=
is=20not=20set=0D=0ACONFIG_CAN=3Dy=0D=0A#=20CONFIG_CAN_RAW=20is=20not=20set=
=0D=0A#=20CONFIG_CAN_BCM=20is=20not=20set=0D=0A#=20CONFIG_CAN_GW=20is=20not=
=20set=0D=0A#=20CONFIG_CAN_J1939=20is=20not=20set=0D=0A#=20CONFIG_CAN_ISOTP=
=20is=20not=20set=0D=0ACONFIG_BT=3Dy=0D=0ACONFIG_BT_BREDR=3Dy=0D=0A#=20CONF=
IG_BT_RFCOMM=20is=20not=20set=0D=0A#=20CONFIG_BT_BNEP=20is=20not=20set=0D=
=0ACONFIG_BT_HIDP=3Dy=0D=0A#=20CONFIG_BT_LE=20is=20not=20set=0D=0A#=20CONFI=
G_BT_LEDS=20is=20not=20set=0D=0A#=20CONFIG_BT_MSFTEXT=20is=20not=20set=0D=
=0A#=20CONFIG_BT_AOSPEXT=20is=20not=20set=0D=0A#=20CONFIG_BT_DEBUGFS=20is=
=20not=20set=0D=0A#=20CONFIG_BT_SELFTEST=20is=20not=20set=0D=0A=0D=0A#=0D=
=0A#=20Bluetooth=20device=20drivers=0D=0A#=0D=0ACONFIG_BT_INTEL=3Dy=0D=0ACO=
NFIG_BT_BCM=3Dy=0D=0ACONFIG_BT_RTL=3Dy=0D=0ACONFIG_BT_MTK=3Dy=0D=0ACONFIG_B=
T_HCIBTUSB=3Dy=0D=0ACONFIG_BT_HCIBTUSB_AUTOSUSPEND=3Dy=0D=0ACONFIG_BT_HCIBT=
USB_POLL_SYNC=3Dy=0D=0ACONFIG_BT_HCIBTUSB_BCM=3Dy=0D=0ACONFIG_BT_HCIBTUSB_M=
TK=3Dy=0D=0ACONFIG_BT_HCIBTUSB_RTL=3Dy=0D=0A#=20CONFIG_BT_HCIBTSDIO=20is=20=
not=20set=0D=0ACONFIG_BT_HCIUART=3Dy=0D=0ACONFIG_BT_HCIUART_SERDEV=3Dy=0D=
=0ACONFIG_BT_HCIUART_H4=3Dy=0D=0A#=20CONFIG_BT_HCIUART_NOKIA=20is=20not=20s=
et=0D=0A#=20CONFIG_BT_HCIUART_BCSP=20is=20not=20set=0D=0A#=20CONFIG_BT_HCIU=
ART_ATH3K=20is=20not=20set=0D=0A#=20CONFIG_BT_HCIUART_LL=20is=20not=20set=
=0D=0A#=20CONFIG_BT_HCIUART_3WIRE=20is=20not=20set=0D=0A#=20CONFIG_BT_HCIUA=
RT_INTEL=20is=20not=20set=0D=0A#=20CONFIG_BT_HCIUART_RTL=20is=20not=20set=
=0D=0A#=20CONFIG_BT_HCIUART_QCA=20is=20not=20set=0D=0A#=20CONFIG_BT_HCIUART=
_AG6XX=20is=20not=20set=0D=0A#=20CONFIG_BT_HCIUART_MRVL=20is=20not=20set=0D=
=0A#=20CONFIG_BT_HCIUART_AML=20is=20not=20set=0D=0ACONFIG_BT_HCIBCM203X=3Dy=
=0D=0A#=20CONFIG_BT_HCIBCM4377=20is=20not=20set=0D=0ACONFIG_BT_HCIBPA10X=3D=
y=0D=0ACONFIG_BT_HCIBFUSB=3Dy=0D=0A#=20CONFIG_BT_HCIDTL1=20is=20not=20set=
=0D=0A#=20CONFIG_BT_HCIBT3C=20is=20not=20set=0D=0A#=20CONFIG_BT_HCIBLUECARD=
=20is=20not=20set=0D=0A#=20CONFIG_BT_HCIVHCI=20is=20not=20set=0D=0ACONFIG_B=
T_MRVL=3Dy=0D=0ACONFIG_BT_MRVL_SDIO=3Dy=0D=0ACONFIG_BT_ATH3K=3Dy=0D=0ACONFI=
G_BT_MTKSDIO=3Dy=0D=0ACONFIG_BT_MTKUART=3Dy=0D=0A#=20CONFIG_BT_VIRTIO=20is=
=20not=20set=0D=0A#=20CONFIG_BT_NXPUART=20is=20not=20set=0D=0A#=20CONFIG_BT=
_INTEL_PCIE=20is=20not=20set=0D=0A#=20end=20of=20Bluetooth=20device=20drive=
rs=0D=0A=0D=0A#=20CONFIG_AF_RXRPC=20is=20not=20set=0D=0A#=20CONFIG_AF_KCM=
=20is=20not=20set=0D=0ACONFIG_MCTP=3Dy=0D=0ACONFIG_FIB_RULES=3Dy=0D=0ACONFI=
G_WIRELESS=3Dy=0D=0ACONFIG_CFG80211=3Dy=0D=0A#=20CONFIG_NL80211_TESTMODE=20=
is=20not=20set=0D=0A#=20CONFIG_CFG80211_DEVELOPER_WARNINGS=20is=20not=20set=
=0D=0A#=20CONFIG_CFG80211_CERTIFICATION_ONUS=20is=20not=20set=0D=0ACONFIG_C=
FG80211_REQUIRE_SIGNED_REGDB=3Dy=0D=0ACONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=
=3Dy=0D=0ACONFIG_CFG80211_DEFAULT_PS=3Dy=0D=0ACONFIG_CFG80211_DEBUGFS=3Dy=
=0D=0ACONFIG_CFG80211_CRDA_SUPPORT=3Dy=0D=0A#=20CONFIG_CFG80211_WEXT=20is=
=20not=20set=0D=0ACONFIG_MAC80211=3Dy=0D=0ACONFIG_MAC80211_HAS_RC=3Dy=0D=0A=
CONFIG_MAC80211_RC_MINSTREL=3Dy=0D=0ACONFIG_MAC80211_RC_DEFAULT_MINSTREL=3D=
y=0D=0ACONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"=0D=0A#=20CONFIG_MAC80211_=
MESH=20is=20not=20set=0D=0ACONFIG_MAC80211_LEDS=3Dy=0D=0ACONFIG_MAC80211_DE=
BUGFS=3Dy=0D=0A#=20CONFIG_MAC80211_MESSAGE_TRACING=20is=20not=20set=0D=0A#=
=20CONFIG_MAC80211_DEBUG_MENU=20is=20not=20set=0D=0ACONFIG_MAC80211_STA_HAS=
H_MAX_SIZE=3D0=0D=0ACONFIG_RFKILL=3Dy=0D=0ACONFIG_RFKILL_LEDS=3Dy=0D=0ACONF=
IG_RFKILL_INPUT=3Dy=0D=0A#=20CONFIG_RFKILL_GPIO=20is=20not=20set=0D=0ACONFI=
G_NET_9P=3Dy=0D=0ACONFIG_NET_9P_FD=3Dy=0D=0ACONFIG_NET_9P_VIRTIO=3Dy=0D=0A#=
=20CONFIG_NET_9P_USBG=20is=20not=20set=0D=0A#=20CONFIG_NET_9P_DEBUG=20is=20=
not=20set=0D=0A#=20CONFIG_CAIF=20is=20not=20set=0D=0A#=20CONFIG_CEPH_LIB=20=
is=20not=20set=0D=0ACONFIG_NFC=3Dy=0D=0ACONFIG_NFC_DIGITAL=3Dy=0D=0ACONFIG_=
NFC_NCI=3Dy=0D=0A#=20CONFIG_NFC_NCI_SPI=20is=20not=20set=0D=0A#=20CONFIG_NF=
C_NCI_UART=20is=20not=20set=0D=0A#=20CONFIG_NFC_HCI=20is=20not=20set=0D=0A=
=0D=0A#=0D=0A#=20Near=20Field=20Communication=20(NFC)=20devices=0D=0A#=0D=
=0A#=20CONFIG_NFC_TRF7970A=20is=20not=20set=0D=0A#=20CONFIG_NFC_SIM=20is=20=
not=20set=0D=0ACONFIG_NFC_PORT100=3Dy=0D=0A#=20CONFIG_NFC_VIRTUAL_NCI=20is=
=20not=20set=0D=0A#=20CONFIG_NFC_FDP=20is=20not=20set=0D=0ACONFIG_NFC_PN533=
=3Dy=0D=0ACONFIG_NFC_PN533_USB=3Dy=0D=0A#=20CONFIG_NFC_PN533_I2C=20is=20not=
=20set=0D=0A#=20CONFIG_NFC_PN532_UART=20is=20not=20set=0D=0ACONFIG_NFC_MRVL=
=3Dy=0D=0ACONFIG_NFC_MRVL_USB=3Dy=0D=0A#=20CONFIG_NFC_MRVL_I2C=20is=20not=
=20set=0D=0A#=20CONFIG_NFC_ST_NCI_I2C=20is=20not=20set=0D=0A#=20CONFIG_NFC_=
ST_NCI_SPI=20is=20not=20set=0D=0A#=20CONFIG_NFC_NXP_NCI=20is=20not=20set=0D=
=0A#=20CONFIG_NFC_S3FWRN5_I2C=20is=20not=20set=0D=0A#=20CONFIG_NFC_S3FWRN82=
_UART=20is=20not=20set=0D=0A#=20CONFIG_NFC_ST95HF=20is=20not=20set=0D=0A#=
=20end=20of=20Near=20Field=20Communication=20(NFC)=20devices=0D=0A=0D=0A#=
=20CONFIG_PSAMPLE=20is=20not=20set=0D=0A#=20CONFIG_NET_IFE=20is=20not=20set=
=0D=0A#=20CONFIG_LWTUNNEL=20is=20not=20set=0D=0ACONFIG_DST_CACHE=3Dy=0D=0AC=
ONFIG_GRO_CELLS=3Dy=0D=0ACONFIG_NET_SELFTESTS=3Dy=0D=0ACONFIG_NET_SOCK_MSG=
=3Dy=0D=0ACONFIG_NET_DEVLINK=3Dy=0D=0ACONFIG_PAGE_POOL=3Dy=0D=0A#=20CONFIG_=
PAGE_POOL_STATS=20is=20not=20set=0D=0ACONFIG_FAILOVER=3Dy=0D=0ACONFIG_ETHTO=
OL_NETLINK=3Dy=0D=0A=0D=0A#=0D=0A#=20Device=20Drivers=0D=0A#=0D=0ACONFIG_HA=
VE_PCI=3Dy=0D=0ACONFIG_GENERIC_PCI_IOMAP=3Dy=0D=0ACONFIG_PCI=3Dy=0D=0ACONFI=
G_PCI_DOMAINS=3Dy=0D=0ACONFIG_PCIEPORTBUS=3Dy=0D=0A#=20CONFIG_HOTPLUG_PCI_P=
CIE=20is=20not=20set=0D=0A#=20CONFIG_PCIEAER=20is=20not=20set=0D=0ACONFIG_P=
CIEASPM=3Dy=0D=0ACONFIG_PCIEASPM_DEFAULT=3Dy=0D=0A#=20CONFIG_PCIEASPM_POWER=
SAVE=20is=20not=20set=0D=0A#=20CONFIG_PCIEASPM_POWER_SUPERSAVE=20is=20not=
=20set=0D=0A#=20CONFIG_PCIEASPM_PERFORMANCE=20is=20not=20set=0D=0ACONFIG_PC=
IE_PME=3Dy=0D=0A#=20CONFIG_PCIE_PTM=20is=20not=20set=0D=0ACONFIG_PCI_MSI=3D=
y=0D=0ACONFIG_PCI_QUIRKS=3Dy=0D=0A#=20CONFIG_PCI_DEBUG=20is=20not=20set=0D=
=0A#=20CONFIG_PCI_STUB=20is=20not=20set=0D=0ACONFIG_PCI_ATS=3Dy=0D=0A#=20CO=
NFIG_PCI_DOE=20is=20not=20set=0D=0ACONFIG_PCI_ECAM=3Dy=0D=0ACONFIG_PCI_LOCK=
LESS_CONFIG=3Dy=0D=0A#=20CONFIG_PCI_IOV=20is=20not=20set=0D=0A#=20CONFIG_PC=
I_NPEM=20is=20not=20set=0D=0ACONFIG_PCI_PRI=3Dy=0D=0ACONFIG_PCI_PASID=3Dy=
=0D=0A#=20CONFIG_PCIE_TPH=20is=20not=20set=0D=0ACONFIG_PCI_LABEL=3Dy=0D=0A#=
=20CONFIG_PCI_DYNAMIC_OF_NODES=20is=20not=20set=0D=0A#=20CONFIG_PCIE_BUS_TU=
NE_OFF=20is=20not=20set=0D=0ACONFIG_PCIE_BUS_DEFAULT=3Dy=0D=0A#=20CONFIG_PC=
IE_BUS_SAFE=20is=20not=20set=0D=0A#=20CONFIG_PCIE_BUS_PERFORMANCE=20is=20no=
t=20set=0D=0A#=20CONFIG_PCIE_BUS_PEER2PEER=20is=20not=20set=0D=0ACONFIG_VGA=
_ARB=3Dy=0D=0ACONFIG_VGA_ARB_MAX_GPUS=3D16=0D=0ACONFIG_HOTPLUG_PCI=3Dy=0D=
=0A#=20CONFIG_HOTPLUG_PCI_ACPI=20is=20not=20set=0D=0A#=20CONFIG_HOTPLUG_PCI=
_CPCI=20is=20not=20set=0D=0A#=20CONFIG_HOTPLUG_PCI_OCTEONEP=20is=20not=20se=
t=0D=0A#=20CONFIG_HOTPLUG_PCI_SHPC=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20P=
CI=20controller=20drivers=0D=0A#=0D=0ACONFIG_PCI_HOST_COMMON=3Dy=0D=0A#=20C=
ONFIG_PCI_FTPCI100=20is=20not=20set=0D=0ACONFIG_PCI_HOST_GENERIC=3Dy=0D=0A#=
=20CONFIG_VMD=20is=20not=20set=0D=0A#=20CONFIG_PCIE_XILINX=20is=20not=20set=
=0D=0A=0D=0A#=0D=0A#=20Cadence-based=20PCIe=20controllers=0D=0A#=0D=0A#=20C=
ONFIG_PCIE_CADENCE_PLAT_HOST=20is=20not=20set=0D=0A#=20end=20of=20Cadence-b=
ased=20PCIe=20controllers=0D=0A=0D=0A#=0D=0A#=20DesignWare-based=20PCIe=20c=
ontrollers=0D=0A#=0D=0A#=20CONFIG_PCI_MESON=20is=20not=20set=0D=0A#=20CONFI=
G_PCIE_INTEL_GW=20is=20not=20set=0D=0A#=20CONFIG_PCIE_DW_PLAT_HOST=20is=20n=
ot=20set=0D=0A#=20end=20of=20DesignWare-based=20PCIe=20controllers=0D=0A=0D=
=0A#=0D=0A#=20Mobiveil-based=20PCIe=20controllers=0D=0A#=0D=0A#=20end=20of=
=20Mobiveil-based=20PCIe=20controllers=0D=0A=0D=0A#=0D=0A#=20PLDA-based=20P=
CIe=20controllers=0D=0A#=0D=0A#=20CONFIG_PCIE_MICROCHIP_HOST=20is=20not=20s=
et=0D=0A#=20end=20of=20PLDA-based=20PCIe=20controllers=0D=0A#=20end=20of=20=
PCI=20controller=20drivers=0D=0A=0D=0A#=0D=0A#=20PCI=20Endpoint=0D=0A#=0D=
=0A#=20CONFIG_PCI_ENDPOINT=20is=20not=20set=0D=0A#=20end=20of=20PCI=20Endpo=
int=0D=0A=0D=0A#=0D=0A#=20PCI=20switch=20controller=20drivers=0D=0A#=0D=0A#=
=20CONFIG_PCI_SW_SWITCHTEC=20is=20not=20set=0D=0A#=20end=20of=20PCI=20switc=
h=20controller=20drivers=0D=0A=0D=0A#=20CONFIG_PCI_PWRCTRL_SLOT=20is=20not=
=20set=0D=0A#=20CONFIG_CXL_BUS=20is=20not=20set=0D=0ACONFIG_PCCARD=3Dy=0D=
=0ACONFIG_PCMCIA=3Dy=0D=0ACONFIG_PCMCIA_LOAD_CIS=3Dy=0D=0ACONFIG_CARDBUS=3D=
y=0D=0A=0D=0A#=0D=0A#=20PC-card=20bridges=0D=0A#=0D=0ACONFIG_YENTA=3Dy=0D=
=0ACONFIG_YENTA_O2=3Dy=0D=0ACONFIG_YENTA_RICOH=3Dy=0D=0ACONFIG_YENTA_TI=3Dy=
=0D=0ACONFIG_YENTA_ENE_TUNE=3Dy=0D=0ACONFIG_YENTA_TOSHIBA=3Dy=0D=0A#=20CONF=
IG_PD6729=20is=20not=20set=0D=0A#=20CONFIG_I82092=20is=20not=20set=0D=0ACON=
FIG_PCCARD_NONSTATIC=3Dy=0D=0A#=20CONFIG_RAPIDIO=20is=20not=20set=0D=0A#=20=
CONFIG_PC104=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Generic=20Driver=20Opti=
ons=0D=0A#=0D=0ACONFIG_AUXILIARY_BUS=3Dy=0D=0ACONFIG_UEVENT_HELPER=3Dy=0D=
=0ACONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"=0D=0ACONFIG_DEVTMPFS=3Dy=0D=
=0ACONFIG_DEVTMPFS_MOUNT=3Dy=0D=0A#=20CONFIG_DEVTMPFS_SAFE=20is=20not=20set=
=0D=0ACONFIG_STANDALONE=3Dy=0D=0ACONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0D=0A=0D=
=0A#=0D=0A#=20Firmware=20loader=0D=0A#=0D=0ACONFIG_FW_LOADER=3Dy=0D=0A#=20C=
ONFIG_FW_LOADER_DEBUG=20is=20not=20set=0D=0ACONFIG_EXTRA_FIRMWARE=3D""=0D=
=0A#=20CONFIG_FW_LOADER_USER_HELPER=20is=20not=20set=0D=0A#=20CONFIG_FW_LOA=
DER_COMPRESS=20is=20not=20set=0D=0ACONFIG_FW_CACHE=3Dy=0D=0A#=20CONFIG_FW_U=
PLOAD=20is=20not=20set=0D=0A#=20end=20of=20Firmware=20loader=0D=0A=0D=0ACON=
FIG_WANT_DEV_COREDUMP=3Dy=0D=0ACONFIG_ALLOW_DEV_COREDUMP=3Dy=0D=0ACONFIG_DE=
V_COREDUMP=3Dy=0D=0A#=20CONFIG_DEBUG_DRIVER=20is=20not=20set=0D=0ACONFIG_DE=
BUG_DEVRES=3Dy=0D=0A#=20CONFIG_DEBUG_TEST_DRIVER_REMOVE=20is=20not=20set=0D=
=0A#=20CONFIG_TEST_ASYNC_DRIVER_PROBE=20is=20not=20set=0D=0ACONFIG_GENERIC_=
CPU_DEVICES=3Dy=0D=0ACONFIG_GENERIC_CPU_AUTOPROBE=3Dy=0D=0ACONFIG_GENERIC_C=
PU_VULNERABILITIES=3Dy=0D=0ACONFIG_REGMAP=3Dy=0D=0ACONFIG_REGMAP_I2C=3Dy=0D=
=0ACONFIG_REGMAP_SPI=3Dy=0D=0ACONFIG_REGMAP_MMIO=3Dy=0D=0ACONFIG_REGMAP_IRQ=
=3Dy=0D=0ACONFIG_DMA_SHARED_BUFFER=3Dy=0D=0A#=20CONFIG_DMA_FENCE_TRACE=20is=
=20not=20set=0D=0A#=20CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT=20is=20not=20set=
=0D=0A#=20end=20of=20Generic=20Driver=20Options=0D=0A=0D=0A#=0D=0A#=20Bus=
=20devices=0D=0A#=0D=0A#=20CONFIG_MOXTET=20is=20not=20set=0D=0A#=20CONFIG_M=
HI_BUS=20is=20not=20set=0D=0A#=20CONFIG_MHI_BUS_EP=20is=20not=20set=0D=0A#=
=20end=20of=20Bus=20devices=0D=0A=0D=0A#=0D=0A#=20Cache=20Drivers=0D=0A#=0D=
=0A#=20end=20of=20Cache=20Drivers=0D=0A=0D=0ACONFIG_CONNECTOR=3Dy=0D=0ACONF=
IG_PROC_EVENTS=3Dy=0D=0A=0D=0A#=0D=0A#=20Firmware=20Drivers=0D=0A#=0D=0A=0D=
=0A#=0D=0A#=20ARM=20System=20Control=20and=20Management=20Interface=20Proto=
col=0D=0A#=0D=0A#=20end=20of=20ARM=20System=20Control=20and=20Management=20=
Interface=20Protocol=0D=0A=0D=0A#=20CONFIG_EDD=20is=20not=20set=0D=0ACONFIG=
_FIRMWARE_MEMMAP=3Dy=0D=0ACONFIG_DMIID=3Dy=0D=0A#=20CONFIG_DMI_SYSFS=20is=
=20not=20set=0D=0ACONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy=0D=0A#=20CON=
FIG_ISCSI_IBFT=20is=20not=20set=0D=0A#=20CONFIG_FW_CFG_SYSFS=20is=20not=20s=
et=0D=0A#=20CONFIG_SYSFB_SIMPLEFB=20is=20not=20set=0D=0A#=20CONFIG_GOOGLE_F=
IRMWARE=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Qualcomm=20firmware=20driver=
s=0D=0A#=0D=0A#=20end=20of=20Qualcomm=20firmware=20drivers=0D=0A=0D=0A#=0D=
=0A#=20Tegra=20firmware=20driver=0D=0A#=0D=0A#=20end=20of=20Tegra=20firmwar=
e=20driver=0D=0A#=20end=20of=20Firmware=20Drivers=0D=0A=0D=0A#=20CONFIG_FWC=
TL=20is=20not=20set=0D=0ACONFIG_GNSS=3Dy=0D=0A#=20CONFIG_GNSS_MTK_SERIAL=20=
is=20not=20set=0D=0A#=20CONFIG_GNSS_SIRF_SERIAL=20is=20not=20set=0D=0A#=20C=
ONFIG_GNSS_UBX_SERIAL=20is=20not=20set=0D=0ACONFIG_GNSS_USB=3Dy=0D=0A#=20CO=
NFIG_MTD=20is=20not=20set=0D=0ACONFIG_DTC=3Dy=0D=0ACONFIG_OF=3Dy=0D=0A#=20C=
ONFIG_OF_UNITTEST=20is=20not=20set=0D=0ACONFIG_OF_FLATTREE=3Dy=0D=0ACONFIG_=
OF_EARLY_FLATTREE=3Dy=0D=0ACONFIG_OF_KOBJ=3Dy=0D=0ACONFIG_OF_ADDRESS=3Dy=0D=
=0ACONFIG_OF_IRQ=3Dy=0D=0ACONFIG_OF_RESERVED_MEM=3Dy=0D=0A#=20CONFIG_OF_OVE=
RLAY=20is=20not=20set=0D=0ACONFIG_OF_NUMA=3Dy=0D=0ACONFIG_ARCH_MIGHT_HAVE_P=
C_PARPORT=3Dy=0D=0ACONFIG_PARPORT=3Dy=0D=0A#=20CONFIG_PARPORT_PC=20is=20not=
=20set=0D=0A#=20CONFIG_PARPORT_1284=20is=20not=20set=0D=0ACONFIG_PARPORT_NO=
T_PC=3Dy=0D=0ACONFIG_PNP=3Dy=0D=0ACONFIG_PNP_DEBUG_MESSAGES=3Dy=0D=0A=0D=0A=
#=0D=0A#=20Protocols=0D=0A#=0D=0ACONFIG_PNPACPI=3Dy=0D=0ACONFIG_BLK_DEV=3Dy=
=0D=0A#=20CONFIG_BLK_DEV_NULL_BLK=20is=20not=20set=0D=0A#=20CONFIG_BLK_DEV_=
FD=20is=20not=20set=0D=0ACONFIG_CDROM=3Dy=0D=0A#=20CONFIG_BLK_DEV_PCIESSD_M=
TIP32XX=20is=20not=20set=0D=0A#=20CONFIG_ZRAM=20is=20not=20set=0D=0ACONFIG_=
BLK_DEV_LOOP=3Dy=0D=0ACONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8=0D=0A#=20CONFIG_BLK=
_DEV_DRBD=20is=20not=20set=0D=0A#=20CONFIG_BLK_DEV_NBD=20is=20not=20set=0D=
=0A#=20CONFIG_BLK_DEV_RAM=20is=20not=20set=0D=0A#=20CONFIG_ATA_OVER_ETH=20i=
s=20not=20set=0D=0ACONFIG_VIRTIO_BLK=3Dy=0D=0A#=20CONFIG_BLK_DEV_RBD=20is=
=20not=20set=0D=0A#=20CONFIG_BLK_DEV_UBLK=20is=20not=20set=0D=0A=0D=0A#=0D=
=0A#=20NVME=20Support=0D=0A#=0D=0A#=20CONFIG_BLK_DEV_NVME=20is=20not=20set=
=0D=0A#=20CONFIG_NVME_FC=20is=20not=20set=0D=0A#=20CONFIG_NVME_TCP=20is=20n=
ot=20set=0D=0A#=20CONFIG_NVME_TARGET=20is=20not=20set=0D=0A#=20end=20of=20N=
VME=20Support=0D=0A=0D=0A#=0D=0A#=20Misc=20devices=0D=0A#=0D=0A#=20CONFIG_A=
D525X_DPOT=20is=20not=20set=0D=0A#=20CONFIG_DUMMY_IRQ=20is=20not=20set=0D=
=0A#=20CONFIG_IBM_ASM=20is=20not=20set=0D=0A#=20CONFIG_PHANTOM=20is=20not=
=20set=0D=0A#=20CONFIG_RPMB=20is=20not=20set=0D=0A#=20CONFIG_TI_FPC202=20is=
=20not=20set=0D=0A#=20CONFIG_TIFM_CORE=20is=20not=20set=0D=0A#=20CONFIG_ICS=
932S401=20is=20not=20set=0D=0A#=20CONFIG_ENCLOSURE_SERVICES=20is=20not=20se=
t=0D=0A#=20CONFIG_HP_ILO=20is=20not=20set=0D=0A#=20CONFIG_APDS9802ALS=20is=
=20not=20set=0D=0A#=20CONFIG_ISL29003=20is=20not=20set=0D=0A#=20CONFIG_ISL2=
9020=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_TSL2550=20is=20not=20set=0D=
=0A#=20CONFIG_SENSORS_BH1770=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_APDS9=
90X=20is=20not=20set=0D=0A#=20CONFIG_HMC6352=20is=20not=20set=0D=0A#=20CONF=
IG_DS1682=20is=20not=20set=0D=0A#=20CONFIG_LATTICE_ECP3_CONFIG=20is=20not=
=20set=0D=0A#=20CONFIG_SRAM=20is=20not=20set=0D=0A#=20CONFIG_DW_XDATA_PCIE=
=20is=20not=20set=0D=0A#=20CONFIG_PCI_ENDPOINT_TEST=20is=20not=20set=0D=0A#=
=20CONFIG_XILINX_SDFEC=20is=20not=20set=0D=0ACONFIG_MISC_RTSX=3Dy=0D=0A#=20=
CONFIG_HISI_HIKEY_USB=20is=20not=20set=0D=0A#=20CONFIG_OPEN_DICE=20is=20not=
=20set=0D=0A#=20CONFIG_NTSYNC=20is=20not=20set=0D=0A#=20CONFIG_VCPU_STALL_D=
ETECTOR=20is=20not=20set=0D=0A#=20CONFIG_NSM=20is=20not=20set=0D=0A#=20CONF=
IG_C2PORT=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20EEPROM=20support=0D=0A#=0D=
=0A#=20CONFIG_EEPROM_AT24=20is=20not=20set=0D=0A#=20CONFIG_EEPROM_AT25=20is=
=20not=20set=0D=0A#=20CONFIG_EEPROM_MAX6875=20is=20not=20set=0D=0ACONFIG_EE=
PROM_93CX6=3Dy=0D=0A#=20CONFIG_EEPROM_93XX46=20is=20not=20set=0D=0A#=20CONF=
IG_EEPROM_IDT_89HPESX=20is=20not=20set=0D=0A#=20CONFIG_EEPROM_EE1004=20is=
=20not=20set=0D=0A#=20CONFIG_EEPROM_M24LR=20is=20not=20set=0D=0A#=20end=20o=
f=20EEPROM=20support=0D=0A=0D=0A#=20CONFIG_CB710_CORE=20is=20not=20set=0D=
=0A#=20CONFIG_SENSORS_LIS3_I2C=20is=20not=20set=0D=0A#=20CONFIG_ALTERA_STAP=
L=20is=20not=20set=0D=0ACONFIG_INTEL_MEI=3Dy=0D=0ACONFIG_INTEL_MEI_ME=3Dy=
=0D=0A#=20CONFIG_INTEL_MEI_TXE=20is=20not=20set=0D=0A#=20CONFIG_INTEL_MEI_G=
SC=20is=20not=20set=0D=0A#=20CONFIG_INTEL_MEI_VSC_HW=20is=20not=20set=0D=0A=
#=20CONFIG_INTEL_MEI_HDCP=20is=20not=20set=0D=0A#=20CONFIG_INTEL_MEI_PXP=20=
is=20not=20set=0D=0A#=20CONFIG_INTEL_MEI_GSC_PROXY=20is=20not=20set=0D=0A#=
=20CONFIG_VMWARE_VMCI=20is=20not=20set=0D=0A#=20CONFIG_GENWQE=20is=20not=20=
set=0D=0A#=20CONFIG_BCM_VK=20is=20not=20set=0D=0A#=20CONFIG_MISC_ALCOR_PCI=
=20is=20not=20set=0D=0A#=20CONFIG_MISC_RTSX_PCI=20is=20not=20set=0D=0ACONFI=
G_MISC_RTSX_USB=3Dy=0D=0A#=20CONFIG_UACCE=20is=20not=20set=0D=0A#=20CONFIG_=
PVPANIC=20is=20not=20set=0D=0A#=20CONFIG_GP_PCI1XXXX=20is=20not=20set=0D=0A=
#=20CONFIG_KEBA_CP500=20is=20not=20set=0D=0A#=20end=20of=20Misc=20devices=
=0D=0A=0D=0A#=0D=0A#=20SCSI=20device=20support=0D=0A#=0D=0ACONFIG_SCSI_MOD=
=3Dy=0D=0A#=20CONFIG_RAID_ATTRS=20is=20not=20set=0D=0ACONFIG_SCSI_COMMON=3D=
y=0D=0ACONFIG_SCSI=3Dy=0D=0ACONFIG_SCSI_DMA=3Dy=0D=0ACONFIG_SCSI_PROC_FS=3D=
y=0D=0A=0D=0A#=0D=0A#=20SCSI=20support=20type=20(disk,=20tape,=20CD-ROM)=0D=
=0A#=0D=0ACONFIG_BLK_DEV_SD=3Dy=0D=0A#=20CONFIG_CHR_DEV_ST=20is=20not=20set=
=0D=0ACONFIG_BLK_DEV_SR=3Dy=0D=0ACONFIG_CHR_DEV_SG=3Dy=0D=0ACONFIG_BLK_DEV_=
BSG=3Dy=0D=0A#=20CONFIG_CHR_DEV_SCH=20is=20not=20set=0D=0ACONFIG_SCSI_CONST=
ANTS=3Dy=0D=0A#=20CONFIG_SCSI_LOGGING=20is=20not=20set=0D=0A#=20CONFIG_SCSI=
_SCAN_ASYNC=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20SCSI=20Transports=0D=0A#=
=0D=0ACONFIG_SCSI_SPI_ATTRS=3Dy=0D=0A#=20CONFIG_SCSI_FC_ATTRS=20is=20not=20=
set=0D=0A#=20CONFIG_SCSI_ISCSI_ATTRS=20is=20not=20set=0D=0A#=20CONFIG_SCSI_=
SAS_ATTRS=20is=20not=20set=0D=0A#=20CONFIG_SCSI_SAS_LIBSAS=20is=20not=20set=
=0D=0A#=20CONFIG_SCSI_SRP_ATTRS=20is=20not=20set=0D=0A#=20end=20of=20SCSI=
=20Transports=0D=0A=0D=0ACONFIG_SCSI_LOWLEVEL=3Dy=0D=0A#=20CONFIG_ISCSI_TCP=
=20is=20not=20set=0D=0A#=20CONFIG_ISCSI_BOOT_SYSFS=20is=20not=20set=0D=0A#=
=20CONFIG_SCSI_CXGB3_ISCSI=20is=20not=20set=0D=0A#=20CONFIG_SCSI_CXGB4_ISCS=
I=20is=20not=20set=0D=0A#=20CONFIG_SCSI_BNX2_ISCSI=20is=20not=20set=0D=0A#=
=20CONFIG_BE2ISCSI=20is=20not=20set=0D=0A#=20CONFIG_BLK_DEV_3W_XXXX_RAID=20=
is=20not=20set=0D=0A#=20CONFIG_SCSI_HPSA=20is=20not=20set=0D=0A#=20CONFIG_S=
CSI_3W_9XXX=20is=20not=20set=0D=0A#=20CONFIG_SCSI_3W_SAS=20is=20not=20set=
=0D=0A#=20CONFIG_SCSI_ACARD=20is=20not=20set=0D=0A#=20CONFIG_SCSI_AACRAID=
=20is=20not=20set=0D=0A#=20CONFIG_SCSI_AIC7XXX=20is=20not=20set=0D=0A#=20CO=
NFIG_SCSI_AIC79XX=20is=20not=20set=0D=0A#=20CONFIG_SCSI_AIC94XX=20is=20not=
=20set=0D=0A#=20CONFIG_SCSI_MVSAS=20is=20not=20set=0D=0A#=20CONFIG_SCSI_MVU=
MI=20is=20not=20set=0D=0A#=20CONFIG_SCSI_ADVANSYS=20is=20not=20set=0D=0A#=
=20CONFIG_SCSI_ARCMSR=20is=20not=20set=0D=0A#=20CONFIG_SCSI_ESAS2R=20is=20n=
ot=20set=0D=0A#=20CONFIG_MEGARAID_NEWGEN=20is=20not=20set=0D=0A#=20CONFIG_M=
EGARAID_LEGACY=20is=20not=20set=0D=0A#=20CONFIG_MEGARAID_SAS=20is=20not=20s=
et=0D=0A#=20CONFIG_SCSI_MPT3SAS=20is=20not=20set=0D=0A#=20CONFIG_SCSI_MPT2S=
AS=20is=20not=20set=0D=0A#=20CONFIG_SCSI_MPI3MR=20is=20not=20set=0D=0A#=20C=
ONFIG_SCSI_SMARTPQI=20is=20not=20set=0D=0A#=20CONFIG_SCSI_HPTIOP=20is=20not=
=20set=0D=0A#=20CONFIG_SCSI_BUSLOGIC=20is=20not=20set=0D=0A#=20CONFIG_SCSI_=
MYRB=20is=20not=20set=0D=0A#=20CONFIG_SCSI_MYRS=20is=20not=20set=0D=0A#=20C=
ONFIG_VMWARE_PVSCSI=20is=20not=20set=0D=0A#=20CONFIG_SCSI_SNIC=20is=20not=
=20set=0D=0A#=20CONFIG_SCSI_DMX3191D=20is=20not=20set=0D=0A#=20CONFIG_SCSI_=
FDOMAIN_PCI=20is=20not=20set=0D=0A#=20CONFIG_SCSI_ISCI=20is=20not=20set=0D=
=0A#=20CONFIG_SCSI_IPS=20is=20not=20set=0D=0A#=20CONFIG_SCSI_INITIO=20is=20=
not=20set=0D=0A#=20CONFIG_SCSI_INIA100=20is=20not=20set=0D=0A#=20CONFIG_SCS=
I_STEX=20is=20not=20set=0D=0A#=20CONFIG_SCSI_SYM53C8XX_2=20is=20not=20set=
=0D=0A#=20CONFIG_SCSI_IPR=20is=20not=20set=0D=0A#=20CONFIG_SCSI_QLOGIC_1280=
=20is=20not=20set=0D=0A#=20CONFIG_SCSI_QLA_ISCSI=20is=20not=20set=0D=0A#=20=
CONFIG_SCSI_DC395x=20is=20not=20set=0D=0A#=20CONFIG_SCSI_AM53C974=20is=20no=
t=20set=0D=0A#=20CONFIG_SCSI_WD719X=20is=20not=20set=0D=0A#=20CONFIG_SCSI_D=
EBUG=20is=20not=20set=0D=0A#=20CONFIG_SCSI_PMCRAID=20is=20not=20set=0D=0A#=
=20CONFIG_SCSI_PM8001=20is=20not=20set=0D=0ACONFIG_SCSI_VIRTIO=3Dy=0D=0A#=
=20CONFIG_SCSI_LOWLEVEL_PCMCIA=20is=20not=20set=0D=0A#=20CONFIG_SCSI_DH=20i=
s=20not=20set=0D=0A#=20end=20of=20SCSI=20device=20support=0D=0A=0D=0ACONFIG=
_ATA=3Dy=0D=0ACONFIG_SATA_HOST=3Dy=0D=0ACONFIG_PATA_TIMINGS=3Dy=0D=0ACONFIG=
_ATA_VERBOSE_ERROR=3Dy=0D=0ACONFIG_ATA_FORCE=3Dy=0D=0ACONFIG_ATA_ACPI=3Dy=
=0D=0A#=20CONFIG_SATA_ZPODD=20is=20not=20set=0D=0ACONFIG_SATA_PMP=3Dy=0D=0A=
=0D=0A#=0D=0A#=20Controllers=20with=20non-SFF=20native=20interface=0D=0A#=
=0D=0ACONFIG_SATA_AHCI=3Dy=0D=0ACONFIG_SATA_MOBILE_LPM_POLICY=3D3=0D=0A#=20=
CONFIG_SATA_AHCI_PLATFORM=20is=20not=20set=0D=0A#=20CONFIG_AHCI_DWC=20is=20=
not=20set=0D=0A#=20CONFIG_AHCI_CEVA=20is=20not=20set=0D=0A#=20CONFIG_SATA_I=
NIC162X=20is=20not=20set=0D=0A#=20CONFIG_SATA_ACARD_AHCI=20is=20not=20set=
=0D=0A#=20CONFIG_SATA_SIL24=20is=20not=20set=0D=0ACONFIG_ATA_SFF=3Dy=0D=0A=
=0D=0A#=0D=0A#=20SFF=20controllers=20with=20custom=20DMA=20interface=0D=0A#=
=0D=0A#=20CONFIG_PDC_ADMA=20is=20not=20set=0D=0A#=20CONFIG_SATA_QSTOR=20is=
=20not=20set=0D=0A#=20CONFIG_SATA_SX4=20is=20not=20set=0D=0ACONFIG_ATA_BMDM=
A=3Dy=0D=0A=0D=0A#=0D=0A#=20SATA=20SFF=20controllers=20with=20BMDMA=0D=0A#=
=0D=0ACONFIG_ATA_PIIX=3Dy=0D=0A#=20CONFIG_SATA_DWC=20is=20not=20set=0D=0A#=
=20CONFIG_SATA_MV=20is=20not=20set=0D=0A#=20CONFIG_SATA_NV=20is=20not=20set=
=0D=0A#=20CONFIG_SATA_PROMISE=20is=20not=20set=0D=0A#=20CONFIG_SATA_SIL=20i=
s=20not=20set=0D=0A#=20CONFIG_SATA_SIS=20is=20not=20set=0D=0A#=20CONFIG_SAT=
A_SVW=20is=20not=20set=0D=0A#=20CONFIG_SATA_ULI=20is=20not=20set=0D=0A#=20C=
ONFIG_SATA_VIA=20is=20not=20set=0D=0A#=20CONFIG_SATA_VITESSE=20is=20not=20s=
et=0D=0A=0D=0A#=0D=0A#=20PATA=20SFF=20controllers=20with=20BMDMA=0D=0A#=0D=
=0A#=20CONFIG_PATA_ALI=20is=20not=20set=0D=0ACONFIG_PATA_AMD=3Dy=0D=0A#=20C=
ONFIG_PATA_ARTOP=20is=20not=20set=0D=0A#=20CONFIG_PATA_ATIIXP=20is=20not=20=
set=0D=0A#=20CONFIG_PATA_ATP867X=20is=20not=20set=0D=0A#=20CONFIG_PATA_CMD6=
4X=20is=20not=20set=0D=0A#=20CONFIG_PATA_CYPRESS=20is=20not=20set=0D=0A#=20=
CONFIG_PATA_EFAR=20is=20not=20set=0D=0A#=20CONFIG_PATA_HPT366=20is=20not=20=
set=0D=0A#=20CONFIG_PATA_HPT37X=20is=20not=20set=0D=0A#=20CONFIG_PATA_HPT3X=
2N=20is=20not=20set=0D=0A#=20CONFIG_PATA_HPT3X3=20is=20not=20set=0D=0A#=20C=
ONFIG_PATA_IT8213=20is=20not=20set=0D=0A#=20CONFIG_PATA_IT821X=20is=20not=
=20set=0D=0A#=20CONFIG_PATA_JMICRON=20is=20not=20set=0D=0A#=20CONFIG_PATA_M=
ARVELL=20is=20not=20set=0D=0A#=20CONFIG_PATA_NETCELL=20is=20not=20set=0D=0A=
#=20CONFIG_PATA_NINJA32=20is=20not=20set=0D=0A#=20CONFIG_PATA_NS87415=20is=
=20not=20set=0D=0ACONFIG_PATA_OLDPIIX=3Dy=0D=0A#=20CONFIG_PATA_OPTIDMA=20is=
=20not=20set=0D=0A#=20CONFIG_PATA_PDC2027X=20is=20not=20set=0D=0A#=20CONFIG=
_PATA_PDC_OLD=20is=20not=20set=0D=0A#=20CONFIG_PATA_RADISYS=20is=20not=20se=
t=0D=0A#=20CONFIG_PATA_RDC=20is=20not=20set=0D=0ACONFIG_PATA_SCH=3Dy=0D=0A#=
=20CONFIG_PATA_SERVERWORKS=20is=20not=20set=0D=0A#=20CONFIG_PATA_SIL680=20i=
s=20not=20set=0D=0A#=20CONFIG_PATA_SIS=20is=20not=20set=0D=0A#=20CONFIG_PAT=
A_TOSHIBA=20is=20not=20set=0D=0A#=20CONFIG_PATA_TRIFLEX=20is=20not=20set=0D=
=0A#=20CONFIG_PATA_VIA=20is=20not=20set=0D=0A#=20CONFIG_PATA_WINBOND=20is=
=20not=20set=0D=0A=0D=0A#=0D=0A#=20PIO-only=20SFF=20controllers=0D=0A#=0D=
=0A#=20CONFIG_PATA_CMD640_PCI=20is=20not=20set=0D=0A#=20CONFIG_PATA_MPIIX=
=20is=20not=20set=0D=0A#=20CONFIG_PATA_NS87410=20is=20not=20set=0D=0A#=20CO=
NFIG_PATA_OPTI=20is=20not=20set=0D=0A#=20CONFIG_PATA_PCMCIA=20is=20not=20se=
t=0D=0A#=20CONFIG_PATA_OF_PLATFORM=20is=20not=20set=0D=0A#=20CONFIG_PATA_RZ=
1000=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Generic=20fallback=20/=20legacy=
=20drivers=0D=0A#=0D=0A#=20CONFIG_PATA_ACPI=20is=20not=20set=0D=0A#=20CONFI=
G_ATA_GENERIC=20is=20not=20set=0D=0A#=20CONFIG_PATA_LEGACY=20is=20not=20set=
=0D=0ACONFIG_MD=3Dy=0D=0ACONFIG_BLK_DEV_MD=3Dy=0D=0ACONFIG_MD_BITMAP=3Dy=0D=
=0A#=20CONFIG_MD_LLBITMAP=20is=20not=20set=0D=0ACONFIG_MD_AUTODETECT=3Dy=0D=
=0ACONFIG_MD_BITMAP_FILE=3Dy=0D=0A#=20CONFIG_MD_LINEAR=20is=20not=20set=0D=
=0A#=20CONFIG_MD_RAID0=20is=20not=20set=0D=0A#=20CONFIG_MD_RAID1=20is=20not=
=20set=0D=0A#=20CONFIG_MD_RAID10=20is=20not=20set=0D=0A#=20CONFIG_MD_RAID45=
6=20is=20not=20set=0D=0A#=20CONFIG_BCACHE=20is=20not=20set=0D=0ACONFIG_BLK_=
DEV_DM_BUILTIN=3Dy=0D=0ACONFIG_BLK_DEV_DM=3Dy=0D=0A#=20CONFIG_DM_DEBUG=20is=
=20not=20set=0D=0A#=20CONFIG_DM_UNSTRIPED=20is=20not=20set=0D=0A#=20CONFIG_=
DM_CRYPT=20is=20not=20set=0D=0A#=20CONFIG_DM_SNAPSHOT=20is=20not=20set=0D=
=0A#=20CONFIG_DM_THIN_PROVISIONING=20is=20not=20set=0D=0A#=20CONFIG_DM_CACH=
E=20is=20not=20set=0D=0A#=20CONFIG_DM_WRITECACHE=20is=20not=20set=0D=0A#=20=
CONFIG_DM_EBS=20is=20not=20set=0D=0A#=20CONFIG_DM_ERA=20is=20not=20set=0D=
=0A#=20CONFIG_DM_CLONE=20is=20not=20set=0D=0ACONFIG_DM_MIRROR=3Dy=0D=0A#=20=
CONFIG_DM_LOG_USERSPACE=20is=20not=20set=0D=0A#=20CONFIG_DM_RAID=20is=20not=
=20set=0D=0ACONFIG_DM_ZERO=3Dy=0D=0A#=20CONFIG_DM_MULTIPATH=20is=20not=20se=
t=0D=0A#=20CONFIG_DM_DELAY=20is=20not=20set=0D=0A#=20CONFIG_DM_DUST=20is=20=
not=20set=0D=0A#=20CONFIG_DM_INIT=20is=20not=20set=0D=0A#=20CONFIG_DM_UEVEN=
T=20is=20not=20set=0D=0A#=20CONFIG_DM_FLAKEY=20is=20not=20set=0D=0A#=20CONF=
IG_DM_VERITY=20is=20not=20set=0D=0A#=20CONFIG_DM_SWITCH=20is=20not=20set=0D=
=0A#=20CONFIG_DM_LOG_WRITES=20is=20not=20set=0D=0A#=20CONFIG_DM_INTEGRITY=
=20is=20not=20set=0D=0A#=20CONFIG_DM_AUDIT=20is=20not=20set=0D=0A#=20CONFIG=
_DM_VDO=20is=20not=20set=0D=0ACONFIG_TARGET_CORE=3Dy=0D=0A#=20CONFIG_TCM_IB=
LOCK=20is=20not=20set=0D=0A#=20CONFIG_TCM_FILEIO=20is=20not=20set=0D=0A#=20=
CONFIG_TCM_PSCSI=20is=20not=20set=0D=0A#=20CONFIG_LOOPBACK_TARGET=20is=20no=
t=20set=0D=0A#=20CONFIG_ISCSI_TARGET=20is=20not=20set=0D=0A#=20CONFIG_REMOT=
E_TARGET=20is=20not=20set=0D=0A#=20CONFIG_FUSION=20is=20not=20set=0D=0A=0D=
=0A#=0D=0A#=20IEEE=201394=20(FireWire)=20support=0D=0A#=0D=0A#=20CONFIG_FIR=
EWIRE=20is=20not=20set=0D=0A#=20CONFIG_FIREWIRE_NOSY=20is=20not=20set=0D=0A=
#=20end=20of=20IEEE=201394=20(FireWire)=20support=0D=0A=0D=0ACONFIG_MACINTO=
SH_DRIVERS=3Dy=0D=0ACONFIG_MAC_EMUMOUSEBTN=3Dy=0D=0ACONFIG_NETDEVICES=3Dy=
=0D=0ACONFIG_MII=3Dy=0D=0ACONFIG_NET_CORE=3Dy=0D=0A#=20CONFIG_BONDING=20is=
=20not=20set=0D=0A#=20CONFIG_DUMMY=20is=20not=20set=0D=0A#=20CONFIG_WIREGUA=
RD=20is=20not=20set=0D=0A#=20CONFIG_OVPN=20is=20not=20set=0D=0A#=20CONFIG_E=
QUALIZER=20is=20not=20set=0D=0A#=20CONFIG_NET_FC=20is=20not=20set=0D=0A#=20=
CONFIG_NET_TEAM=20is=20not=20set=0D=0A#=20CONFIG_MACVLAN=20is=20not=20set=
=0D=0A#=20CONFIG_IPVLAN=20is=20not=20set=0D=0A#=20CONFIG_VXLAN=20is=20not=
=20set=0D=0A#=20CONFIG_GENEVE=20is=20not=20set=0D=0A#=20CONFIG_BAREUDP=20is=
=20not=20set=0D=0A#=20CONFIG_GTP=20is=20not=20set=0D=0A#=20CONFIG_PFCP=20is=
=20not=20set=0D=0A#=20CONFIG_AMT=20is=20not=20set=0D=0A#=20CONFIG_MACSEC=20=
is=20not=20set=0D=0ACONFIG_NETCONSOLE=3Dy=0D=0A#=20CONFIG_NETCONSOLE_DYNAMI=
C=20is=20not=20set=0D=0A#=20CONFIG_NETCONSOLE_EXTENDED_LOG=20is=20not=20set=
=0D=0ACONFIG_NETPOLL=3Dy=0D=0ACONFIG_NET_POLL_CONTROLLER=3Dy=0D=0A#=20CONFI=
G_TUN=20is=20not=20set=0D=0A#=20CONFIG_TUN_VNET_CROSS_LE=20is=20not=20set=
=0D=0A#=20CONFIG_VETH=20is=20not=20set=0D=0ACONFIG_VIRTIO_NET=3Dy=0D=0A#=20=
CONFIG_NLMON=20is=20not=20set=0D=0A#=20CONFIG_NETKIT=20is=20not=20set=0D=0A=
#=20CONFIG_ARCNET=20is=20not=20set=0D=0A#=20CONFIG_ATM_DRIVERS=20is=20not=
=20set=0D=0ACONFIG_ETHERNET=3Dy=0D=0ACONFIG_NET_VENDOR_3COM=3Dy=0D=0A#=20CO=
NFIG_PCMCIA_3C574=20is=20not=20set=0D=0A#=20CONFIG_PCMCIA_3C589=20is=20not=
=20set=0D=0A#=20CONFIG_VORTEX=20is=20not=20set=0D=0A#=20CONFIG_TYPHOON=20is=
=20not=20set=0D=0ACONFIG_NET_VENDOR_ADAPTEC=3Dy=0D=0A#=20CONFIG_ADAPTEC_STA=
RFIRE=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_AGERE=3Dy=0D=0A#=20CONFIG_ET1=
31X=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_ALACRITECH=3Dy=0D=0A#=20CONFIG_=
SLICOSS=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_ALTEON=3Dy=0D=0A#=20CONFIG_=
ACENIC=20is=20not=20set=0D=0A#=20CONFIG_ALTERA_TSE=20is=20not=20set=0D=0ACO=
NFIG_NET_VENDOR_AMAZON=3Dy=0D=0A#=20CONFIG_ENA_ETHERNET=20is=20not=20set=0D=
=0ACONFIG_NET_VENDOR_AMD=3Dy=0D=0A#=20CONFIG_AMD8111_ETH=20is=20not=20set=
=0D=0A#=20CONFIG_PCNET32=20is=20not=20set=0D=0A#=20CONFIG_PCMCIA_NMCLAN=20i=
s=20not=20set=0D=0A#=20CONFIG_AMD_XGBE=20is=20not=20set=0D=0A#=20CONFIG_PDS=
_CORE=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_AQUANTIA=3Dy=0D=0A#=20CONFIG_=
AQTION=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_ARC=3Dy=0D=0ACONFIG_NET_VEND=
OR_ASIX=3Dy=0D=0A#=20CONFIG_SPI_AX88796C=20is=20not=20set=0D=0ACONFIG_NET_V=
ENDOR_ATHEROS=3Dy=0D=0A#=20CONFIG_ATL2=20is=20not=20set=0D=0A#=20CONFIG_ATL=
1=20is=20not=20set=0D=0A#=20CONFIG_ATL1E=20is=20not=20set=0D=0A#=20CONFIG_A=
TL1C=20is=20not=20set=0D=0A#=20CONFIG_ALX=20is=20not=20set=0D=0A#=20CONFIG_=
CX_ECAT=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_BROADCOM=3Dy=0D=0A#=20CONFI=
G_B44=20is=20not=20set=0D=0A#=20CONFIG_BCMGENET=20is=20not=20set=0D=0A#=20C=
ONFIG_BNX2=20is=20not=20set=0D=0A#=20CONFIG_CNIC=20is=20not=20set=0D=0ACONF=
IG_TIGON3=3Dy=0D=0ACONFIG_TIGON3_HWMON=3Dy=0D=0A#=20CONFIG_BNX2X=20is=20not=
=20set=0D=0A#=20CONFIG_SYSTEMPORT=20is=20not=20set=0D=0A#=20CONFIG_BNXT=20i=
s=20not=20set=0D=0A#=20CONFIG_BNGE=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_=
CADENCE=3Dy=0D=0A#=20CONFIG_MACB=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_CA=
VIUM=3Dy=0D=0A#=20CONFIG_THUNDER_NIC_PF=20is=20not=20set=0D=0A#=20CONFIG_TH=
UNDER_NIC_VF=20is=20not=20set=0D=0A#=20CONFIG_THUNDER_NIC_BGX=20is=20not=20=
set=0D=0A#=20CONFIG_THUNDER_NIC_RGX=20is=20not=20set=0D=0A#=20CONFIG_CAVIUM=
_PTP=20is=20not=20set=0D=0A#=20CONFIG_LIQUIDIO=20is=20not=20set=0D=0A#=20CO=
NFIG_LIQUIDIO_VF=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_CHELSIO=3Dy=0D=0A#=
=20CONFIG_CHELSIO_T1=20is=20not=20set=0D=0A#=20CONFIG_CHELSIO_T3=20is=20not=
=20set=0D=0A#=20CONFIG_CHELSIO_T4=20is=20not=20set=0D=0A#=20CONFIG_CHELSIO_=
T4VF=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_CISCO=3Dy=0D=0A#=20CONFIG_ENIC=
=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_CORTINA=3Dy=0D=0A#=20CONFIG_GEMINI=
_ETHERNET=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_DAVICOM=3Dy=0D=0A#=20CONF=
IG_DM9051=20is=20not=20set=0D=0A#=20CONFIG_DNET=20is=20not=20set=0D=0ACONFI=
G_NET_VENDOR_DEC=3Dy=0D=0ACONFIG_NET_TULIP=3Dy=0D=0A#=20CONFIG_DE2104X=20is=
=20not=20set=0D=0A#=20CONFIG_TULIP=20is=20not=20set=0D=0A#=20CONFIG_WINBOND=
_840=20is=20not=20set=0D=0A#=20CONFIG_DM9102=20is=20not=20set=0D=0A#=20CONF=
IG_ULI526X=20is=20not=20set=0D=0A#=20CONFIG_PCMCIA_XIRCOM=20is=20not=20set=
=0D=0ACONFIG_NET_VENDOR_DLINK=3Dy=0D=0A#=20CONFIG_DL2K=20is=20not=20set=0D=
=0A#=20CONFIG_SUNDANCE=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_EMULEX=3Dy=
=0D=0A#=20CONFIG_BE2NET=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_ENGLEDER=3D=
y=0D=0A#=20CONFIG_TSNEP=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_EZCHIP=3Dy=
=0D=0A#=20CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=20is=20not=20set=0D=0ACONFIG_NE=
T_VENDOR_FUJITSU=3Dy=0D=0A#=20CONFIG_PCMCIA_FMVJ18X=20is=20not=20set=0D=0AC=
ONFIG_NET_VENDOR_FUNGIBLE=3Dy=0D=0A#=20CONFIG_FUN_ETH=20is=20not=20set=0D=
=0ACONFIG_NET_VENDOR_GOOGLE=3Dy=0D=0ACONFIG_GVE=3Dy=0D=0ACONFIG_NET_VENDOR_=
HISILICON=3Dy=0D=0A#=20CONFIG_HIBMCGE=20is=20not=20set=0D=0ACONFIG_NET_VEND=
OR_HUAWEI=3Dy=0D=0A#=20CONFIG_HINIC=20is=20not=20set=0D=0A#=20CONFIG_HINIC3=
=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_I825XX=3Dy=0D=0ACONFIG_NET_VENDOR_=
INTEL=3Dy=0D=0ACONFIG_E100=3Dy=0D=0ACONFIG_E1000=3Dy=0D=0ACONFIG_E1000E=3Dy=
=0D=0ACONFIG_E1000E_HWTS=3Dy=0D=0A#=20CONFIG_IGB=20is=20not=20set=0D=0A#=20=
CONFIG_IGBVF=20is=20not=20set=0D=0A#=20CONFIG_IXGBE=20is=20not=20set=0D=0A#=
=20CONFIG_IXGBEVF=20is=20not=20set=0D=0A#=20CONFIG_I40E=20is=20not=20set=0D=
=0A#=20CONFIG_I40EVF=20is=20not=20set=0D=0A#=20CONFIG_ICE=20is=20not=20set=
=0D=0A#=20CONFIG_FM10K=20is=20not=20set=0D=0A#=20CONFIG_IGC=20is=20not=20se=
t=0D=0A#=20CONFIG_IDPF=20is=20not=20set=0D=0A#=20CONFIG_JME=20is=20not=20se=
t=0D=0A#=20CONFIG_NET_VENDOR_ADI=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_LI=
TEX=3Dy=0D=0A#=20CONFIG_LITEX_LITEETH=20is=20not=20set=0D=0ACONFIG_NET_VEND=
OR_MARVELL=3Dy=0D=0A#=20CONFIG_MVMDIO=20is=20not=20set=0D=0A#=20CONFIG_SKGE=
=20is=20not=20set=0D=0ACONFIG_SKY2=3Dy=0D=0A#=20CONFIG_SKY2_DEBUG=20is=20no=
t=20set=0D=0A#=20CONFIG_OCTEON_EP=20is=20not=20set=0D=0A#=20CONFIG_OCTEON_E=
P_VF=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_MELLANOX=3Dy=0D=0A#=20CONFIG_M=
LX4_EN=20is=20not=20set=0D=0A#=20CONFIG_MLX5_CORE=20is=20not=20set=0D=0A#=
=20CONFIG_MLXSW_CORE=20is=20not=20set=0D=0A#=20CONFIG_MLXFW=20is=20not=20se=
t=0D=0ACONFIG_NET_VENDOR_META=3Dy=0D=0A#=20CONFIG_FBNIC=20is=20not=20set=0D=
=0ACONFIG_NET_VENDOR_MICREL=3Dy=0D=0A#=20CONFIG_KS8842=20is=20not=20set=0D=
=0A#=20CONFIG_KS8851=20is=20not=20set=0D=0A#=20CONFIG_KS8851_MLL=20is=20not=
=20set=0D=0A#=20CONFIG_KSZ884X_PCI=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_=
MICROCHIP=3Dy=0D=0A#=20CONFIG_ENC28J60=20is=20not=20set=0D=0A#=20CONFIG_ENC=
X24J600=20is=20not=20set=0D=0A#=20CONFIG_LAN743X=20is=20not=20set=0D=0A#=20=
CONFIG_LAN865X=20is=20not=20set=0D=0A#=20CONFIG_VCAP=20is=20not=20set=0D=0A=
CONFIG_NET_VENDOR_MICROSEMI=3Dy=0D=0ACONFIG_NET_VENDOR_MICROSOFT=3Dy=0D=0AC=
ONFIG_NET_VENDOR_MYRI=3Dy=0D=0A#=20CONFIG_MYRI10GE=20is=20not=20set=0D=0A#=
=20CONFIG_FEALNX=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_NI=3Dy=0D=0A#=20CO=
NFIG_NI_XGE_MANAGEMENT_ENET=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_NATSEMI=
=3Dy=0D=0A#=20CONFIG_NATSEMI=20is=20not=20set=0D=0A#=20CONFIG_NS83820=20is=
=20not=20set=0D=0ACONFIG_NET_VENDOR_NETERION=3Dy=0D=0A#=20CONFIG_S2IO=20is=
=20not=20set=0D=0ACONFIG_NET_VENDOR_NETRONOME=3Dy=0D=0A#=20CONFIG_NFP=20is=
=20not=20set=0D=0ACONFIG_NET_VENDOR_8390=3Dy=0D=0A#=20CONFIG_PCMCIA_AXNET=
=20is=20not=20set=0D=0A#=20CONFIG_NE2K_PCI=20is=20not=20set=0D=0A#=20CONFIG=
_PCMCIA_PCNET=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_NVIDIA=3Dy=0D=0ACONFI=
G_FORCEDETH=3Dy=0D=0ACONFIG_NET_VENDOR_OKI=3Dy=0D=0A#=20CONFIG_ETHOC=20is=
=20not=20set=0D=0ACONFIG_NET_VENDOR_PACKET_ENGINES=3Dy=0D=0A#=20CONFIG_HAMA=
CHI=20is=20not=20set=0D=0A#=20CONFIG_YELLOWFIN=20is=20not=20set=0D=0ACONFIG=
_NET_VENDOR_PENSANDO=3Dy=0D=0A#=20CONFIG_IONIC=20is=20not=20set=0D=0ACONFIG=
_NET_VENDOR_QLOGIC=3Dy=0D=0A#=20CONFIG_QLA3XXX=20is=20not=20set=0D=0A#=20CO=
NFIG_QLCNIC=20is=20not=20set=0D=0A#=20CONFIG_NETXEN_NIC=20is=20not=20set=0D=
=0A#=20CONFIG_QED=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_BROCADE=3Dy=0D=0A=
#=20CONFIG_BNA=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_QUALCOMM=3Dy=0D=0A#=
=20CONFIG_QCA7000_SPI=20is=20not=20set=0D=0A#=20CONFIG_QCA7000_UART=20is=20=
not=20set=0D=0A#=20CONFIG_QCOM_EMAC=20is=20not=20set=0D=0A#=20CONFIG_RMNET=
=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_RDC=3Dy=0D=0A#=20CONFIG_R6040=20is=
=20not=20set=0D=0ACONFIG_NET_VENDOR_REALTEK=3Dy=0D=0A#=20CONFIG_ATP=20is=20=
not=20set=0D=0A#=20CONFIG_8139CP=20is=20not=20set=0D=0ACONFIG_8139TOO=3Dy=
=0D=0ACONFIG_8139TOO_PIO=3Dy=0D=0A#=20CONFIG_8139TOO_TUNE_TWISTER=20is=20no=
t=20set=0D=0A#=20CONFIG_8139TOO_8129=20is=20not=20set=0D=0A#=20CONFIG_8139_=
OLD_RX_RESET=20is=20not=20set=0D=0ACONFIG_R8169=3Dy=0D=0A#=20CONFIG_RTASE=
=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_RENESAS=3Dy=0D=0ACONFIG_NET_VENDOR=
_ROCKER=3Dy=0D=0ACONFIG_NET_VENDOR_SAMSUNG=3Dy=0D=0A#=20CONFIG_SXGBE_ETH=20=
is=20not=20set=0D=0ACONFIG_NET_VENDOR_SEEQ=3Dy=0D=0ACONFIG_NET_VENDOR_SILAN=
=3Dy=0D=0A#=20CONFIG_SC92031=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_SIS=3D=
y=0D=0A#=20CONFIG_SIS900=20is=20not=20set=0D=0A#=20CONFIG_SIS190=20is=20not=
=20set=0D=0ACONFIG_NET_VENDOR_SOLARFLARE=3Dy=0D=0A#=20CONFIG_SFC=20is=20not=
=20set=0D=0A#=20CONFIG_SFC_FALCON=20is=20not=20set=0D=0A#=20CONFIG_SFC_SIEN=
A=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_SMSC=3Dy=0D=0A#=20CONFIG_PCMCIA_S=
MC91C92=20is=20not=20set=0D=0A#=20CONFIG_EPIC100=20is=20not=20set=0D=0A#=20=
CONFIG_SMSC911X=20is=20not=20set=0D=0A#=20CONFIG_SMSC9420=20is=20not=20set=
=0D=0ACONFIG_NET_VENDOR_SOCIONEXT=3Dy=0D=0ACONFIG_NET_VENDOR_STMICRO=3Dy=0D=
=0A#=20CONFIG_STMMAC_ETH=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_SUN=3Dy=0D=
=0A#=20CONFIG_HAPPYMEAL=20is=20not=20set=0D=0A#=20CONFIG_SUNGEM=20is=20not=
=20set=0D=0A#=20CONFIG_CASSINI=20is=20not=20set=0D=0A#=20CONFIG_NIU=20is=20=
not=20set=0D=0ACONFIG_NET_VENDOR_SYNOPSYS=3Dy=0D=0A#=20CONFIG_DWC_XLGMAC=20=
is=20not=20set=0D=0ACONFIG_NET_VENDOR_TEHUTI=3Dy=0D=0A#=20CONFIG_TEHUTI=20i=
s=20not=20set=0D=0A#=20CONFIG_TEHUTI_TN40=20is=20not=20set=0D=0ACONFIG_NET_=
VENDOR_TI=3Dy=0D=0A#=20CONFIG_TI_CPSW_PHY_SEL=20is=20not=20set=0D=0A#=20CON=
FIG_TLAN=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_VERTEXCOM=3Dy=0D=0A#=20CON=
FIG_MSE102X=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_VIA=3Dy=0D=0A#=20CONFIG=
_VIA_RHINE=20is=20not=20set=0D=0A#=20CONFIG_VIA_VELOCITY=20is=20not=20set=
=0D=0ACONFIG_NET_VENDOR_WANGXUN=3Dy=0D=0A#=20CONFIG_NGBE=20is=20not=20set=
=0D=0A#=20CONFIG_TXGBE=20is=20not=20set=0D=0A#=20CONFIG_TXGBEVF=20is=20not=
=20set=0D=0A#=20CONFIG_NGBEVF=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_WIZNE=
T=3Dy=0D=0A#=20CONFIG_WIZNET_W5100=20is=20not=20set=0D=0A#=20CONFIG_WIZNET_=
W5300=20is=20not=20set=0D=0ACONFIG_NET_VENDOR_XILINX=3Dy=0D=0A#=20CONFIG_XI=
LINX_EMACLITE=20is=20not=20set=0D=0A#=20CONFIG_XILINX_LL_TEMAC=20is=20not=
=20set=0D=0ACONFIG_NET_VENDOR_XIRCOM=3Dy=0D=0A#=20CONFIG_PCMCIA_XIRC2PS=20i=
s=20not=20set=0D=0A#=20CONFIG_FDDI=20is=20not=20set=0D=0A#=20CONFIG_HIPPI=
=20is=20not=20set=0D=0ACONFIG_MDIO_BUS=3Dy=0D=0ACONFIG_PHYLINK=3Dy=0D=0ACON=
FIG_PHYLIB=3Dy=0D=0ACONFIG_SWPHY=3Dy=0D=0A#=20CONFIG_LED_TRIGGER_PHY=20is=
=20not=20set=0D=0ACONFIG_PHYLIB_LEDS=3Dy=0D=0ACONFIG_FIXED_PHY=3Dy=0D=0A#=
=20CONFIG_SFP=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20MII=20PHY=20device=20d=
rivers=0D=0A#=0D=0A#=20CONFIG_AS21XXX_PHY=20is=20not=20set=0D=0A#=20CONFIG_=
AIR_EN8811H_PHY=20is=20not=20set=0D=0A#=20CONFIG_AMD_PHY=20is=20not=20set=
=0D=0A#=20CONFIG_ADIN_PHY=20is=20not=20set=0D=0A#=20CONFIG_ADIN1100_PHY=20i=
s=20not=20set=0D=0A#=20CONFIG_AQUANTIA_PHY=20is=20not=20set=0D=0ACONFIG_AX8=
8796B_PHY=3Dy=0D=0A#=20CONFIG_BROADCOM_PHY=20is=20not=20set=0D=0A#=20CONFIG=
_BCM54140_PHY=20is=20not=20set=0D=0A#=20CONFIG_BCM7XXX_PHY=20is=20not=20set=
=0D=0A#=20CONFIG_BCM84881_PHY=20is=20not=20set=0D=0A#=20CONFIG_BCM87XX_PHY=
=20is=20not=20set=0D=0A#=20CONFIG_CICADA_PHY=20is=20not=20set=0D=0A#=20CONF=
IG_CORTINA_PHY=20is=20not=20set=0D=0A#=20CONFIG_DAVICOM_PHY=20is=20not=20se=
t=0D=0A#=20CONFIG_ICPLUS_PHY=20is=20not=20set=0D=0A#=20CONFIG_LXT_PHY=20is=
=20not=20set=0D=0A#=20CONFIG_INTEL_XWAY_PHY=20is=20not=20set=0D=0A#=20CONFI=
G_LSI_ET1011C_PHY=20is=20not=20set=0D=0A#=20CONFIG_MARVELL_PHY=20is=20not=
=20set=0D=0A#=20CONFIG_MARVELL_10G_PHY=20is=20not=20set=0D=0A#=20CONFIG_MAR=
VELL_88Q2XXX_PHY=20is=20not=20set=0D=0A#=20CONFIG_MARVELL_88X2222_PHY=20is=
=20not=20set=0D=0A#=20CONFIG_MAXLINEAR_GPHY=20is=20not=20set=0D=0A#=20CONFI=
G_MAXLINEAR_86110_PHY=20is=20not=20set=0D=0A#=20CONFIG_MEDIATEK_GE_PHY=20is=
=20not=20set=0D=0A#=20CONFIG_MICREL_PHY=20is=20not=20set=0D=0A#=20CONFIG_MI=
CROCHIP_T1S_PHY=20is=20not=20set=0D=0ACONFIG_MICROCHIP_PHY=3Dy=0D=0A#=20CON=
FIG_MICROCHIP_T1_PHY=20is=20not=20set=0D=0A#=20CONFIG_MICROSEMI_PHY=20is=20=
not=20set=0D=0A#=20CONFIG_MOTORCOMM_PHY=20is=20not=20set=0D=0A#=20CONFIG_NA=
TIONAL_PHY=20is=20not=20set=0D=0A#=20CONFIG_NXP_CBTX_PHY=20is=20not=20set=
=0D=0A#=20CONFIG_NXP_C45_TJA11XX_PHY=20is=20not=20set=0D=0A#=20CONFIG_NXP_T=
JA11XX_PHY=20is=20not=20set=0D=0A#=20CONFIG_NCN26000_PHY=20is=20not=20set=
=0D=0A#=20CONFIG_AT803X_PHY=20is=20not=20set=0D=0A#=20CONFIG_QCA83XX_PHY=20=
is=20not=20set=0D=0A#=20CONFIG_QCA808X_PHY=20is=20not=20set=0D=0A#=20CONFIG=
_QCA807X_PHY=20is=20not=20set=0D=0A#=20CONFIG_QSEMI_PHY=20is=20not=20set=0D=
=0ACONFIG_REALTEK_PHY=3Dy=0D=0A#=20CONFIG_REALTEK_PHY_HWMON=20is=20not=20se=
t=0D=0A#=20CONFIG_RENESAS_PHY=20is=20not=20set=0D=0A#=20CONFIG_ROCKCHIP_PHY=
=20is=20not=20set=0D=0ACONFIG_SMSC_PHY=3Dy=0D=0A#=20CONFIG_STE10XP=20is=20n=
ot=20set=0D=0A#=20CONFIG_TERANETICS_PHY=20is=20not=20set=0D=0A#=20CONFIG_DP=
83822_PHY=20is=20not=20set=0D=0A#=20CONFIG_DP83TC811_PHY=20is=20not=20set=
=0D=0A#=20CONFIG_DP83848_PHY=20is=20not=20set=0D=0A#=20CONFIG_DP83867_PHY=
=20is=20not=20set=0D=0A#=20CONFIG_DP83869_PHY=20is=20not=20set=0D=0A#=20CON=
FIG_DP83TD510_PHY=20is=20not=20set=0D=0A#=20CONFIG_DP83TG720_PHY=20is=20not=
=20set=0D=0A#=20CONFIG_VITESSE_PHY=20is=20not=20set=0D=0A#=20CONFIG_XILINX_=
GMII2RGMII=20is=20not=20set=0D=0A#=20CONFIG_PSE_CONTROLLER=20is=20not=20set=
=0D=0ACONFIG_CAN_DEV=3Dy=0D=0A#=20CONFIG_CAN_VCAN=20is=20not=20set=0D=0A#=
=20CONFIG_CAN_VXCAN=20is=20not=20set=0D=0ACONFIG_CAN_NETLINK=3Dy=0D=0A#=20C=
ONFIG_CAN_CALC_BITTIMING=20is=20not=20set=0D=0ACONFIG_CAN_RX_OFFLOAD=3Dy=0D=
=0A#=20CONFIG_CAN_CAN327=20is=20not=20set=0D=0A#=20CONFIG_CAN_FLEXCAN=20is=
=20not=20set=0D=0A#=20CONFIG_CAN_GRCAN=20is=20not=20set=0D=0A#=20CONFIG_CAN=
_KVASER_PCIEFD=20is=20not=20set=0D=0A#=20CONFIG_CAN_SLCAN=20is=20not=20set=
=0D=0A#=20CONFIG_CAN_C_CAN=20is=20not=20set=0D=0A#=20CONFIG_CAN_CC770=20is=
=20not=20set=0D=0A#=20CONFIG_CAN_CTUCANFD_PCI=20is=20not=20set=0D=0A#=20CON=
FIG_CAN_CTUCANFD_PLATFORM=20is=20not=20set=0D=0A#=20CONFIG_CAN_ESD_402_PCI=
=20is=20not=20set=0D=0A#=20CONFIG_CAN_IFI_CANFD=20is=20not=20set=0D=0A#=20C=
ONFIG_CAN_M_CAN=20is=20not=20set=0D=0A#=20CONFIG_CAN_PEAK_PCIEFD=20is=20not=
=20set=0D=0A#=20CONFIG_CAN_SJA1000=20is=20not=20set=0D=0A#=20CONFIG_CAN_SOF=
TING=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20CAN=20SPI=20interfaces=0D=0A#=
=0D=0A#=20CONFIG_CAN_HI311X=20is=20not=20set=0D=0A#=20CONFIG_CAN_MCP251X=20=
is=20not=20set=0D=0A#=20CONFIG_CAN_MCP251XFD=20is=20not=20set=0D=0A#=20end=
=20of=20CAN=20SPI=20interfaces=0D=0A=0D=0A#=0D=0A#=20CAN=20USB=20interfaces=
=0D=0A#=0D=0ACONFIG_CAN_8DEV_USB=3Dy=0D=0ACONFIG_CAN_EMS_USB=3Dy=0D=0ACONFI=
G_CAN_ESD_USB=3Dy=0D=0ACONFIG_CAN_ETAS_ES58X=3Dy=0D=0ACONFIG_CAN_F81604=3Dy=
=0D=0ACONFIG_CAN_GS_USB=3Dy=0D=0ACONFIG_CAN_KVASER_USB=3Dy=0D=0ACONFIG_CAN_=
MCBA_USB=3Dy=0D=0ACONFIG_CAN_PEAK_USB=3Dy=0D=0ACONFIG_CAN_UCAN=3Dy=0D=0A#=
=20end=20of=20CAN=20USB=20interfaces=0D=0A=0D=0A#=20CONFIG_CAN_DEBUG_DEVICE=
S=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20MCTP=20Device=20Drivers=0D=0A#=0D=
=0A#=20CONFIG_MCTP_SERIAL=20is=20not=20set=0D=0A#=20CONFIG_MCTP_TRANSPORT_U=
SB=20is=20not=20set=0D=0A#=20end=20of=20MCTP=20Device=20Drivers=0D=0A=0D=0A=
CONFIG_FWNODE_MDIO=3Dy=0D=0ACONFIG_OF_MDIO=3Dy=0D=0ACONFIG_ACPI_MDIO=3Dy=0D=
=0A#=20CONFIG_MDIO_BITBANG=20is=20not=20set=0D=0A#=20CONFIG_MDIO_BCM_UNIMAC=
=20is=20not=20set=0D=0A#=20CONFIG_MDIO_HISI_FEMAC=20is=20not=20set=0D=0ACON=
FIG_MDIO_MVUSB=3Dy=0D=0A#=20CONFIG_MDIO_MSCC_MIIM=20is=20not=20set=0D=0A#=
=20CONFIG_MDIO_OCTEON=20is=20not=20set=0D=0A#=20CONFIG_MDIO_IPQ4019=20is=20=
not=20set=0D=0A#=20CONFIG_MDIO_IPQ8064=20is=20not=20set=0D=0A#=20CONFIG_MDI=
O_THUNDER=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20MDIO=20Multiplexers=0D=0A#=
=0D=0A#=20CONFIG_MDIO_BUS_MUX_GPIO=20is=20not=20set=0D=0A#=20CONFIG_MDIO_BU=
S_MUX_MULTIPLEXER=20is=20not=20set=0D=0A#=20CONFIG_MDIO_BUS_MUX_MMIOREG=20i=
s=20not=20set=0D=0A=0D=0A#=0D=0A#=20PCS=20device=20drivers=0D=0A#=0D=0A#=20=
CONFIG_PCS_XPCS=20is=20not=20set=0D=0A#=20end=20of=20PCS=20device=20drivers=
=0D=0A=0D=0A#=20CONFIG_PLIP=20is=20not=20set=0D=0A#=20CONFIG_PPP=20is=20not=
=20set=0D=0A#=20CONFIG_SLIP=20is=20not=20set=0D=0ACONFIG_USB_NET_DRIVERS=3D=
y=0D=0ACONFIG_USB_CATC=3Dy=0D=0ACONFIG_USB_KAWETH=3Dy=0D=0ACONFIG_USB_PEGAS=
US=3Dy=0D=0ACONFIG_USB_RTL8150=3Dy=0D=0ACONFIG_USB_RTL8152=3Dy=0D=0ACONFIG_=
USB_LAN78XX=3Dy=0D=0ACONFIG_USB_USBNET=3Dy=0D=0ACONFIG_USB_NET_AX8817X=3Dy=
=0D=0ACONFIG_USB_NET_AX88179_178A=3Dy=0D=0ACONFIG_USB_NET_CDCETHER=3Dy=0D=
=0ACONFIG_USB_NET_CDC_EEM=3Dy=0D=0ACONFIG_USB_NET_CDC_NCM=3Dy=0D=0ACONFIG_U=
SB_NET_HUAWEI_CDC_NCM=3Dy=0D=0ACONFIG_USB_NET_CDC_MBIM=3Dy=0D=0ACONFIG_USB_=
NET_DM9601=3Dy=0D=0ACONFIG_USB_NET_SR9700=3Dy=0D=0ACONFIG_USB_NET_SR9800=3D=
y=0D=0ACONFIG_USB_NET_SMSC75XX=3Dy=0D=0ACONFIG_USB_NET_SMSC95XX=3Dy=0D=0ACO=
NFIG_USB_NET_GL620A=3Dy=0D=0ACONFIG_USB_NET_NET1080=3Dy=0D=0ACONFIG_USB_NET=
_PLUSB=3Dy=0D=0ACONFIG_USB_NET_MCS7830=3Dy=0D=0ACONFIG_USB_NET_RNDIS_HOST=
=3Dy=0D=0ACONFIG_USB_NET_CDC_SUBSET_ENABLE=3Dy=0D=0ACONFIG_USB_NET_CDC_SUBS=
ET=3Dy=0D=0ACONFIG_USB_ALI_M5632=3Dy=0D=0ACONFIG_USB_AN2720=3Dy=0D=0ACONFIG=
_USB_BELKIN=3Dy=0D=0ACONFIG_USB_ARMLINUX=3Dy=0D=0ACONFIG_USB_EPSON2888=3Dy=
=0D=0ACONFIG_USB_KC2190=3Dy=0D=0ACONFIG_USB_NET_ZAURUS=3Dy=0D=0ACONFIG_USB_=
NET_CX82310_ETH=3Dy=0D=0ACONFIG_USB_NET_KALMIA=3Dy=0D=0ACONFIG_USB_NET_QMI_=
WWAN=3Dy=0D=0ACONFIG_USB_HSO=3Dy=0D=0ACONFIG_USB_NET_INT51X1=3Dy=0D=0ACONFI=
G_USB_CDC_PHONET=3Dy=0D=0ACONFIG_USB_IPHETH=3Dy=0D=0ACONFIG_USB_SIERRA_NET=
=3Dy=0D=0ACONFIG_USB_VL600=3Dy=0D=0ACONFIG_USB_NET_CH9200=3Dy=0D=0ACONFIG_U=
SB_NET_AQC111=3Dy=0D=0ACONFIG_USB_RTL8153_ECM=3Dy=0D=0ACONFIG_WLAN=3Dy=0D=
=0ACONFIG_WLAN_VENDOR_ADMTEK=3Dy=0D=0A#=20CONFIG_ADM8211=20is=20not=20set=
=0D=0ACONFIG_ATH_COMMON=3Dy=0D=0ACONFIG_WLAN_VENDOR_ATH=3Dy=0D=0A#=20CONFIG=
_ATH_DEBUG=20is=20not=20set=0D=0A#=20CONFIG_ATH5K=20is=20not=20set=0D=0A#=
=20CONFIG_ATH5K_PCI=20is=20not=20set=0D=0ACONFIG_ATH9K_HW=3Dy=0D=0ACONFIG_A=
TH9K_COMMON=3Dy=0D=0ACONFIG_ATH9K_COMMON_DEBUG=3Dy=0D=0ACONFIG_ATH9K_BTCOEX=
_SUPPORT=3Dy=0D=0ACONFIG_ATH9K=3Dy=0D=0A#=20CONFIG_ATH9K_PCI=20is=20not=20s=
et=0D=0A#=20CONFIG_ATH9K_AHB=20is=20not=20set=0D=0ACONFIG_ATH9K_DEBUGFS=3Dy=
=0D=0A#=20CONFIG_ATH9K_STATION_STATISTICS=20is=20not=20set=0D=0A#=20CONFIG_=
ATH9K_DYNACK=20is=20not=20set=0D=0A#=20CONFIG_ATH9K_WOW=20is=20not=20set=0D=
=0A#=20CONFIG_ATH9K_RFKILL=20is=20not=20set=0D=0A#=20CONFIG_ATH9K_CHANNEL_C=
ONTEXT=20is=20not=20set=0D=0A#=20CONFIG_ATH9K_PCOEM=20is=20not=20set=0D=0AC=
ONFIG_ATH9K_HTC=3Dy=0D=0ACONFIG_ATH9K_HTC_DEBUGFS=3Dy=0D=0A#=20CONFIG_ATH9K=
_HWRNG=20is=20not=20set=0D=0ACONFIG_ATH9K_COMMON_SPECTRAL=3Dy=0D=0ACONFIG_C=
ARL9170=3Dy=0D=0ACONFIG_CARL9170_LEDS=3Dy=0D=0A#=20CONFIG_CARL9170_DEBUGFS=
=20is=20not=20set=0D=0ACONFIG_CARL9170_WPC=3Dy=0D=0ACONFIG_CARL9170_HWRNG=
=3Dy=0D=0ACONFIG_ATH6KL=3Dy=0D=0A#=20CONFIG_ATH6KL_SDIO=20is=20not=20set=0D=
=0ACONFIG_ATH6KL_USB=3Dy=0D=0A#=20CONFIG_ATH6KL_DEBUG=20is=20not=20set=0D=
=0A#=20CONFIG_ATH6KL_TRACING=20is=20not=20set=0D=0ACONFIG_AR5523=3Dy=0D=0A#=
=20CONFIG_WIL6210=20is=20not=20set=0D=0ACONFIG_ATH10K=3Dy=0D=0ACONFIG_ATH10=
K_CE=3Dy=0D=0A#=20CONFIG_ATH10K_PCI=20is=20not=20set=0D=0A#=20CONFIG_ATH10K=
_SDIO=20is=20not=20set=0D=0ACONFIG_ATH10K_USB=3Dy=0D=0A#=20CONFIG_ATH10K_DE=
BUG=20is=20not=20set=0D=0A#=20CONFIG_ATH10K_DEBUGFS=20is=20not=20set=0D=0AC=
ONFIG_ATH10K_LEDS=3Dy=0D=0A#=20CONFIG_ATH10K_TRACING=20is=20not=20set=0D=0A=
#=20CONFIG_WCN36XX=20is=20not=20set=0D=0A#=20CONFIG_ATH11K=20is=20not=20set=
=0D=0A#=20CONFIG_ATH12K=20is=20not=20set=0D=0ACONFIG_WLAN_VENDOR_ATMEL=3Dy=
=0D=0ACONFIG_AT76C50X_USB=3Dy=0D=0ACONFIG_WLAN_VENDOR_BROADCOM=3Dy=0D=0A#=
=20CONFIG_B43=20is=20not=20set=0D=0A#=20CONFIG_B43LEGACY=20is=20not=20set=
=0D=0ACONFIG_BRCMUTIL=3Dy=0D=0A#=20CONFIG_BRCMSMAC=20is=20not=20set=0D=0ACO=
NFIG_BRCMFMAC=3Dy=0D=0ACONFIG_BRCMFMAC_PROTO_BCDC=3Dy=0D=0A#=20CONFIG_BRCMF=
MAC_SDIO=20is=20not=20set=0D=0ACONFIG_BRCMFMAC_USB=3Dy=0D=0A#=20CONFIG_BRCM=
FMAC_PCIE=20is=20not=20set=0D=0A#=20CONFIG_BRCM_TRACING=20is=20not=20set=0D=
=0A#=20CONFIG_BRCMDBG=20is=20not=20set=0D=0ACONFIG_WLAN_VENDOR_INTEL=3Dy=0D=
=0A#=20CONFIG_IPW2100=20is=20not=20set=0D=0A#=20CONFIG_IPW2200=20is=20not=
=20set=0D=0A#=20CONFIG_IWL4965=20is=20not=20set=0D=0A#=20CONFIG_IWL3945=20i=
s=20not=20set=0D=0A#=20CONFIG_IWLWIFI=20is=20not=20set=0D=0ACONFIG_WLAN_VEN=
DOR_INTERSIL=3Dy=0D=0ACONFIG_P54_COMMON=3Dy=0D=0ACONFIG_P54_USB=3Dy=0D=0A#=
=20CONFIG_P54_PCI=20is=20not=20set=0D=0A#=20CONFIG_P54_SPI=20is=20not=20set=
=0D=0ACONFIG_P54_LEDS=3Dy=0D=0ACONFIG_WLAN_VENDOR_MARVELL=3Dy=0D=0ACONFIG_L=
IBERTAS=3Dy=0D=0ACONFIG_LIBERTAS_USB=3Dy=0D=0ACONFIG_LIBERTAS_SDIO=3Dy=0D=
=0ACONFIG_LIBERTAS_SPI=3Dy=0D=0A#=20CONFIG_LIBERTAS_DEBUG=20is=20not=20set=
=0D=0ACONFIG_LIBERTAS_MESH=3Dy=0D=0ACONFIG_LIBERTAS_THINFIRM=3Dy=0D=0A#=20C=
ONFIG_LIBERTAS_THINFIRM_DEBUG=20is=20not=20set=0D=0ACONFIG_LIBERTAS_THINFIR=
M_USB=3Dy=0D=0ACONFIG_MWIFIEX=3Dy=0D=0A#=20CONFIG_MWIFIEX_SDIO=20is=20not=
=20set=0D=0A#=20CONFIG_MWIFIEX_PCIE=20is=20not=20set=0D=0ACONFIG_MWIFIEX_US=
B=3Dy=0D=0A#=20CONFIG_MWL8K=20is=20not=20set=0D=0ACONFIG_WLAN_VENDOR_MEDIAT=
EK=3Dy=0D=0ACONFIG_MT7601U=3Dy=0D=0ACONFIG_MT76_CORE=3Dy=0D=0ACONFIG_MT76_L=
EDS=3Dy=0D=0ACONFIG_MT76_USB=3Dy=0D=0ACONFIG_MT76x02_LIB=3Dy=0D=0ACONFIG_MT=
76x02_USB=3Dy=0D=0ACONFIG_MT76_CONNAC_LIB=3Dy=0D=0ACONFIG_MT792x_LIB=3Dy=0D=
=0ACONFIG_MT792x_USB=3Dy=0D=0ACONFIG_MT76x0_COMMON=3Dy=0D=0ACONFIG_MT76x0U=
=3Dy=0D=0A#=20CONFIG_MT76x0E=20is=20not=20set=0D=0ACONFIG_MT76x2_COMMON=3Dy=
=0D=0A#=20CONFIG_MT76x2E=20is=20not=20set=0D=0ACONFIG_MT76x2U=3Dy=0D=0A#=20=
CONFIG_MT7603E=20is=20not=20set=0D=0ACONFIG_MT7615_COMMON=3Dy=0D=0A#=20CONF=
IG_MT7615E=20is=20not=20set=0D=0ACONFIG_MT7663_USB_SDIO_COMMON=3Dy=0D=0ACON=
FIG_MT7663U=3Dy=0D=0A#=20CONFIG_MT7663S=20is=20not=20set=0D=0A#=20CONFIG_MT=
7915E=20is=20not=20set=0D=0ACONFIG_MT7921_COMMON=3Dy=0D=0A#=20CONFIG_MT7921=
E=20is=20not=20set=0D=0A#=20CONFIG_MT7921S=20is=20not=20set=0D=0ACONFIG_MT7=
921U=3Dy=0D=0A#=20CONFIG_MT7996E=20is=20not=20set=0D=0ACONFIG_MT7925_COMMON=
=3Dy=0D=0A#=20CONFIG_MT7925E=20is=20not=20set=0D=0ACONFIG_MT7925U=3Dy=0D=0A=
CONFIG_WLAN_VENDOR_MICROCHIP=3Dy=0D=0ACONFIG_WILC1000=3Dy=0D=0ACONFIG_WILC1=
000_SDIO=3Dy=0D=0A#=20CONFIG_WILC1000_SPI=20is=20not=20set=0D=0A#=20CONFIG_=
WILC1000_HW_OOB_INTR=20is=20not=20set=0D=0ACONFIG_WLAN_VENDOR_PURELIFI=3Dy=
=0D=0ACONFIG_PLFXLC=3Dy=0D=0ACONFIG_WLAN_VENDOR_RALINK=3Dy=0D=0ACONFIG_RT2X=
00=3Dy=0D=0A#=20CONFIG_RT2400PCI=20is=20not=20set=0D=0A#=20CONFIG_RT2500PCI=
=20is=20not=20set=0D=0A#=20CONFIG_RT61PCI=20is=20not=20set=0D=0A#=20CONFIG_=
RT2800PCI=20is=20not=20set=0D=0ACONFIG_RT2500USB=3Dy=0D=0ACONFIG_RT73USB=3D=
y=0D=0ACONFIG_RT2800USB=3Dy=0D=0ACONFIG_RT2800USB_RT33XX=3Dy=0D=0ACONFIG_RT=
2800USB_RT35XX=3Dy=0D=0ACONFIG_RT2800USB_RT3573=3Dy=0D=0ACONFIG_RT2800USB_R=
T53XX=3Dy=0D=0ACONFIG_RT2800USB_RT55XX=3Dy=0D=0ACONFIG_RT2800USB_UNKNOWN=3D=
y=0D=0ACONFIG_RT2800_LIB=3Dy=0D=0ACONFIG_RT2X00_LIB_USB=3Dy=0D=0ACONFIG_RT2=
X00_LIB=3Dy=0D=0ACONFIG_RT2X00_LIB_FIRMWARE=3Dy=0D=0ACONFIG_RT2X00_LIB_CRYP=
TO=3Dy=0D=0ACONFIG_RT2X00_LIB_LEDS=3Dy=0D=0A#=20CONFIG_RT2X00_LIB_DEBUGFS=
=20is=20not=20set=0D=0A#=20CONFIG_RT2X00_DEBUG=20is=20not=20set=0D=0ACONFIG=
_WLAN_VENDOR_REALTEK=3Dy=0D=0A#=20CONFIG_RTL8180=20is=20not=20set=0D=0ACONF=
IG_RTL8187=3Dy=0D=0ACONFIG_RTL8187_LEDS=3Dy=0D=0ACONFIG_RTL_CARDS=3Dy=0D=0A=
CONFIG_RTL8192CE=3Dy=0D=0ACONFIG_RTL8192SE=3Dy=0D=0ACONFIG_RTL8192DE=3Dy=0D=
=0ACONFIG_RTL8723AE=3Dy=0D=0ACONFIG_RTL8723BE=3Dy=0D=0ACONFIG_RTL8188EE=3Dy=
=0D=0ACONFIG_RTL8192EE=3Dy=0D=0ACONFIG_RTL8821AE=3Dy=0D=0ACONFIG_RTL8192CU=
=3Dy=0D=0A#=20CONFIG_RTL8192DU=20is=20not=20set=0D=0ACONFIG_RTLWIFI=3Dy=0D=
=0ACONFIG_RTLWIFI_PCI=3Dy=0D=0ACONFIG_RTLWIFI_USB=3Dy=0D=0A#=20CONFIG_RTLWI=
FI_DEBUG=20is=20not=20set=0D=0ACONFIG_RTL8192C_COMMON=3Dy=0D=0ACONFIG_RTL81=
92D_COMMON=3Dy=0D=0ACONFIG_RTL8723_COMMON=3Dy=0D=0ACONFIG_RTLBTCOEXIST=3Dy=
=0D=0ACONFIG_RTL8XXXU=3Dy=0D=0ACONFIG_RTL8XXXU_UNTESTED=3Dy=0D=0ACONFIG_RTW=
88=3Dy=0D=0ACONFIG_RTW88_CORE=3Dy=0D=0ACONFIG_RTW88_USB=3Dy=0D=0ACONFIG_RTW=
88_8822B=3Dy=0D=0ACONFIG_RTW88_8822C=3Dy=0D=0ACONFIG_RTW88_8723X=3Dy=0D=0AC=
ONFIG_RTW88_8723D=3Dy=0D=0ACONFIG_RTW88_8821C=3Dy=0D=0A#=20CONFIG_RTW88_882=
2BE=20is=20not=20set=0D=0A#=20CONFIG_RTW88_8822BS=20is=20not=20set=0D=0ACON=
FIG_RTW88_8822BU=3Dy=0D=0A#=20CONFIG_RTW88_8822CE=20is=20not=20set=0D=0A#=
=20CONFIG_RTW88_8822CS=20is=20not=20set=0D=0ACONFIG_RTW88_8822CU=3Dy=0D=0A#=
=20CONFIG_RTW88_8723DE=20is=20not=20set=0D=0A#=20CONFIG_RTW88_8723DS=20is=
=20not=20set=0D=0A#=20CONFIG_RTW88_8723CS=20is=20not=20set=0D=0ACONFIG_RTW8=
8_8723DU=3Dy=0D=0A#=20CONFIG_RTW88_8821CE=20is=20not=20set=0D=0A#=20CONFIG_=
RTW88_8821CS=20is=20not=20set=0D=0ACONFIG_RTW88_8821CU=3Dy=0D=0A#=20CONFIG_=
RTW88_8821AU=20is=20not=20set=0D=0A#=20CONFIG_RTW88_8812AU=20is=20not=20set=
=0D=0A#=20CONFIG_RTW88_8814AE=20is=20not=20set=0D=0A#=20CONFIG_RTW88_8814AU=
=20is=20not=20set=0D=0A#=20CONFIG_RTW88_DEBUG=20is=20not=20set=0D=0A#=20CON=
FIG_RTW88_DEBUGFS=20is=20not=20set=0D=0ACONFIG_RTW88_LEDS=3Dy=0D=0ACONFIG_R=
TW89=3Dy=0D=0A#=20CONFIG_RTW89_8851BE=20is=20not=20set=0D=0A#=20CONFIG_RTW8=
9_8851BU=20is=20not=20set=0D=0A#=20CONFIG_RTW89_8852AE=20is=20not=20set=0D=
=0A#=20CONFIG_RTW89_8852BE=20is=20not=20set=0D=0A#=20CONFIG_RTW89_8852BU=20=
is=20not=20set=0D=0A#=20CONFIG_RTW89_8852BTE=20is=20not=20set=0D=0A#=20CONF=
IG_RTW89_8852CE=20is=20not=20set=0D=0A#=20CONFIG_RTW89_8922AE=20is=20not=20=
set=0D=0ACONFIG_WLAN_VENDOR_RSI=3Dy=0D=0ACONFIG_RSI_91X=3Dy=0D=0A#=20CONFIG=
_RSI_DEBUGFS=20is=20not=20set=0D=0A#=20CONFIG_RSI_SDIO=20is=20not=20set=0D=
=0ACONFIG_RSI_USB=3Dy=0D=0A#=20CONFIG_RSI_COEX=20is=20not=20set=0D=0ACONFIG=
_WLAN_VENDOR_SILABS=3Dy=0D=0A#=20CONFIG_WFX=20is=20not=20set=0D=0ACONFIG_WL=
AN_VENDOR_ST=3Dy=0D=0A#=20CONFIG_CW1200=20is=20not=20set=0D=0ACONFIG_WLAN_V=
ENDOR_TI=3Dy=0D=0A#=20CONFIG_WL1251=20is=20not=20set=0D=0A#=20CONFIG_WL12XX=
=20is=20not=20set=0D=0A#=20CONFIG_WL18XX=20is=20not=20set=0D=0A#=20CONFIG_W=
LCORE=20is=20not=20set=0D=0ACONFIG_WLAN_VENDOR_ZYDAS=3Dy=0D=0ACONFIG_ZD1211=
RW=3Dy=0D=0A#=20CONFIG_ZD1211RW_DEBUG=20is=20not=20set=0D=0ACONFIG_WLAN_VEN=
DOR_QUANTENNA=3Dy=0D=0A#=20CONFIG_QTNFMAC_PCIE=20is=20not=20set=0D=0A#=20CO=
NFIG_MAC80211_HWSIM=20is=20not=20set=0D=0A#=20CONFIG_VIRT_WIFI=20is=20not=
=20set=0D=0A#=20CONFIG_WAN=20is=20not=20set=0D=0ACONFIG_IEEE802154_DRIVERS=
=3Dy=0D=0A#=20CONFIG_IEEE802154_FAKELB=20is=20not=20set=0D=0A#=20CONFIG_IEE=
E802154_AT86RF230=20is=20not=20set=0D=0A#=20CONFIG_IEEE802154_MRF24J40=20is=
=20not=20set=0D=0A#=20CONFIG_IEEE802154_CC2520=20is=20not=20set=0D=0ACONFIG=
_IEEE802154_ATUSB=3Dy=0D=0A#=20CONFIG_IEEE802154_ADF7242=20is=20not=20set=
=0D=0A#=20CONFIG_IEEE802154_CA8210=20is=20not=20set=0D=0A#=20CONFIG_IEEE802=
154_MCR20A=20is=20not=20set=0D=0A#=20CONFIG_IEEE802154_HWSIM=20is=20not=20s=
et=0D=0A=0D=0A#=0D=0A#=20Wireless=20WAN=0D=0A#=0D=0A#=20CONFIG_WWAN=20is=20=
not=20set=0D=0A#=20end=20of=20Wireless=20WAN=0D=0A=0D=0A#=20CONFIG_VMXNET3=
=20is=20not=20set=0D=0A#=20CONFIG_FUJITSU_ES=20is=20not=20set=0D=0A#=20CONF=
IG_NETDEVSIM=20is=20not=20set=0D=0ACONFIG_NET_FAILOVER=3Dy=0D=0ACONFIG_ISDN=
=3Dy=0D=0ACONFIG_ISDN_CAPI=3Dy=0D=0ACONFIG_MISDN=3Dy=0D=0A#=20CONFIG_MISDN_=
DSP=20is=20not=20set=0D=0A#=20CONFIG_MISDN_L1OIP=20is=20not=20set=0D=0A=0D=
=0A#=0D=0A#=20mISDN=20hardware=20drivers=0D=0A#=0D=0A#=20CONFIG_MISDN_HFCPC=
I=20is=20not=20set=0D=0A#=20CONFIG_MISDN_HFCMULTI=20is=20not=20set=0D=0ACON=
FIG_MISDN_HFCUSB=3Dy=0D=0A#=20CONFIG_MISDN_AVMFRITZ=20is=20not=20set=0D=0A#=
=20CONFIG_MISDN_SPEEDFAX=20is=20not=20set=0D=0A#=20CONFIG_MISDN_INFINEON=20=
is=20not=20set=0D=0A#=20CONFIG_MISDN_W6692=20is=20not=20set=0D=0A#=20CONFIG=
_MISDN_NETJET=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Input=20device=20suppo=
rt=0D=0A#=0D=0ACONFIG_INPUT=3Dy=0D=0ACONFIG_INPUT_LEDS=3Dy=0D=0ACONFIG_INPU=
T_FF_MEMLESS=3Dy=0D=0ACONFIG_INPUT_SPARSEKMAP=3Dy=0D=0A#=20CONFIG_INPUT_MAT=
RIXKMAP=20is=20not=20set=0D=0ACONFIG_INPUT_VIVALDIFMAP=3Dy=0D=0A=0D=0A#=0D=
=0A#=20Userland=20interfaces=0D=0A#=0D=0A#=20CONFIG_INPUT_MOUSEDEV=20is=20n=
ot=20set=0D=0A#=20CONFIG_INPUT_JOYDEV=20is=20not=20set=0D=0ACONFIG_INPUT_EV=
DEV=3Dy=0D=0A=0D=0A#=0D=0A#=20Input=20Device=20Drivers=0D=0A#=0D=0ACONFIG_I=
NPUT_KEYBOARD=3Dy=0D=0A#=20CONFIG_KEYBOARD_ADC=20is=20not=20set=0D=0A#=20CO=
NFIG_KEYBOARD_ADP5588=20is=20not=20set=0D=0ACONFIG_KEYBOARD_ATKBD=3Dy=0D=0A=
#=20CONFIG_KEYBOARD_QT1050=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_QT1070=
=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_QT2160=20is=20not=20set=0D=0A#=
=20CONFIG_KEYBOARD_DLINK_DIR685=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_L=
KKBD=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_GPIO=20is=20not=20set=0D=0A#=
=20CONFIG_KEYBOARD_GPIO_POLLED=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_TC=
A8418=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_MATRIX=20is=20not=20set=0D=
=0A#=20CONFIG_KEYBOARD_LM8323=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_LM8=
333=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_MAX7359=20is=20not=20set=0D=
=0A#=20CONFIG_KEYBOARD_MPR121=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_NEW=
TON=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_OPENCORES=20is=20not=20set=0D=
=0A#=20CONFIG_KEYBOARD_PINEPHONE=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_=
SAMSUNG=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_STOWAWAY=20is=20not=20set=
=0D=0A#=20CONFIG_KEYBOARD_SUNKBD=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_=
OMAP4=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_TM2_TOUCHKEY=20is=20not=20s=
et=0D=0A#=20CONFIG_KEYBOARD_TWL4030=20is=20not=20set=0D=0A#=20CONFIG_KEYBOA=
RD_XTKBD=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_CROS_EC=20is=20not=20set=
=0D=0A#=20CONFIG_KEYBOARD_CAP11XX=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD=
_BCM=20is=20not=20set=0D=0A#=20CONFIG_KEYBOARD_CYPRESS_SF=20is=20not=20set=
=0D=0ACONFIG_INPUT_MOUSE=3Dy=0D=0ACONFIG_MOUSE_PS2=3Dy=0D=0ACONFIG_MOUSE_PS=
2_ALPS=3Dy=0D=0ACONFIG_MOUSE_PS2_BYD=3Dy=0D=0ACONFIG_MOUSE_PS2_LOGIPS2PP=3D=
y=0D=0ACONFIG_MOUSE_PS2_SYNAPTICS=3Dy=0D=0ACONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=
=3Dy=0D=0ACONFIG_MOUSE_PS2_CYPRESS=3Dy=0D=0ACONFIG_MOUSE_PS2_LIFEBOOK=3Dy=
=0D=0ACONFIG_MOUSE_PS2_TRACKPOINT=3Dy=0D=0A#=20CONFIG_MOUSE_PS2_ELANTECH=20=
is=20not=20set=0D=0A#=20CONFIG_MOUSE_PS2_SENTELIC=20is=20not=20set=0D=0A#=
=20CONFIG_MOUSE_PS2_TOUCHKIT=20is=20not=20set=0D=0ACONFIG_MOUSE_PS2_FOCALTE=
CH=3Dy=0D=0A#=20CONFIG_MOUSE_PS2_VMMOUSE=20is=20not=20set=0D=0ACONFIG_MOUSE=
_PS2_SMBUS=3Dy=0D=0A#=20CONFIG_MOUSE_SERIAL=20is=20not=20set=0D=0ACONFIG_MO=
USE_APPLETOUCH=3Dy=0D=0ACONFIG_MOUSE_BCM5974=3Dy=0D=0A#=20CONFIG_MOUSE_CYAP=
A=20is=20not=20set=0D=0A#=20CONFIG_MOUSE_ELAN_I2C=20is=20not=20set=0D=0A#=
=20CONFIG_MOUSE_VSXXXAA=20is=20not=20set=0D=0A#=20CONFIG_MOUSE_GPIO=20is=20=
not=20set=0D=0A#=20CONFIG_MOUSE_SYNAPTICS_I2C=20is=20not=20set=0D=0ACONFIG_=
MOUSE_SYNAPTICS_USB=3Dy=0D=0ACONFIG_INPUT_JOYSTICK=3Dy=0D=0A#=20CONFIG_JOYS=
TICK_ANALOG=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_A3D=20is=20not=20set=
=0D=0A#=20CONFIG_JOYSTICK_ADC=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_ADI=
=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_COBRA=20is=20not=20set=0D=0A#=20=
CONFIG_JOYSTICK_GF2K=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_GRIP=20is=20=
not=20set=0D=0A#=20CONFIG_JOYSTICK_GRIP_MP=20is=20not=20set=0D=0A#=20CONFIG=
_JOYSTICK_GUILLEMOT=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_INTERACT=20is=
=20not=20set=0D=0A#=20CONFIG_JOYSTICK_SIDEWINDER=20is=20not=20set=0D=0A#=20=
CONFIG_JOYSTICK_TMDC=20is=20not=20set=0D=0ACONFIG_JOYSTICK_IFORCE=3Dy=0D=0A=
CONFIG_JOYSTICK_IFORCE_USB=3Dy=0D=0A#=20CONFIG_JOYSTICK_IFORCE_232=20is=20n=
ot=20set=0D=0A#=20CONFIG_JOYSTICK_WARRIOR=20is=20not=20set=0D=0A#=20CONFIG_=
JOYSTICK_MAGELLAN=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_SPACEORB=20is=
=20not=20set=0D=0A#=20CONFIG_JOYSTICK_SPACEBALL=20is=20not=20set=0D=0A#=20C=
ONFIG_JOYSTICK_STINGER=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_TWIDJOY=20=
is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_ZHENHUA=20is=20not=20set=0D=0A#=20C=
ONFIG_JOYSTICK_DB9=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_GAMECON=20is=
=20not=20set=0D=0A#=20CONFIG_JOYSTICK_TURBOGRAFX=20is=20not=20set=0D=0A#=20=
CONFIG_JOYSTICK_AS5011=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_JOYDUMP=20=
is=20not=20set=0D=0ACONFIG_JOYSTICK_XPAD=3Dy=0D=0ACONFIG_JOYSTICK_XPAD_FF=
=3Dy=0D=0ACONFIG_JOYSTICK_XPAD_LEDS=3Dy=0D=0A#=20CONFIG_JOYSTICK_WALKERA070=
1=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_PSXPAD_SPI=20is=20not=20set=0D=
=0ACONFIG_JOYSTICK_PXRC=3Dy=0D=0A#=20CONFIG_JOYSTICK_QWIIC=20is=20not=20set=
=0D=0A#=20CONFIG_JOYSTICK_FSIA6B=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_=
SENSEHAT=20is=20not=20set=0D=0A#=20CONFIG_JOYSTICK_SEESAW=20is=20not=20set=
=0D=0ACONFIG_INPUT_TABLET=3Dy=0D=0ACONFIG_TABLET_USB_ACECAD=3Dy=0D=0ACONFIG=
_TABLET_USB_AIPTEK=3Dy=0D=0ACONFIG_TABLET_USB_HANWANG=3Dy=0D=0ACONFIG_TABLE=
T_USB_KBTAB=3Dy=0D=0ACONFIG_TABLET_USB_PEGASUS=3Dy=0D=0A#=20CONFIG_TABLET_S=
ERIAL_WACOM4=20is=20not=20set=0D=0ACONFIG_INPUT_TOUCHSCREEN=3Dy=0D=0A#=20CO=
NFIG_TOUCHSCREEN_ADS7846=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_AD787=
7=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_AD7879=20is=20not=20set=0D=
=0A#=20CONFIG_TOUCHSCREEN_ADC=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_=
AR1021_I2C=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_ATMEL_MXT=20is=20no=
t=20set=0D=0A#=20CONFIG_TOUCHSCREEN_AUO_PIXCIR=20is=20not=20set=0D=0A#=20CO=
NFIG_TOUCHSCREEN_BU21013=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_BU210=
29=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=20is=20not=
=20set=0D=0A#=20CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=20is=20not=20set=0D=0A#=
=20CONFIG_TOUCHSCREEN_CY8CTMA140=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCRE=
EN_CY8CTMG110=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_CYTTSP_CORE=20is=
=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_CYTTSP5=20is=20not=20set=0D=0A#=20=
CONFIG_TOUCHSCREEN_DYNAPRO=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_HAM=
PSHIRE=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_EETI=20is=20not=20set=
=0D=0A#=20CONFIG_TOUCHSCREEN_EGALAX=20is=20not=20set=0D=0A#=20CONFIG_TOUCHS=
CREEN_EGALAX_SERIAL=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_EXC3000=20=
is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_FUJITSU=20is=20not=20set=0D=0A#=
=20CONFIG_TOUCHSCREEN_GOODIX=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_G=
OODIX_BERLIN_I2C=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_GOODIX_BERLIN=
_SPI=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_HIDEEP=20is=20not=20set=
=0D=0A#=20CONFIG_TOUCHSCREEN_HIMAX_HX852X=20is=20not=20set=0D=0A#=20CONFIG_=
TOUCHSCREEN_HYCON_HY46XX=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_HYNIT=
RON_CSTXXX=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_HYNITRON_CST816X=20=
is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_ILI210X=20is=20not=20set=0D=0A#=
=20CONFIG_TOUCHSCREEN_ILITEK=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_S=
6SY761=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_GUNZE=20is=20not=20set=
=0D=0A#=20CONFIG_TOUCHSCREEN_EKTF2127=20is=20not=20set=0D=0A#=20CONFIG_TOUC=
HSCREEN_ELAN=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_ELO=20is=20not=20=
set=0D=0A#=20CONFIG_TOUCHSCREEN_WACOM_W8001=20is=20not=20set=0D=0A#=20CONFI=
G_TOUCHSCREEN_WACOM_I2C=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_MAX118=
01=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_MMS114=20is=20not=20set=0D=
=0A#=20CONFIG_TOUCHSCREEN_MELFAS_MIP4=20is=20not=20set=0D=0A#=20CONFIG_TOUC=
HSCREEN_MSG2638=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_MTOUCH=20is=20=
not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS=20is=20not=20set=0D=0A=
#=20CONFIG_TOUCHSCREEN_IMAGIS=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_=
IMX6UL_TSC=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_INEXIO=20is=20not=
=20set=0D=0A#=20CONFIG_TOUCHSCREEN_PENMOUNT=20is=20not=20set=0D=0A#=20CONFI=
G_TOUCHSCREEN_EDT_FT5X06=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_TOUCH=
RIGHT=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_TOUCHWIN=20is=20not=20se=
t=0D=0A#=20CONFIG_TOUCHSCREEN_PIXCIR=20is=20not=20set=0D=0A#=20CONFIG_TOUCH=
SCREEN_WDT87XX_I2C=20is=20not=20set=0D=0ACONFIG_TOUCHSCREEN_USB_COMPOSITE=
=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_EGALAX=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_PAN=
JIT=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_3M=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_ITM=
=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_ETURBO=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_GUN=
ZE=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy=0D=0ACONFIG_TOUCHSCREEN_US=
B_IRTOUCH=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy=0D=0ACONFIG_TOUCHSCR=
EEN_USB_GENERAL_TOUCH=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_GOTOP=3Dy=0D=0ACONFIG=
_TOUCHSCREEN_USB_JASTEC=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_ELO=3Dy=0D=0ACONFIG=
_TOUCHSCREEN_USB_E2I=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_ZYTRONIC=3Dy=0D=0ACONF=
IG_TOUCHSCREEN_USB_ETT_TC45USB=3Dy=0D=0ACONFIG_TOUCHSCREEN_USB_NEXIO=3Dy=0D=
=0ACONFIG_TOUCHSCREEN_USB_EASYTOUCH=3Dy=0D=0A#=20CONFIG_TOUCHSCREEN_TOUCHIT=
213=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_TSC_SERIO=20is=20not=20set=
=0D=0A#=20CONFIG_TOUCHSCREEN_TSC2004=20is=20not=20set=0D=0A#=20CONFIG_TOUCH=
SCREEN_TSC2005=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_TSC2007=20is=20=
not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_RM_TS=20is=20not=20set=0D=0A#=20CONFI=
G_TOUCHSCREEN_SILEAD=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_SIS_I2C=
=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_ST1232=20is=20not=20set=0D=0A=
#=20CONFIG_TOUCHSCREEN_STMFTS=20is=20not=20set=0D=0ACONFIG_TOUCHSCREEN_SUR4=
0=3Dy=0D=0A#=20CONFIG_TOUCHSCREEN_SURFACE3_SPI=20is=20not=20set=0D=0A#=20CO=
NFIG_TOUCHSCREEN_SX8654=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_TPS650=
7X=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_ZET6223=20is=20not=20set=0D=
=0A#=20CONFIG_TOUCHSCREEN_ZFORCE=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCRE=
EN_COLIBRI_VF50=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_ROHM_BU21023=
=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_IQS5XX=20is=20not=20set=0D=0A=
#=20CONFIG_TOUCHSCREEN_IQS7211=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN=
_ZINITIX=20is=20not=20set=0D=0A#=20CONFIG_TOUCHSCREEN_HIMAX_HX83112B=20is=
=20not=20set=0D=0ACONFIG_INPUT_MISC=3Dy=0D=0A#=20CONFIG_INPUT_AD714X=20is=
=20not=20set=0D=0A#=20CONFIG_INPUT_ATMEL_CAPTOUCH=20is=20not=20set=0D=0A#=
=20CONFIG_INPUT_AW86927=20is=20not=20set=0D=0A#=20CONFIG_INPUT_BMA150=20is=
=20not=20set=0D=0A#=20CONFIG_INPUT_E3X0_BUTTON=20is=20not=20set=0D=0A#=20CO=
NFIG_INPUT_PCSPKR=20is=20not=20set=0D=0A#=20CONFIG_INPUT_MMA8450=20is=20not=
=20set=0D=0A#=20CONFIG_INPUT_APANEL=20is=20not=20set=0D=0A#=20CONFIG_INPUT_=
GPIO_BEEPER=20is=20not=20set=0D=0A#=20CONFIG_INPUT_GPIO_DECODER=20is=20not=
=20set=0D=0A#=20CONFIG_INPUT_GPIO_VIBRA=20is=20not=20set=0D=0A#=20CONFIG_IN=
PUT_ATLAS_BTNS=20is=20not=20set=0D=0ACONFIG_INPUT_ATI_REMOTE2=3Dy=0D=0ACONF=
IG_INPUT_KEYSPAN_REMOTE=3Dy=0D=0A#=20CONFIG_INPUT_KXTJ9=20is=20not=20set=0D=
=0ACONFIG_INPUT_POWERMATE=3Dy=0D=0ACONFIG_INPUT_YEALINK=3Dy=0D=0ACONFIG_INP=
UT_CM109=3Dy=0D=0A#=20CONFIG_INPUT_REGULATOR_HAPTIC=20is=20not=20set=0D=0A#=
=20CONFIG_INPUT_RETU_PWRBUTTON=20is=20not=20set=0D=0A#=20CONFIG_INPUT_TWL40=
30_PWRBUTTON=20is=20not=20set=0D=0A#=20CONFIG_INPUT_TWL4030_VIBRA=20is=20no=
t=20set=0D=0A#=20CONFIG_INPUT_UINPUT=20is=20not=20set=0D=0A#=20CONFIG_INPUT=
_PCF8574=20is=20not=20set=0D=0A#=20CONFIG_INPUT_GPIO_ROTARY_ENCODER=20is=20=
not=20set=0D=0A#=20CONFIG_INPUT_DA7280_HAPTICS=20is=20not=20set=0D=0A#=20CO=
NFIG_INPUT_ADXL34X=20is=20not=20set=0D=0ACONFIG_INPUT_IMS_PCU=3Dy=0D=0A#=20=
CONFIG_INPUT_IQS269A=20is=20not=20set=0D=0A#=20CONFIG_INPUT_IQS626A=20is=20=
not=20set=0D=0A#=20CONFIG_INPUT_IQS7222=20is=20not=20set=0D=0A#=20CONFIG_IN=
PUT_CMA3000=20is=20not=20set=0D=0A#=20CONFIG_INPUT_IDEAPAD_SLIDEBAR=20is=20=
not=20set=0D=0A#=20CONFIG_INPUT_DRV260X_HAPTICS=20is=20not=20set=0D=0A#=20C=
ONFIG_INPUT_DRV2665_HAPTICS=20is=20not=20set=0D=0A#=20CONFIG_INPUT_DRV2667_=
HAPTICS=20is=20not=20set=0D=0ACONFIG_RMI4_CORE=3Dy=0D=0A#=20CONFIG_RMI4_I2C=
=20is=20not=20set=0D=0A#=20CONFIG_RMI4_SPI=20is=20not=20set=0D=0A#=20CONFIG=
_RMI4_SMB=20is=20not=20set=0D=0ACONFIG_RMI4_F03=3Dy=0D=0ACONFIG_RMI4_F03_SE=
RIO=3Dy=0D=0ACONFIG_RMI4_2D_SENSOR=3Dy=0D=0ACONFIG_RMI4_F11=3Dy=0D=0ACONFIG=
_RMI4_F12=3Dy=0D=0A#=20CONFIG_RMI4_F1A=20is=20not=20set=0D=0A#=20CONFIG_RMI=
4_F21=20is=20not=20set=0D=0ACONFIG_RMI4_F30=3Dy=0D=0A#=20CONFIG_RMI4_F34=20=
is=20not=20set=0D=0ACONFIG_RMI4_F3A=3Dy=0D=0A#=20CONFIG_RMI4_F54=20is=20not=
=20set=0D=0A#=20CONFIG_RMI4_F55=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Hard=
ware=20I/O=20ports=0D=0A#=0D=0ACONFIG_SERIO=3Dy=0D=0ACONFIG_ARCH_MIGHT_HAVE=
_PC_SERIO=3Dy=0D=0ACONFIG_SERIO_I8042=3Dy=0D=0ACONFIG_SERIO_SERPORT=3Dy=0D=
=0A#=20CONFIG_SERIO_CT82C710=20is=20not=20set=0D=0A#=20CONFIG_SERIO_PARKBD=
=20is=20not=20set=0D=0A#=20CONFIG_SERIO_PCIPS2=20is=20not=20set=0D=0ACONFIG=
_SERIO_LIBPS2=3Dy=0D=0A#=20CONFIG_SERIO_RAW=20is=20not=20set=0D=0A#=20CONFI=
G_SERIO_ALTERA_PS2=20is=20not=20set=0D=0A#=20CONFIG_SERIO_PS2MULT=20is=20no=
t=20set=0D=0A#=20CONFIG_SERIO_ARC_PS2=20is=20not=20set=0D=0A#=20CONFIG_SERI=
O_APBPS2=20is=20not=20set=0D=0A#=20CONFIG_SERIO_GPIO_PS2=20is=20not=20set=
=0D=0A#=20CONFIG_USERIO=20is=20not=20set=0D=0A#=20CONFIG_GAMEPORT=20is=20no=
t=20set=0D=0A#=20end=20of=20Hardware=20I/O=20ports=0D=0A#=20end=20of=20Inpu=
t=20device=20support=0D=0A=0D=0A#=0D=0A#=20Character=20devices=0D=0A#=0D=0A=
CONFIG_TTY=3Dy=0D=0ACONFIG_VT=3Dy=0D=0ACONFIG_CONSOLE_TRANSLATIONS=3Dy=0D=
=0ACONFIG_VT_CONSOLE=3Dy=0D=0ACONFIG_VT_CONSOLE_SLEEP=3Dy=0D=0A#=20CONFIG_V=
T_HW_CONSOLE_BINDING=20is=20not=20set=0D=0ACONFIG_UNIX98_PTYS=3Dy=0D=0A#=20=
CONFIG_LEGACY_PTYS=20is=20not=20set=0D=0ACONFIG_LEGACY_TIOCSTI=3Dy=0D=0ACON=
FIG_LDISC_AUTOLOAD=3Dy=0D=0A=0D=0A#=0D=0A#=20Serial=20drivers=0D=0A#=0D=0AC=
ONFIG_SERIAL_EARLYCON=3Dy=0D=0ACONFIG_SERIAL_8250=3Dy=0D=0ACONFIG_SERIAL_82=
50_DEPRECATED_OPTIONS=3Dy=0D=0ACONFIG_SERIAL_8250_PNP=3Dy=0D=0A#=20CONFIG_S=
ERIAL_8250_16550A_VARIANTS=20is=20not=20set=0D=0A#=20CONFIG_SERIAL_8250_FIN=
TEK=20is=20not=20set=0D=0ACONFIG_SERIAL_8250_CONSOLE=3Dy=0D=0ACONFIG_SERIAL=
_8250_DMA=3Dy=0D=0ACONFIG_SERIAL_8250_PCILIB=3Dy=0D=0ACONFIG_SERIAL_8250_PC=
I=3Dy=0D=0ACONFIG_SERIAL_8250_EXAR=3Dy=0D=0A#=20CONFIG_SERIAL_8250_CS=20is=
=20not=20set=0D=0ACONFIG_SERIAL_8250_NR_UARTS=3D32=0D=0ACONFIG_SERIAL_8250_=
RUNTIME_UARTS=3D4=0D=0ACONFIG_SERIAL_8250_EXTENDED=3Dy=0D=0ACONFIG_SERIAL_8=
250_MANY_PORTS=3Dy=0D=0A#=20CONFIG_SERIAL_8250_PCI1XXXX=20is=20not=20set=0D=
=0ACONFIG_SERIAL_8250_SHARE_IRQ=3Dy=0D=0ACONFIG_SERIAL_8250_DETECT_IRQ=3Dy=
=0D=0ACONFIG_SERIAL_8250_RSA=3Dy=0D=0ACONFIG_SERIAL_8250_DWLIB=3Dy=0D=0A#=
=20CONFIG_SERIAL_8250_DW=20is=20not=20set=0D=0A#=20CONFIG_SERIAL_8250_RT288=
X=20is=20not=20set=0D=0ACONFIG_SERIAL_8250_LPSS=3Dy=0D=0ACONFIG_SERIAL_8250=
_MID=3Dy=0D=0ACONFIG_SERIAL_8250_PERICOM=3Dy=0D=0A#=20CONFIG_SERIAL_8250_NI=
=20is=20not=20set=0D=0A#=20CONFIG_SERIAL_OF_PLATFORM=20is=20not=20set=0D=0A=
=0D=0A#=0D=0A#=20Non-8250=20serial=20port=20support=0D=0A#=0D=0A#=20CONFIG_=
SERIAL_MAX3100=20is=20not=20set=0D=0A#=20CONFIG_SERIAL_MAX310X=20is=20not=
=20set=0D=0A#=20CONFIG_SERIAL_UARTLITE=20is=20not=20set=0D=0ACONFIG_SERIAL_=
CORE=3Dy=0D=0ACONFIG_SERIAL_CORE_CONSOLE=3Dy=0D=0A#=20CONFIG_SERIAL_JSM=20i=
s=20not=20set=0D=0A#=20CONFIG_SERIAL_SIFIVE=20is=20not=20set=0D=0A#=20CONFI=
G_SERIAL_LANTIQ=20is=20not=20set=0D=0A#=20CONFIG_SERIAL_SCCNXP=20is=20not=
=20set=0D=0A#=20CONFIG_SERIAL_SC16IS7XX=20is=20not=20set=0D=0A#=20CONFIG_SE=
RIAL_ALTERA_JTAGUART=20is=20not=20set=0D=0A#=20CONFIG_SERIAL_ALTERA_UART=20=
is=20not=20set=0D=0A#=20CONFIG_SERIAL_XILINX_PS_UART=20is=20not=20set=0D=0A=
#=20CONFIG_SERIAL_ARC=20is=20not=20set=0D=0A#=20CONFIG_SERIAL_RP2=20is=20no=
t=20set=0D=0A#=20CONFIG_SERIAL_FSL_LPUART=20is=20not=20set=0D=0A#=20CONFIG_=
SERIAL_FSL_LINFLEXUART=20is=20not=20set=0D=0A#=20CONFIG_SERIAL_CONEXANT_DIG=
ICOLOR=20is=20not=20set=0D=0A#=20CONFIG_SERIAL_SPRD=20is=20not=20set=0D=0A#=
=20end=20of=20Serial=20drivers=0D=0A=0D=0ACONFIG_SERIAL_MCTRL_GPIO=3Dy=0D=
=0ACONFIG_SERIAL_NONSTANDARD=3Dy=0D=0A#=20CONFIG_MOXA_INTELLIO=20is=20not=
=20set=0D=0A#=20CONFIG_MOXA_SMARTIO=20is=20not=20set=0D=0A#=20CONFIG_N_HDLC=
=20is=20not=20set=0D=0A#=20CONFIG_IPWIRELESS=20is=20not=20set=0D=0A#=20CONF=
IG_N_GSM=20is=20not=20set=0D=0A#=20CONFIG_NOZOMI=20is=20not=20set=0D=0A#=20=
CONFIG_NULL_TTY=20is=20not=20set=0D=0ACONFIG_HVC_DRIVER=3Dy=0D=0ACONFIG_SER=
IAL_DEV_BUS=3Dy=0D=0A#=20CONFIG_SERIAL_DEV_CTRL_TTYPORT=20is=20not=20set=0D=
=0A#=20CONFIG_TTY_PRINTK=20is=20not=20set=0D=0A#=20CONFIG_PRINTER=20is=20no=
t=20set=0D=0A#=20CONFIG_PPDEV=20is=20not=20set=0D=0ACONFIG_VIRTIO_CONSOLE=
=3Dy=0D=0A#=20CONFIG_IPMI_HANDLER=20is=20not=20set=0D=0ACONFIG_HW_RANDOM=3D=
y=0D=0A#=20CONFIG_HW_RANDOM_TIMERIOMEM=20is=20not=20set=0D=0A#=20CONFIG_HW_=
RANDOM_INTEL=20is=20not=20set=0D=0A#=20CONFIG_HW_RANDOM_AMD=20is=20not=20se=
t=0D=0A#=20CONFIG_HW_RANDOM_BA431=20is=20not=20set=0D=0A#=20CONFIG_HW_RANDO=
M_VIA=20is=20not=20set=0D=0ACONFIG_HW_RANDOM_VIRTIO=3Dy=0D=0A#=20CONFIG_HW_=
RANDOM_CCTRNG=20is=20not=20set=0D=0A#=20CONFIG_HW_RANDOM_XIPHERA=20is=20not=
=20set=0D=0A#=20CONFIG_APPLICOM=20is=20not=20set=0D=0A#=20CONFIG_MWAVE=20is=
=20not=20set=0D=0A#=20CONFIG_DEVMEM=20is=20not=20set=0D=0ACONFIG_NVRAM=3Dy=
=0D=0A#=20CONFIG_DEVPORT=20is=20not=20set=0D=0ACONFIG_HPET=3Dy=0D=0A#=20CON=
FIG_HPET_MMAP=20is=20not=20set=0D=0A#=20CONFIG_HANGCHECK_TIMER=20is=20not=
=20set=0D=0A#=20CONFIG_TCG_TPM=20is=20not=20set=0D=0A#=20CONFIG_TELCLOCK=20=
is=20not=20set=0D=0ACONFIG_XILLYBUS_CLASS=3Dy=0D=0A#=20CONFIG_XILLYBUS=20is=
=20not=20set=0D=0ACONFIG_XILLYUSB=3Dy=0D=0A#=20end=20of=20Character=20devic=
es=0D=0A=0D=0A#=0D=0A#=20I2C=20support=0D=0A#=0D=0ACONFIG_I2C=3Dy=0D=0ACONF=
IG_ACPI_I2C_OPREGION=3Dy=0D=0ACONFIG_I2C_BOARDINFO=3Dy=0D=0A#=20CONFIG_I2C_=
CHARDEV=20is=20not=20set=0D=0ACONFIG_I2C_MUX=3Dy=0D=0A=0D=0A#=0D=0A#=20Mult=
iplexer=20I2C=20Chip=20support=0D=0A#=0D=0A#=20CONFIG_I2C_ARB_GPIO_CHALLENG=
E=20is=20not=20set=0D=0A#=20CONFIG_I2C_MUX_GPIO=20is=20not=20set=0D=0A#=20C=
ONFIG_I2C_MUX_GPMUX=20is=20not=20set=0D=0A#=20CONFIG_I2C_MUX_LTC4306=20is=
=20not=20set=0D=0A#=20CONFIG_I2C_MUX_PCA9541=20is=20not=20set=0D=0A#=20CONF=
IG_I2C_MUX_PCA954x=20is=20not=20set=0D=0A#=20CONFIG_I2C_MUX_REG=20is=20not=
=20set=0D=0A#=20CONFIG_I2C_MUX_MLXCPLD=20is=20not=20set=0D=0A#=20end=20of=
=20Multiplexer=20I2C=20Chip=20support=0D=0A=0D=0ACONFIG_I2C_HELPER_AUTO=3Dy=
=0D=0ACONFIG_I2C_SMBUS=3Dy=0D=0ACONFIG_I2C_ALGOBIT=3Dy=0D=0A=0D=0A#=0D=0A#=
=20I2C=20Hardware=20Bus=20support=0D=0A#=0D=0A=0D=0A#=0D=0A#=20PC=20SMBus=
=20host=20controller=20drivers=0D=0A#=0D=0A#=20CONFIG_I2C_ALI1535=20is=20no=
t=20set=0D=0A#=20CONFIG_I2C_ALI1563=20is=20not=20set=0D=0A#=20CONFIG_I2C_AL=
I15X3=20is=20not=20set=0D=0A#=20CONFIG_I2C_AMD756=20is=20not=20set=0D=0A#=
=20CONFIG_I2C_AMD8111=20is=20not=20set=0D=0A#=20CONFIG_I2C_AMD_MP2=20is=20n=
ot=20set=0D=0ACONFIG_I2C_I801=3Dy=0D=0A#=20CONFIG_I2C_ISCH=20is=20not=20set=
=0D=0A#=20CONFIG_I2C_ISMT=20is=20not=20set=0D=0A#=20CONFIG_I2C_PIIX4=20is=
=20not=20set=0D=0A#=20CONFIG_I2C_CHT_WC=20is=20not=20set=0D=0A#=20CONFIG_I2=
C_NFORCE2=20is=20not=20set=0D=0A#=20CONFIG_I2C_NVIDIA_GPU=20is=20not=20set=
=0D=0A#=20CONFIG_I2C_SIS5595=20is=20not=20set=0D=0A#=20CONFIG_I2C_SIS630=20=
is=20not=20set=0D=0A#=20CONFIG_I2C_SIS96X=20is=20not=20set=0D=0A#=20CONFIG_=
I2C_VIA=20is=20not=20set=0D=0A#=20CONFIG_I2C_VIAPRO=20is=20not=20set=0D=0A#=
=20CONFIG_I2C_ZHAOXIN=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20ACPI=20drivers=
=0D=0A#=0D=0A#=20CONFIG_I2C_SCMI=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20I2C=
=20system=20bus=20drivers=20(mostly=20embedded=20/=20system-on-chip)=0D=0A#=
=0D=0A#=20CONFIG_I2C_CBUS_GPIO=20is=20not=20set=0D=0ACONFIG_I2C_DESIGNWARE_=
CORE=3Dy=0D=0A#=20CONFIG_I2C_DESIGNWARE_SLAVE=20is=20not=20set=0D=0ACONFIG_=
I2C_DESIGNWARE_PLATFORM=3Dy=0D=0A#=20CONFIG_I2C_DESIGNWARE_AMDPSP=20is=20no=
t=20set=0D=0A#=20CONFIG_I2C_DESIGNWARE_BAYTRAIL=20is=20not=20set=0D=0A#=20C=
ONFIG_I2C_DESIGNWARE_PCI=20is=20not=20set=0D=0A#=20CONFIG_I2C_EMEV2=20is=20=
not=20set=0D=0A#=20CONFIG_I2C_GPIO=20is=20not=20set=0D=0A#=20CONFIG_I2C_OCO=
RES=20is=20not=20set=0D=0A#=20CONFIG_I2C_PCA_PLATFORM=20is=20not=20set=0D=
=0A#=20CONFIG_I2C_RK3X=20is=20not=20set=0D=0A#=20CONFIG_I2C_SIMTEC=20is=20n=
ot=20set=0D=0A#=20CONFIG_I2C_XILINX=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20=
External=20I2C/SMBus=20adapter=20drivers=0D=0A#=0D=0ACONFIG_I2C_DIOLAN_U2C=
=3Dy=0D=0ACONFIG_I2C_DLN2=3Dy=0D=0ACONFIG_I2C_LJCA=3Dy=0D=0ACONFIG_I2C_CP26=
15=3Dy=0D=0A#=20CONFIG_I2C_PARPORT=20is=20not=20set=0D=0A#=20CONFIG_I2C_PCI=
1XXXX=20is=20not=20set=0D=0ACONFIG_I2C_ROBOTFUZZ_OSIF=3Dy=0D=0A#=20CONFIG_I=
2C_TAOS_EVM=20is=20not=20set=0D=0ACONFIG_I2C_TINY_USB=3Dy=0D=0ACONFIG_I2C_V=
IPERBOARD=3Dy=0D=0A=0D=0A#=0D=0A#=20Other=20I2C/SMBus=20bus=20drivers=0D=0A=
#=0D=0A#=20CONFIG_I2C_MLXCPLD=20is=20not=20set=0D=0A#=20CONFIG_I2C_CROS_EC_=
TUNNEL=20is=20not=20set=0D=0A#=20CONFIG_I2C_VIRTIO=20is=20not=20set=0D=0A#=
=20end=20of=20I2C=20Hardware=20Bus=20support=0D=0A=0D=0A#=20CONFIG_I2C_STUB=
=20is=20not=20set=0D=0A#=20CONFIG_I2C_SLAVE=20is=20not=20set=0D=0A#=20CONFI=
G_I2C_DEBUG_CORE=20is=20not=20set=0D=0A#=20CONFIG_I2C_DEBUG_ALGO=20is=20not=
=20set=0D=0A#=20CONFIG_I2C_DEBUG_BUS=20is=20not=20set=0D=0A#=20end=20of=20I=
2C=20support=0D=0A=0D=0A#=20CONFIG_I3C=20is=20not=20set=0D=0ACONFIG_SPI=3Dy=
=0D=0A#=20CONFIG_SPI_DEBUG=20is=20not=20set=0D=0ACONFIG_SPI_MASTER=3Dy=0D=
=0A#=20CONFIG_SPI_MEM=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20SPI=20Master=
=20Controller=20Drivers=0D=0A#=0D=0A#=20CONFIG_SPI_ALTERA=20is=20not=20set=
=0D=0A#=20CONFIG_SPI_AXI_SPI_ENGINE=20is=20not=20set=0D=0A#=20CONFIG_SPI_BI=
TBANG=20is=20not=20set=0D=0A#=20CONFIG_SPI_BUTTERFLY=20is=20not=20set=0D=0A=
#=20CONFIG_SPI_CADENCE=20is=20not=20set=0D=0A#=20CONFIG_SPI_CADENCE_QUADSPI=
=20is=20not=20set=0D=0A#=20CONFIG_SPI_CH341=20is=20not=20set=0D=0A#=20CONFI=
G_SPI_DESIGNWARE=20is=20not=20set=0D=0ACONFIG_SPI_DLN2=3Dy=0D=0A#=20CONFIG_=
SPI_GPIO=20is=20not=20set=0D=0A#=20CONFIG_SPI_LM70_LLP=20is=20not=20set=0D=
=0A#=20CONFIG_SPI_FSL_SPI=20is=20not=20set=0D=0ACONFIG_SPI_LJCA=3Dy=0D=0A#=
=20CONFIG_SPI_MICROCHIP_CORE=20is=20not=20set=0D=0A#=20CONFIG_SPI_MICROCHIP=
_CORE_QSPI=20is=20not=20set=0D=0A#=20CONFIG_SPI_LANTIQ_SSC=20is=20not=20set=
=0D=0A#=20CONFIG_SPI_OC_TINY=20is=20not=20set=0D=0A#=20CONFIG_SPI_PCI1XXXX=
=20is=20not=20set=0D=0A#=20CONFIG_SPI_PXA2XX=20is=20not=20set=0D=0A#=20CONF=
IG_SPI_SC18IS602=20is=20not=20set=0D=0A#=20CONFIG_SPI_SIFIVE=20is=20not=20s=
et=0D=0A#=20CONFIG_SPI_MXIC=20is=20not=20set=0D=0A#=20CONFIG_SPI_VIRTIO=20i=
s=20not=20set=0D=0A#=20CONFIG_SPI_XCOMM=20is=20not=20set=0D=0A#=20CONFIG_SP=
I_XILINX=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20SPI=20Multiplexer=20support=
=0D=0A#=0D=0A#=20CONFIG_SPI_MUX=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20SPI=
=20Protocol=20Masters=0D=0A#=0D=0A#=20CONFIG_SPI_SPIDEV=20is=20not=20set=0D=
=0A#=20CONFIG_SPI_LOOPBACK_TEST=20is=20not=20set=0D=0A#=20CONFIG_SPI_TLE62X=
0=20is=20not=20set=0D=0A#=20CONFIG_SPI_SLAVE=20is=20not=20set=0D=0ACONFIG_S=
PI_DYNAMIC=3Dy=0D=0A#=20CONFIG_SPMI=20is=20not=20set=0D=0A#=20CONFIG_HSI=20=
is=20not=20set=0D=0ACONFIG_PPS=3Dy=0D=0A#=20CONFIG_PPS_DEBUG=20is=20not=20s=
et=0D=0A=0D=0A#=0D=0A#=20PPS=20clients=20support=0D=0A#=0D=0A#=20CONFIG_PPS=
_CLIENT_KTIMER=20is=20not=20set=0D=0A#=20CONFIG_PPS_CLIENT_LDISC=20is=20not=
=20set=0D=0A#=20CONFIG_PPS_CLIENT_PARPORT=20is=20not=20set=0D=0A#=20CONFIG_=
PPS_CLIENT_GPIO=20is=20not=20set=0D=0A#=20CONFIG_PPS_GENERATOR=20is=20not=
=20set=0D=0A=0D=0A#=0D=0A#=20PTP=20clock=20support=0D=0A#=0D=0ACONFIG_PTP_1=
588_CLOCK=3Dy=0D=0ACONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy=0D=0A=0D=0A#=0D=0A#=
=20Enable=20PHYLIB=20and=20NETWORK_PHY_TIMESTAMPING=20to=20see=20the=20addi=
tional=20clocks=2E=0D=0A#=0D=0ACONFIG_PTP_1588_CLOCK_KVM=3Dy=0D=0ACONFIG_PT=
P_1588_CLOCK_VMCLOCK=3Dy=0D=0A#=20CONFIG_PTP_1588_CLOCK_IDT82P33=20is=20not=
=20set=0D=0A#=20CONFIG_PTP_1588_CLOCK_IDTCM=20is=20not=20set=0D=0A#=20CONFI=
G_PTP_1588_CLOCK_FC3W=20is=20not=20set=0D=0A#=20CONFIG_PTP_1588_CLOCK_MOCK=
=20is=20not=20set=0D=0A#=20CONFIG_PTP_1588_CLOCK_VMW=20is=20not=20set=0D=0A=
#=20CONFIG_PTP_NETC_V4_TIMER=20is=20not=20set=0D=0A#=20end=20of=20PTP=20clo=
ck=20support=0D=0A=0D=0A#=0D=0A#=20DPLL=20device=20support=0D=0A#=0D=0A#=20=
CONFIG_ZL3073X_I2C=20is=20not=20set=0D=0A#=20CONFIG_ZL3073X_SPI=20is=20not=
=20set=0D=0A#=20end=20of=20DPLL=20device=20support=0D=0A=0D=0A#=20CONFIG_PI=
NCTRL=20is=20not=20set=0D=0ACONFIG_GPIOLIB_LEGACY=3Dy=0D=0ACONFIG_GPIOLIB=
=3Dy=0D=0ACONFIG_GPIOLIB_FASTPATH_LIMIT=3D512=0D=0ACONFIG_OF_GPIO=3Dy=0D=0A=
CONFIG_GPIO_ACPI=3Dy=0D=0ACONFIG_GPIOLIB_IRQCHIP=3Dy=0D=0A#=20CONFIG_DEBUG_=
GPIO=20is=20not=20set=0D=0A#=20CONFIG_GPIO_SYSFS=20is=20not=20set=0D=0A#=20=
CONFIG_GPIO_CDEV=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Memory=20mapped=20G=
PIO=20drivers=0D=0A#=0D=0A#=20CONFIG_GPIO_74XX_MMIO=20is=20not=20set=0D=0A#=
=20CONFIG_GPIO_ALTERA=20is=20not=20set=0D=0A#=20CONFIG_GPIO_AMDPT=20is=20no=
t=20set=0D=0A#=20CONFIG_GPIO_CADENCE=20is=20not=20set=0D=0A#=20CONFIG_GPIO_=
DWAPB=20is=20not=20set=0D=0A#=20CONFIG_GPIO_EXAR=20is=20not=20set=0D=0A#=20=
CONFIG_GPIO_FTGPIO010=20is=20not=20set=0D=0A#=20CONFIG_GPIO_GENERIC_PLATFOR=
M=20is=20not=20set=0D=0A#=20CONFIG_GPIO_GRANITERAPIDS=20is=20not=20set=0D=
=0A#=20CONFIG_GPIO_GRGPIO=20is=20not=20set=0D=0A#=20CONFIG_GPIO_HLWD=20is=
=20not=20set=0D=0A#=20CONFIG_GPIO_LOGICVC=20is=20not=20set=0D=0A#=20CONFIG_=
GPIO_MB86S7X=20is=20not=20set=0D=0A#=20CONFIG_GPIO_POLARFIRE_SOC=20is=20not=
=20set=0D=0A#=20CONFIG_GPIO_SIFIVE=20is=20not=20set=0D=0A#=20CONFIG_GPIO_SY=
SCON=20is=20not=20set=0D=0A#=20CONFIG_GPIO_XILINX=20is=20not=20set=0D=0A#=
=20CONFIG_GPIO_AMD_FCH=20is=20not=20set=0D=0A#=20end=20of=20Memory=20mapped=
=20GPIO=20drivers=0D=0A=0D=0A#=0D=0A#=20Port-mapped=20I/O=20GPIO=20drivers=
=0D=0A#=0D=0A#=20CONFIG_GPIO_VX855=20is=20not=20set=0D=0A#=20CONFIG_GPIO_F7=
188X=20is=20not=20set=0D=0A#=20CONFIG_GPIO_IT87=20is=20not=20set=0D=0A#=20C=
ONFIG_GPIO_SCH311X=20is=20not=20set=0D=0A#=20CONFIG_GPIO_WINBOND=20is=20not=
=20set=0D=0A#=20CONFIG_GPIO_WS16C48=20is=20not=20set=0D=0A#=20end=20of=20Po=
rt-mapped=20I/O=20GPIO=20drivers=0D=0A=0D=0A#=0D=0A#=20I2C=20GPIO=20expande=
rs=0D=0A#=0D=0A#=20CONFIG_GPIO_ADNP=20is=20not=20set=0D=0A#=20CONFIG_GPIO_F=
XL6408=20is=20not=20set=0D=0A#=20CONFIG_GPIO_DS4520=20is=20not=20set=0D=0A#=
=20CONFIG_GPIO_GW_PLD=20is=20not=20set=0D=0A#=20CONFIG_GPIO_MAX7300=20is=20=
not=20set=0D=0A#=20CONFIG_GPIO_MAX732X=20is=20not=20set=0D=0A#=20CONFIG_GPI=
O_PCA953X=20is=20not=20set=0D=0A#=20CONFIG_GPIO_PCA9570=20is=20not=20set=0D=
=0A#=20CONFIG_GPIO_PCF857X=20is=20not=20set=0D=0A#=20CONFIG_GPIO_TPIC2810=
=20is=20not=20set=0D=0A#=20end=20of=20I2C=20GPIO=20expanders=0D=0A=0D=0A#=
=0D=0A#=20MFD=20GPIO=20expanders=0D=0A#=0D=0A#=20CONFIG_GPIO_CROS_EC=20is=
=20not=20set=0D=0ACONFIG_GPIO_DLN2=3Dy=0D=0A#=20CONFIG_GPIO_ELKHARTLAKE=20i=
s=20not=20set=0D=0ACONFIG_GPIO_LJCA=3Dy=0D=0A#=20CONFIG_GPIO_TWL4030=20is=
=20not=20set=0D=0A#=20CONFIG_GPIO_WHISKEY_COVE=20is=20not=20set=0D=0A#=20en=
d=20of=20MFD=20GPIO=20expanders=0D=0A=0D=0A#=0D=0A#=20PCI=20GPIO=20expander=
s=0D=0A#=0D=0A#=20CONFIG_GPIO_AMD8111=20is=20not=20set=0D=0A#=20CONFIG_GPIO=
_BT8XX=20is=20not=20set=0D=0A#=20CONFIG_GPIO_ML_IOH=20is=20not=20set=0D=0A#=
=20CONFIG_GPIO_PCI_IDIO_16=20is=20not=20set=0D=0A#=20CONFIG_GPIO_PCIE_IDIO_=
24=20is=20not=20set=0D=0A#=20CONFIG_GPIO_RDC321X=20is=20not=20set=0D=0A#=20=
CONFIG_GPIO_SODAVILLE=20is=20not=20set=0D=0A#=20end=20of=20PCI=20GPIO=20exp=
anders=0D=0A=0D=0A#=0D=0A#=20SPI=20GPIO=20expanders=0D=0A#=0D=0A#=20CONFIG_=
GPIO_74X164=20is=20not=20set=0D=0A#=20CONFIG_GPIO_MAX3191X=20is=20not=20set=
=0D=0A#=20CONFIG_GPIO_MAX7301=20is=20not=20set=0D=0A#=20CONFIG_GPIO_MC33880=
=20is=20not=20set=0D=0A#=20CONFIG_GPIO_PISOSR=20is=20not=20set=0D=0A#=20CON=
FIG_GPIO_XRA1403=20is=20not=20set=0D=0A#=20end=20of=20SPI=20GPIO=20expander=
s=0D=0A=0D=0A#=0D=0A#=20USB=20GPIO=20expanders=0D=0A#=0D=0ACONFIG_GPIO_VIPE=
RBOARD=3Dy=0D=0A#=20CONFIG_GPIO_MPSSE=20is=20not=20set=0D=0A#=20end=20of=20=
USB=20GPIO=20expanders=0D=0A=0D=0A#=0D=0A#=20Virtual=20GPIO=20drivers=0D=0A=
#=0D=0A#=20CONFIG_GPIO_AGGREGATOR=20is=20not=20set=0D=0A#=20CONFIG_GPIO_LAT=
CH=20is=20not=20set=0D=0A#=20CONFIG_GPIO_MOCKUP=20is=20not=20set=0D=0A#=20C=
ONFIG_GPIO_VIRTIO=20is=20not=20set=0D=0A#=20CONFIG_GPIO_SIM=20is=20not=20se=
t=0D=0A#=20end=20of=20Virtual=20GPIO=20drivers=0D=0A=0D=0A#=0D=0A#=20GPIO=
=20Debugging=20utilities=0D=0A#=0D=0A#=20CONFIG_GPIO_SLOPPY_LOGIC_ANALYZER=
=20is=20not=20set=0D=0A#=20CONFIG_GPIO_VIRTUSER=20is=20not=20set=0D=0A#=20e=
nd=20of=20GPIO=20Debugging=20utilities=0D=0A=0D=0ACONFIG_W1=3Dy=0D=0A#=20CO=
NFIG_W1_CON=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=201-wire=20Bus=20Masters=
=0D=0A#=0D=0A#=20CONFIG_W1_MASTER_AMD_AXI=20is=20not=20set=0D=0A#=20CONFIG_=
W1_MASTER_MATROX=20is=20not=20set=0D=0ACONFIG_W1_MASTER_DS2490=3Dy=0D=0A#=
=20CONFIG_W1_MASTER_DS2482=20is=20not=20set=0D=0A#=20CONFIG_W1_MASTER_GPIO=
=20is=20not=20set=0D=0A#=20CONFIG_W1_MASTER_SGI=20is=20not=20set=0D=0A#=20C=
ONFIG_W1_MASTER_UART=20is=20not=20set=0D=0A#=20end=20of=201-wire=20Bus=20Ma=
sters=0D=0A=0D=0A#=0D=0A#=201-wire=20Slaves=0D=0A#=0D=0A#=20CONFIG_W1_SLAVE=
_THERM=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_SMEM=20is=20not=20set=0D=
=0A#=20CONFIG_W1_SLAVE_DS2405=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_DS2=
408=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_DS2413=20is=20not=20set=0D=0A=
#=20CONFIG_W1_SLAVE_DS2406=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_DS2423=
=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_DS2805=20is=20not=20set=0D=0A#=
=20CONFIG_W1_SLAVE_DS2430=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_DS2431=
=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_DS2433=20is=20not=20set=0D=0A#=
=20CONFIG_W1_SLAVE_DS2438=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_DS250X=
=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_DS2780=20is=20not=20set=0D=0A#=
=20CONFIG_W1_SLAVE_DS2781=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_DS28E04=
=20is=20not=20set=0D=0A#=20CONFIG_W1_SLAVE_DS28E17=20is=20not=20set=0D=0A#=
=20end=20of=201-wire=20Slaves=0D=0A=0D=0A#=20CONFIG_POWER_RESET=20is=20not=
=20set=0D=0A#=20CONFIG_POWER_SEQUENCING=20is=20not=20set=0D=0ACONFIG_POWER_=
SUPPLY=3Dy=0D=0A#=20CONFIG_POWER_SUPPLY_DEBUG=20is=20not=20set=0D=0ACONFIG_=
POWER_SUPPLY_HWMON=3Dy=0D=0A#=20CONFIG_GENERIC_ADC_BATTERY=20is=20not=20set=
=0D=0A#=20CONFIG_IP5XXX_POWER=20is=20not=20set=0D=0A#=20CONFIG_TEST_POWER=
=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_ADP5061=20is=20not=20set=0D=0A#=
=20CONFIG_BATTERY_CHAGALL=20is=20not=20set=0D=0A#=20CONFIG_BATTERY_CW2015=
=20is=20not=20set=0D=0A#=20CONFIG_BATTERY_DS2760=20is=20not=20set=0D=0A#=20=
CONFIG_BATTERY_DS2780=20is=20not=20set=0D=0A#=20CONFIG_BATTERY_DS2781=20is=
=20not=20set=0D=0A#=20CONFIG_BATTERY_DS2782=20is=20not=20set=0D=0A#=20CONFI=
G_BATTERY_SAMSUNG_SDI=20is=20not=20set=0D=0A#=20CONFIG_BATTERY_SBS=20is=20n=
ot=20set=0D=0A#=20CONFIG_CHARGER_SBS=20is=20not=20set=0D=0A#=20CONFIG_MANAG=
ER_SBS=20is=20not=20set=0D=0A#=20CONFIG_BATTERY_BQ27XXX=20is=20not=20set=0D=
=0A#=20CONFIG_BATTERY_MAX17040=20is=20not=20set=0D=0A#=20CONFIG_BATTERY_MAX=
17042=20is=20not=20set=0D=0A#=20CONFIG_BATTERY_MAX1720X=20is=20not=20set=0D=
=0A#=20CONFIG_BATTERY_MAX1721X=20is=20not=20set=0D=0ACONFIG_CHARGER_ISP1704=
=3Dy=0D=0A#=20CONFIG_CHARGER_MAX8903=20is=20not=20set=0D=0A#=20CONFIG_CHARG=
ER_TWL4030=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_TWL6030=20is=20not=20se=
t=0D=0A#=20CONFIG_CHARGER_LP8727=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_G=
PIO=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_MANAGER=20is=20not=20set=0D=0A=
#=20CONFIG_CHARGER_LT3651=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_LTC4162L=
=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_DETECTOR_MAX14656=20is=20not=20se=
t=0D=0A#=20CONFIG_CHARGER_MAX77976=20is=20not=20set=0D=0A#=20CONFIG_CHARGER=
_MAX8971=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_MT6360=20is=20not=20set=
=0D=0A#=20CONFIG_CHARGER_MT6370=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_BQ=
2415X=20is=20not=20set=0D=0ACONFIG_CHARGER_BQ24190=3Dy=0D=0A#=20CONFIG_CHAR=
GER_BQ24257=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_BQ24735=20is=20not=20s=
et=0D=0A#=20CONFIG_CHARGER_BQ2515X=20is=20not=20set=0D=0A#=20CONFIG_CHARGER=
_BQ25890=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_BQ25980=20is=20not=20set=
=0D=0A#=20CONFIG_CHARGER_BQ256XX=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_S=
MB347=20is=20not=20set=0D=0A#=20CONFIG_BATTERY_GAUGE_LTC2941=20is=20not=20s=
et=0D=0A#=20CONFIG_BATTERY_GOLDFISH=20is=20not=20set=0D=0A#=20CONFIG_BATTER=
Y_RT5033=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_RT9455=20is=20not=20set=
=0D=0A#=20CONFIG_CHARGER_RT9467=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_RT=
9471=20is=20not=20set=0D=0A#=20CONFIG_CHARGER_CROS_USBPD=20is=20not=20set=
=0D=0A#=20CONFIG_CHARGER_CROS_PCHG=20is=20not=20set=0D=0A#=20CONFIG_CHARGER=
_CROS_CONTROL=20is=20not=20set=0D=0A#=20CONFIG_FUEL_GAUGE_STC3117=20is=20no=
t=20set=0D=0A#=20CONFIG_CHARGER_UCS1002=20is=20not=20set=0D=0A#=20CONFIG_CH=
ARGER_BD99954=20is=20not=20set=0D=0A#=20CONFIG_BATTERY_SURFACE=20is=20not=
=20set=0D=0A#=20CONFIG_CHARGER_SURFACE=20is=20not=20set=0D=0A#=20CONFIG_BAT=
TERY_UG3105=20is=20not=20set=0D=0A#=20CONFIG_FUEL_GAUGE_MM8013=20is=20not=
=20set=0D=0ACONFIG_HWMON=3Dy=0D=0A#=20CONFIG_HWMON_DEBUG_CHIP=20is=20not=20=
set=0D=0A=0D=0A#=0D=0A#=20Native=20drivers=0D=0A#=0D=0A#=20CONFIG_SENSORS_A=
BITUGURU=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ABITUGURU3=20is=20not=20s=
et=0D=0A#=20CONFIG_SENSORS_AD7314=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_=
AD7414=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_AD7418=20is=20not=20set=0D=
=0A#=20CONFIG_SENSORS_ADM1025=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ADM1=
026=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ADM1029=20is=20not=20set=0D=0A=
#=20CONFIG_SENSORS_ADM1031=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ADM1177=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ADM9240=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_ADT7310=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ADT7410=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ADT7411=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_ADT7462=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ADT7470=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ADT7475=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_AHT10=20is=20not=20set=0D=0ACONFIG_SENSORS_AQUACOMPUTER_D=
5NEXT=3Dy=0D=0A#=20CONFIG_SENSORS_AS370=20is=20not=20set=0D=0A#=20CONFIG_SE=
NSORS_ASC7621=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ASUS_ROG_RYUJIN=20is=
=20not=20set=0D=0A#=20CONFIG_SENSORS_AXI_FAN_CONTROL=20is=20not=20set=0D=0A=
#=20CONFIG_SENSORS_K8TEMP=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_K10TEMP=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_FAM15H_POWER=20is=20not=20set=0D=
=0A#=20CONFIG_SENSORS_APPLESMC=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ASB=
100=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ATXP1=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_CHIPCAP2=20is=20not=20set=0D=0ACONFIG_SENSORS_CORSAIR_CPR=
O=3Dy=0D=0ACONFIG_SENSORS_CORSAIR_PSU=3Dy=0D=0A#=20CONFIG_SENSORS_CROS_EC=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_DRIVETEMP=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_DS620=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_DS1621=20i=
s=20not=20set=0D=0A#=20CONFIG_SENSORS_DELL_SMM=20is=20not=20set=0D=0A#=20CO=
NFIG_SENSORS_I5K_AMB=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_F71805F=20is=
=20not=20set=0D=0A#=20CONFIG_SENSORS_F71882FG=20is=20not=20set=0D=0A#=20CON=
FIG_SENSORS_F75375S=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_FSCHMD=20is=20=
not=20set=0D=0A#=20CONFIG_SENSORS_FTSTEUTATES=20is=20not=20set=0D=0ACONFIG_=
SENSORS_GIGABYTE_WATERFORCE=3Dy=0D=0A#=20CONFIG_SENSORS_GL518SM=20is=20not=
=20set=0D=0A#=20CONFIG_SENSORS_GL520SM=20is=20not=20set=0D=0A#=20CONFIG_SEN=
SORS_GPD=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_G760A=20is=20not=20set=0D=
=0A#=20CONFIG_SENSORS_G762=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_GPIO_FA=
N=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_HIH6130=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_HS3001=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_HTU31=20i=
s=20not=20set=0D=0A#=20CONFIG_SENSORS_IIO_HWMON=20is=20not=20set=0D=0A#=20C=
ONFIG_SENSORS_I5500=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_CORETEMP=20is=
=20not=20set=0D=0A#=20CONFIG_SENSORS_ISL28022=20is=20not=20set=0D=0A#=20CON=
FIG_SENSORS_IT87=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_JC42=20is=20not=
=20set=0D=0ACONFIG_SENSORS_POWERZ=3Dy=0D=0A#=20CONFIG_SENSORS_POWR1220=20is=
=20not=20set=0D=0A#=20CONFIG_SENSORS_LENOVO_EC=20is=20not=20set=0D=0A#=20CO=
NFIG_SENSORS_LINEAGE=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LTC2945=20is=
=20not=20set=0D=0A#=20CONFIG_SENSORS_LTC2947_I2C=20is=20not=20set=0D=0A#=20=
CONFIG_SENSORS_LTC2947_SPI=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LTC2990=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LTC2991=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_LTC2992=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LTC4151=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LTC4215=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_LTC4222=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LTC4245=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LTC4260=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_LTC4261=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LTC4282=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_MAX1111=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_MAX127=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_MAX16065=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_MAX1619=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_MAX1668=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_MAX197=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_MAX31722=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_MAX31730=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_MAX3176=
0=20is=20not=20set=0D=0A#=20CONFIG_MAX31827=20is=20not=20set=0D=0A#=20CONFI=
G_SENSORS_MAX6620=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_MAX6621=20is=20n=
ot=20set=0D=0A#=20CONFIG_SENSORS_MAX6639=20is=20not=20set=0D=0A#=20CONFIG_S=
ENSORS_MAX6650=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_MAX6697=20is=20not=
=20set=0D=0A#=20CONFIG_SENSORS_MAX31790=20is=20not=20set=0D=0A#=20CONFIG_SE=
NSORS_MC34VR500=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_MCP3021=20is=20not=
=20set=0D=0A#=20CONFIG_SENSORS_TC654=20is=20not=20set=0D=0A#=20CONFIG_SENSO=
RS_TPS23861=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_MR75203=20is=20not=20s=
et=0D=0A#=20CONFIG_SENSORS_ADCXX=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_L=
M63=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LM70=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_LM73=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LM75=20is=
=20not=20set=0D=0A#=20CONFIG_SENSORS_LM77=20is=20not=20set=0D=0A#=20CONFIG_=
SENSORS_LM78=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LM80=20is=20not=20set=
=0D=0A#=20CONFIG_SENSORS_LM83=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LM85=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LM87=20is=20not=20set=0D=0A#=20CO=
NFIG_SENSORS_LM90=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LM92=20is=20not=
=20set=0D=0A#=20CONFIG_SENSORS_LM93=20is=20not=20set=0D=0A#=20CONFIG_SENSOR=
S_LM95234=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_LM95241=20is=20not=20set=
=0D=0A#=20CONFIG_SENSORS_LM95245=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_P=
C87360=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_PC87427=20is=20not=20set=0D=
=0A#=20CONFIG_SENSORS_NTC_THERMISTOR=20is=20not=20set=0D=0A#=20CONFIG_SENSO=
RS_NCT6683=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_NCT6775=20is=20not=20se=
t=0D=0A#=20CONFIG_SENSORS_NCT6775_I2C=20is=20not=20set=0D=0A#=20CONFIG_SENS=
ORS_NCT7363=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_NCT7802=20is=20not=20s=
et=0D=0A#=20CONFIG_SENSORS_NCT7904=20is=20not=20set=0D=0A#=20CONFIG_SENSORS=
_NPCM7XX=20is=20not=20set=0D=0ACONFIG_SENSORS_NZXT_KRAKEN2=3Dy=0D=0A#=20CON=
FIG_SENSORS_NZXT_KRAKEN3=20is=20not=20set=0D=0ACONFIG_SENSORS_NZXT_SMART2=
=3Dy=0D=0A#=20CONFIG_SENSORS_OCC_P8_I2C=20is=20not=20set=0D=0A#=20CONFIG_SE=
NSORS_PCF8591=20is=20not=20set=0D=0A#=20CONFIG_PMBUS=20is=20not=20set=0D=0A=
#=20CONFIG_SENSORS_PT5161L=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_SBTSI=
=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_SHT15=20is=20not=20set=0D=0A#=20C=
ONFIG_SENSORS_SHT21=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_SHT3x=20is=20n=
ot=20set=0D=0A#=20CONFIG_SENSORS_SHT4x=20is=20not=20set=0D=0A#=20CONFIG_SEN=
SORS_SHTC1=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_SIS5595=20is=20not=20se=
t=0D=0A#=20CONFIG_SENSORS_DME1737=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_=
EMC1403=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_EMC2103=20is=20not=20set=
=0D=0A#=20CONFIG_SENSORS_EMC2305=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_E=
MC6W201=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_SMSC47M1=20is=20not=20set=
=0D=0A#=20CONFIG_SENSORS_SMSC47M192=20is=20not=20set=0D=0A#=20CONFIG_SENSOR=
S_SMSC47B397=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_SCH5627=20is=20not=20=
set=0D=0A#=20CONFIG_SENSORS_SCH5636=20is=20not=20set=0D=0A#=20CONFIG_SENSOR=
S_STTS751=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_SURFACE_FAN=20is=20not=
=20set=0D=0A#=20CONFIG_SENSORS_SURFACE_TEMP=20is=20not=20set=0D=0A#=20CONFI=
G_SENSORS_ADC128D818=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ADS7828=20is=
=20not=20set=0D=0A#=20CONFIG_SENSORS_ADS7871=20is=20not=20set=0D=0A#=20CONF=
IG_SENSORS_AMC6821=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_INA209=20is=20n=
ot=20set=0D=0A#=20CONFIG_SENSORS_INA2XX=20is=20not=20set=0D=0A#=20CONFIG_SE=
NSORS_INA238=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_INA3221=20is=20not=20=
set=0D=0A#=20CONFIG_SENSORS_SPD5118=20is=20not=20set=0D=0A#=20CONFIG_SENSOR=
S_TC74=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_THMC50=20is=20not=20set=0D=
=0A#=20CONFIG_SENSORS_TMP102=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_TMP10=
3=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_TMP108=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_TMP401=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_TMP421=20=
is=20not=20set=0D=0A#=20CONFIG_SENSORS_TMP464=20is=20not=20set=0D=0A#=20CON=
FIG_SENSORS_TMP513=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_VIA_CPUTEMP=20i=
s=20not=20set=0D=0A#=20CONFIG_SENSORS_VIA686A=20is=20not=20set=0D=0A#=20CON=
FIG_SENSORS_VT1211=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_VT8231=20is=20n=
ot=20set=0D=0A#=20CONFIG_SENSORS_W83773G=20is=20not=20set=0D=0A#=20CONFIG_S=
ENSORS_W83781D=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_W83791D=20is=20not=
=20set=0D=0A#=20CONFIG_SENSORS_W83792D=20is=20not=20set=0D=0A#=20CONFIG_SEN=
SORS_W83793=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_W83795=20is=20not=20se=
t=0D=0A#=20CONFIG_SENSORS_W83L785TS=20is=20not=20set=0D=0A#=20CONFIG_SENSOR=
S_W83L786NG=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_W83627HF=20is=20not=20=
set=0D=0A#=20CONFIG_SENSORS_W83627EHF=20is=20not=20set=0D=0A#=20CONFIG_SENS=
ORS_XGENE=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20ACPI=20drivers=0D=0A#=0D=
=0A#=20CONFIG_SENSORS_ACPI_POWER=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_A=
TK0110=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ASUS_WMI=20is=20not=20set=
=0D=0A#=20CONFIG_SENSORS_ASUS_EC=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_H=
P_WMI=20is=20not=20set=0D=0ACONFIG_THERMAL=3Dy=0D=0ACONFIG_THERMAL_NETLINK=
=3Dy=0D=0A#=20CONFIG_THERMAL_STATISTICS=20is=20not=20set=0D=0A#=20CONFIG_TH=
ERMAL_DEBUGFS=20is=20not=20set=0D=0A#=20CONFIG_THERMAL_CORE_TESTING=20is=20=
not=20set=0D=0ACONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0=0D=0ACONFIG_T=
HERMAL_HWMON=3Dy=0D=0A#=20CONFIG_THERMAL_OF=20is=20not=20set=0D=0ACONFIG_TH=
ERMAL_DEFAULT_GOV_STEP_WISE=3Dy=0D=0A#=20CONFIG_THERMAL_DEFAULT_GOV_FAIR_SH=
ARE=20is=20not=20set=0D=0A#=20CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=20is=20=
not=20set=0D=0A#=20CONFIG_THERMAL_GOV_FAIR_SHARE=20is=20not=20set=0D=0ACONF=
IG_THERMAL_GOV_STEP_WISE=3Dy=0D=0A#=20CONFIG_THERMAL_GOV_BANG_BANG=20is=20n=
ot=20set=0D=0A#=20CONFIG_THERMAL_GOV_USER_SPACE=20is=20not=20set=0D=0A#=20C=
ONFIG_PCIE_THERMAL=20is=20not=20set=0D=0A#=20CONFIG_THERMAL_EMULATION=20is=
=20not=20set=0D=0A#=20CONFIG_THERMAL_MMIO=20is=20not=20set=0D=0A=0D=0A#=0D=
=0A#=20Intel=20thermal=20drivers=0D=0A#=0D=0A#=20CONFIG_INTEL_POWERCLAMP=20=
is=20not=20set=0D=0ACONFIG_X86_THERMAL_VECTOR=3Dy=0D=0ACONFIG_INTEL_TCC=3Dy=
=0D=0ACONFIG_X86_PKG_TEMP_THERMAL=3Dy=0D=0A#=20CONFIG_INTEL_SOC_DTS_THERMAL=
=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20ACPI=20INT340X=20thermal=20drivers=
=0D=0A#=0D=0A#=20CONFIG_INT340X_THERMAL=20is=20not=20set=0D=0A#=20end=20of=
=20ACPI=20INT340X=20thermal=20drivers=0D=0A=0D=0A#=20CONFIG_INTEL_BXT_PMIC_=
THERMAL=20is=20not=20set=0D=0A#=20CONFIG_INTEL_PCH_THERMAL=20is=20not=20set=
=0D=0A#=20CONFIG_INTEL_TCC_COOLING=20is=20not=20set=0D=0A#=20CONFIG_INTEL_H=
FI_THERMAL=20is=20not=20set=0D=0A#=20end=20of=20Intel=20thermal=20drivers=
=0D=0A=0D=0A#=20CONFIG_GENERIC_ADC_THERMAL=20is=20not=20set=0D=0ACONFIG_WAT=
CHDOG=3Dy=0D=0A#=20CONFIG_WATCHDOG_CORE=20is=20not=20set=0D=0A#=20CONFIG_WA=
TCHDOG_NOWAYOUT=20is=20not=20set=0D=0ACONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=
=3Dy=0D=0ACONFIG_WATCHDOG_OPEN_TIMEOUT=3D0=0D=0A#=20CONFIG_WATCHDOG_SYSFS=
=20is=20not=20set=0D=0A#=20CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=20is=20not=20=
set=0D=0A=0D=0A#=0D=0A#=20Watchdog=20Pretimeout=20Governors=0D=0A#=0D=0A=0D=
=0A#=0D=0A#=20Watchdog=20Device=20Drivers=0D=0A#=0D=0A#=20CONFIG_SOFT_WATCH=
DOG=20is=20not=20set=0D=0A#=20CONFIG_CROS_EC_WATCHDOG=20is=20not=20set=0D=
=0A#=20CONFIG_GPIO_WATCHDOG=20is=20not=20set=0D=0A#=20CONFIG_LENOVO_SE10_WD=
T=20is=20not=20set=0D=0A#=20CONFIG_LENOVO_SE30_WDT=20is=20not=20set=0D=0A#=
=20CONFIG_WDAT_WDT=20is=20not=20set=0D=0A#=20CONFIG_XILINX_WATCHDOG=20is=20=
not=20set=0D=0A#=20CONFIG_ZIIRAVE_WATCHDOG=20is=20not=20set=0D=0A#=20CONFIG=
_CADENCE_WATCHDOG=20is=20not=20set=0D=0A#=20CONFIG_DW_WATCHDOG=20is=20not=
=20set=0D=0A#=20CONFIG_TWL4030_WATCHDOG=20is=20not=20set=0D=0A#=20CONFIG_MA=
X63XX_WATCHDOG=20is=20not=20set=0D=0A#=20CONFIG_RETU_WATCHDOG=20is=20not=20=
set=0D=0A#=20CONFIG_ACQUIRE_WDT=20is=20not=20set=0D=0A#=20CONFIG_ADVANTECH_=
WDT=20is=20not=20set=0D=0A#=20CONFIG_ADVANTECH_EC_WDT=20is=20not=20set=0D=
=0A#=20CONFIG_ALIM1535_WDT=20is=20not=20set=0D=0A#=20CONFIG_ALIM7101_WDT=20=
is=20not=20set=0D=0A#=20CONFIG_EBC_C384_WDT=20is=20not=20set=0D=0A#=20CONFI=
G_EXAR_WDT=20is=20not=20set=0D=0A#=20CONFIG_F71808E_WDT=20is=20not=20set=0D=
=0A#=20CONFIG_SP5100_TCO=20is=20not=20set=0D=0A#=20CONFIG_SBC_FITPC2_WATCHD=
OG=20is=20not=20set=0D=0A#=20CONFIG_EUROTECH_WDT=20is=20not=20set=0D=0A#=20=
CONFIG_IB700_WDT=20is=20not=20set=0D=0A#=20CONFIG_IBMASR=20is=20not=20set=
=0D=0A#=20CONFIG_WAFER_WDT=20is=20not=20set=0D=0A#=20CONFIG_I6300ESB_WDT=20=
is=20not=20set=0D=0A#=20CONFIG_IE6XX_WDT=20is=20not=20set=0D=0A#=20CONFIG_I=
NTEL_OC_WATCHDOG=20is=20not=20set=0D=0A#=20CONFIG_ITCO_WDT=20is=20not=20set=
=0D=0A#=20CONFIG_IT8712F_WDT=20is=20not=20set=0D=0A#=20CONFIG_IT87_WDT=20is=
=20not=20set=0D=0A#=20CONFIG_HP_WATCHDOG=20is=20not=20set=0D=0A#=20CONFIG_S=
C1200_WDT=20is=20not=20set=0D=0A#=20CONFIG_PC87413_WDT=20is=20not=20set=0D=
=0A#=20CONFIG_NV_TCO=20is=20not=20set=0D=0A#=20CONFIG_60XX_WDT=20is=20not=
=20set=0D=0A#=20CONFIG_SMSC_SCH311X_WDT=20is=20not=20set=0D=0A#=20CONFIG_SM=
SC37B787_WDT=20is=20not=20set=0D=0A#=20CONFIG_TQMX86_WDT=20is=20not=20set=
=0D=0A#=20CONFIG_VIA_WDT=20is=20not=20set=0D=0A#=20CONFIG_W83627HF_WDT=20is=
=20not=20set=0D=0A#=20CONFIG_W83877F_WDT=20is=20not=20set=0D=0A#=20CONFIG_W=
83977F_WDT=20is=20not=20set=0D=0A#=20CONFIG_MACHZ_WDT=20is=20not=20set=0D=
=0A#=20CONFIG_SBC_EPX_C3_WATCHDOG=20is=20not=20set=0D=0A#=20CONFIG_INTEL_ME=
I_WDT=20is=20not=20set=0D=0A#=20CONFIG_NI903X_WDT=20is=20not=20set=0D=0A#=
=20CONFIG_NIC7018_WDT=20is=20not=20set=0D=0A#=20CONFIG_MEN_A21_WDT=20is=20n=
ot=20set=0D=0A=0D=0A#=0D=0A#=20PCI-based=20Watchdog=20Cards=0D=0A#=0D=0A#=
=20CONFIG_PCIPCWATCHDOG=20is=20not=20set=0D=0A#=20CONFIG_WDTPCI=20is=20not=
=20set=0D=0A=0D=0A#=0D=0A#=20USB-based=20Watchdog=20Cards=0D=0A#=0D=0ACONFI=
G_USBPCWATCHDOG=3Dy=0D=0ACONFIG_SSB_POSSIBLE=3Dy=0D=0ACONFIG_SSB=3Dy=0D=0AC=
ONFIG_SSB_PCIHOST_POSSIBLE=3Dy=0D=0A#=20CONFIG_SSB_PCIHOST=20is=20not=20set=
=0D=0ACONFIG_SSB_PCMCIAHOST_POSSIBLE=3Dy=0D=0A#=20CONFIG_SSB_PCMCIAHOST=20i=
s=20not=20set=0D=0ACONFIG_SSB_SDIOHOST_POSSIBLE=3Dy=0D=0A#=20CONFIG_SSB_SDI=
OHOST=20is=20not=20set=0D=0A#=20CONFIG_SSB_DRIVER_GPIO=20is=20not=20set=0D=
=0ACONFIG_BCMA_POSSIBLE=3Dy=0D=0ACONFIG_BCMA=3Dy=0D=0ACONFIG_BCMA_HOST_PCI_=
POSSIBLE=3Dy=0D=0A#=20CONFIG_BCMA_HOST_PCI=20is=20not=20set=0D=0A#=20CONFIG=
_BCMA_HOST_SOC=20is=20not=20set=0D=0A#=20CONFIG_BCMA_DRIVER_PCI=20is=20not=
=20set=0D=0A#=20CONFIG_BCMA_DRIVER_GMAC_CMN=20is=20not=20set=0D=0A#=20CONFI=
G_BCMA_DRIVER_GPIO=20is=20not=20set=0D=0A#=20CONFIG_BCMA_DEBUG=20is=20not=
=20set=0D=0A=0D=0A#=0D=0A#=20Multifunction=20device=20drivers=0D=0A#=0D=0AC=
ONFIG_MFD_CORE=3Dy=0D=0A#=20CONFIG_MFD_ADP5585=20is=20not=20set=0D=0A#=20CO=
NFIG_MFD_ACT8945A=20is=20not=20set=0D=0A#=20CONFIG_MFD_AS3711=20is=20not=20=
set=0D=0A#=20CONFIG_MFD_SMPRO=20is=20not=20set=0D=0A#=20CONFIG_MFD_AS3722=
=20is=20not=20set=0D=0A#=20CONFIG_PMIC_ADP5520=20is=20not=20set=0D=0A#=20CO=
NFIG_MFD_AAT2870_CORE=20is=20not=20set=0D=0A#=20CONFIG_MFD_ATMEL_FLEXCOM=20=
is=20not=20set=0D=0A#=20CONFIG_MFD_ATMEL_HLCDC=20is=20not=20set=0D=0A#=20CO=
NFIG_MFD_BCM590XX=20is=20not=20set=0D=0A#=20CONFIG_MFD_BD9571MWV=20is=20not=
=20set=0D=0A#=20CONFIG_MFD_AXP20X_I2C=20is=20not=20set=0D=0A#=20CONFIG_MFD_=
CGBC=20is=20not=20set=0D=0ACONFIG_MFD_CROS_EC_DEV=3Dy=0D=0A#=20CONFIG_MFD_C=
S40L50_I2C=20is=20not=20set=0D=0A#=20CONFIG_MFD_CS40L50_SPI=20is=20not=20se=
t=0D=0A#=20CONFIG_MFD_CS42L43_I2C=20is=20not=20set=0D=0A#=20CONFIG_MFD_CS42=
L43_SDW=20is=20not=20set=0D=0A#=20CONFIG_MFD_LOCHNAGAR=20is=20not=20set=0D=
=0A#=20CONFIG_MFD_MADERA=20is=20not=20set=0D=0A#=20CONFIG_PMIC_DA903X=20is=
=20not=20set=0D=0A#=20CONFIG_MFD_DA9052_SPI=20is=20not=20set=0D=0A#=20CONFI=
G_MFD_DA9052_I2C=20is=20not=20set=0D=0A#=20CONFIG_MFD_DA9055=20is=20not=20s=
et=0D=0A#=20CONFIG_MFD_DA9062=20is=20not=20set=0D=0A#=20CONFIG_MFD_DA9063=
=20is=20not=20set=0D=0A#=20CONFIG_MFD_DA9150=20is=20not=20set=0D=0ACONFIG_M=
FD_DLN2=3Dy=0D=0A#=20CONFIG_MFD_GATEWORKS_GSC=20is=20not=20set=0D=0A#=20CON=
FIG_MFD_MC13XXX_SPI=20is=20not=20set=0D=0A#=20CONFIG_MFD_MC13XXX_I2C=20is=
=20not=20set=0D=0A#=20CONFIG_MFD_MP2629=20is=20not=20set=0D=0A#=20CONFIG_MF=
D_HI6421_PMIC=20is=20not=20set=0D=0A#=20CONFIG_MFD_INTEL_QUARK_I2C_GPIO=20i=
s=20not=20set=0D=0A#=20CONFIG_LPC_ICH=20is=20not=20set=0D=0A#=20CONFIG_LPC_=
SCH=20is=20not=20set=0D=0A#=20CONFIG_INTEL_SOC_PMIC=20is=20not=20set=0D=0AC=
ONFIG_INTEL_SOC_PMIC_BXTWC=3Dy=0D=0ACONFIG_INTEL_SOC_PMIC_CHTWC=3Dy=0D=0A#=
=20CONFIG_INTEL_SOC_PMIC_CHTDC_TI=20is=20not=20set=0D=0A#=20CONFIG_MFD_INTE=
L_LPSS_ACPI=20is=20not=20set=0D=0A#=20CONFIG_MFD_INTEL_LPSS_PCI=20is=20not=
=20set=0D=0ACONFIG_MFD_INTEL_PMC_BXT=3Dy=0D=0A#=20CONFIG_MFD_IQS62X=20is=20=
not=20set=0D=0A#=20CONFIG_MFD_JANZ_CMODIO=20is=20not=20set=0D=0A#=20CONFIG_=
MFD_KEMPLD=20is=20not=20set=0D=0A#=20CONFIG_MFD_88PM800=20is=20not=20set=0D=
=0A#=20CONFIG_MFD_88PM805=20is=20not=20set=0D=0A#=20CONFIG_MFD_88PM860X=20i=
s=20not=20set=0D=0A#=20CONFIG_MFD_88PM886_PMIC=20is=20not=20set=0D=0A#=20CO=
NFIG_MFD_MAX5970=20is=20not=20set=0D=0A#=20CONFIG_MFD_MAX14577=20is=20not=
=20set=0D=0A#=20CONFIG_MFD_MAX77541=20is=20not=20set=0D=0A#=20CONFIG_MFD_MA=
X77620=20is=20not=20set=0D=0A#=20CONFIG_MFD_MAX77650=20is=20not=20set=0D=0A=
#=20CONFIG_MFD_MAX77686=20is=20not=20set=0D=0A#=20CONFIG_MFD_MAX77693=20is=
=20not=20set=0D=0A#=20CONFIG_MFD_MAX77705=20is=20not=20set=0D=0A#=20CONFIG_=
MFD_MAX77714=20is=20not=20set=0D=0A#=20CONFIG_MFD_MAX77759=20is=20not=20set=
=0D=0A#=20CONFIG_MFD_MAX77843=20is=20not=20set=0D=0A#=20CONFIG_MFD_MAX8907=
=20is=20not=20set=0D=0A#=20CONFIG_MFD_MAX8925=20is=20not=20set=0D=0A#=20CON=
FIG_MFD_MAX8997=20is=20not=20set=0D=0A#=20CONFIG_MFD_MAX8998=20is=20not=20s=
et=0D=0ACONFIG_MFD_MT6360=3Dy=0D=0ACONFIG_MFD_MT6370=3Dy=0D=0A#=20CONFIG_MF=
D_MT6397=20is=20not=20set=0D=0A#=20CONFIG_MFD_MENF21BMC=20is=20not=20set=0D=
=0A#=20CONFIG_MFD_NCT6694=20is=20not=20set=0D=0A#=20CONFIG_MFD_OCELOT=20is=
=20not=20set=0D=0A#=20CONFIG_EZX_PCAP=20is=20not=20set=0D=0A#=20CONFIG_MFD_=
CPCAP=20is=20not=20set=0D=0ACONFIG_MFD_VIPERBOARD=3Dy=0D=0A#=20CONFIG_MFD_N=
TXEC=20is=20not=20set=0D=0ACONFIG_MFD_RETU=3Dy=0D=0A#=20CONFIG_MFD_SY7636A=
=20is=20not=20set=0D=0A#=20CONFIG_MFD_RDC321X=20is=20not=20set=0D=0A#=20CON=
FIG_MFD_RT4831=20is=20not=20set=0D=0A#=20CONFIG_MFD_RT5033=20is=20not=20set=
=0D=0A#=20CONFIG_MFD_RT5120=20is=20not=20set=0D=0A#=20CONFIG_MFD_RC5T583=20=
is=20not=20set=0D=0A#=20CONFIG_MFD_RK8XX_I2C=20is=20not=20set=0D=0A#=20CONF=
IG_MFD_RK8XX_SPI=20is=20not=20set=0D=0A#=20CONFIG_MFD_RN5T618=20is=20not=20=
set=0D=0A#=20CONFIG_MFD_SEC_I2C=20is=20not=20set=0D=0A#=20CONFIG_MFD_SI476X=
_CORE=20is=20not=20set=0D=0A#=20CONFIG_MFD_SM501=20is=20not=20set=0D=0A#=20=
CONFIG_MFD_SKY81452=20is=20not=20set=0D=0A#=20CONFIG_MFD_STMPE=20is=20not=
=20set=0D=0ACONFIG_MFD_SYSCON=3Dy=0D=0A#=20CONFIG_MFD_LP3943=20is=20not=20s=
et=0D=0A#=20CONFIG_MFD_LP8788=20is=20not=20set=0D=0A#=20CONFIG_MFD_TI_LMU=
=20is=20not=20set=0D=0A#=20CONFIG_MFD_BQ257XX=20is=20not=20set=0D=0A#=20CON=
FIG_MFD_PALMAS=20is=20not=20set=0D=0A#=20CONFIG_TPS6105X=20is=20not=20set=
=0D=0A#=20CONFIG_TPS65010=20is=20not=20set=0D=0A#=20CONFIG_TPS6507X=20is=20=
not=20set=0D=0A#=20CONFIG_MFD_TPS65086=20is=20not=20set=0D=0A#=20CONFIG_MFD=
_TPS65090=20is=20not=20set=0D=0A#=20CONFIG_MFD_TPS65217=20is=20not=20set=0D=
=0A#=20CONFIG_MFD_TI_LP873X=20is=20not=20set=0D=0A#=20CONFIG_MFD_TI_LP87565=
=20is=20not=20set=0D=0A#=20CONFIG_MFD_TPS65218=20is=20not=20set=0D=0A#=20CO=
NFIG_MFD_TPS65219=20is=20not=20set=0D=0A#=20CONFIG_MFD_TPS6586X=20is=20not=
=20set=0D=0A#=20CONFIG_MFD_TPS65910=20is=20not=20set=0D=0A#=20CONFIG_MFD_TP=
S65912_I2C=20is=20not=20set=0D=0A#=20CONFIG_MFD_TPS65912_SPI=20is=20not=20s=
et=0D=0A#=20CONFIG_MFD_TPS6594_I2C=20is=20not=20set=0D=0A#=20CONFIG_MFD_TPS=
6594_SPI=20is=20not=20set=0D=0ACONFIG_TWL4030_CORE=3Dy=0D=0A#=20CONFIG_MFD_=
TWL4030_AUDIO=20is=20not=20set=0D=0A#=20CONFIG_TWL6040_CORE=20is=20not=20se=
t=0D=0A#=20CONFIG_MFD_WL1273_CORE=20is=20not=20set=0D=0A#=20CONFIG_MFD_LM35=
33=20is=20not=20set=0D=0A#=20CONFIG_MFD_TC3589X=20is=20not=20set=0D=0A#=20C=
ONFIG_MFD_TQMX86=20is=20not=20set=0D=0A#=20CONFIG_MFD_VX855=20is=20not=20se=
t=0D=0A#=20CONFIG_MFD_ARIZONA_I2C=20is=20not=20set=0D=0A#=20CONFIG_MFD_ARIZ=
ONA_SPI=20is=20not=20set=0D=0A#=20CONFIG_MFD_WM8400=20is=20not=20set=0D=0A#=
=20CONFIG_MFD_WM831X_I2C=20is=20not=20set=0D=0A#=20CONFIG_MFD_WM831X_SPI=20=
is=20not=20set=0D=0A#=20CONFIG_MFD_WM8350_I2C=20is=20not=20set=0D=0A#=20CON=
FIG_MFD_WM8994=20is=20not=20set=0D=0A#=20CONFIG_MFD_ROHM_BD718XX=20is=20not=
=20set=0D=0A#=20CONFIG_MFD_ROHM_BD71828=20is=20not=20set=0D=0A#=20CONFIG_MF=
D_ROHM_BD957XMUF=20is=20not=20set=0D=0A#=20CONFIG_MFD_ROHM_BD96801=20is=20n=
ot=20set=0D=0A#=20CONFIG_MFD_STPMIC1=20is=20not=20set=0D=0A#=20CONFIG_MFD_S=
TMFX=20is=20not=20set=0D=0A#=20CONFIG_MFD_ATC260X_I2C=20is=20not=20set=0D=
=0A#=20CONFIG_MFD_QCOM_PM8008=20is=20not=20set=0D=0A#=20CONFIG_RAVE_SP_CORE=
=20is=20not=20set=0D=0A#=20CONFIG_MFD_INTEL_M10_BMC_SPI=20is=20not=20set=0D=
=0A#=20CONFIG_MFD_QNAP_MCU=20is=20not=20set=0D=0A#=20CONFIG_MFD_RSMU_I2C=20=
is=20not=20set=0D=0A#=20CONFIG_MFD_RSMU_SPI=20is=20not=20set=0D=0A#=20CONFI=
G_MFD_UPBOARD_FPGA=20is=20not=20set=0D=0A#=20CONFIG_MFD_MAX7360=20is=20not=
=20set=0D=0A#=20end=20of=20Multifunction=20device=20drivers=0D=0A=0D=0ACONF=
IG_REGULATOR=3Dy=0D=0A#=20CONFIG_REGULATOR_DEBUG=20is=20not=20set=0D=0ACONF=
IG_REGULATOR_FIXED_VOLTAGE=3Dy=0D=0A#=20CONFIG_REGULATOR_VIRTUAL_CONSUMER=
=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_USERSPACE_CONSUMER=20is=20not=
=20set=0D=0A#=20CONFIG_REGULATOR_NETLINK_EVENTS=20is=20not=20set=0D=0A#=20C=
ONFIG_REGULATOR_88PG86X=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_ACT8865=
=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_AD5398=20is=20not=20set=0D=0A#=
=20CONFIG_REGULATOR_ADP5055=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_AW37=
503=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_CROS_EC=20is=20not=20set=0D=
=0A#=20CONFIG_REGULATOR_DA9121=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_D=
A9210=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_DA9211=20is=20not=20set=0D=
=0A#=20CONFIG_REGULATOR_FAN53555=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR=
_FAN53880=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_GPIO=20is=20not=20set=
=0D=0A#=20CONFIG_REGULATOR_ISL9305=20is=20not=20set=0D=0A#=20CONFIG_REGULAT=
OR_ISL6271A=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_LP3971=20is=20not=20=
set=0D=0A#=20CONFIG_REGULATOR_LP3972=20is=20not=20set=0D=0A#=20CONFIG_REGUL=
ATOR_LP872X=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_LP8755=20is=20not=20=
set=0D=0A#=20CONFIG_REGULATOR_LTC3589=20is=20not=20set=0D=0A#=20CONFIG_REGU=
LATOR_LTC3676=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_MAX1586=20is=20not=
=20set=0D=0A#=20CONFIG_REGULATOR_MAX77503=20is=20not=20set=0D=0A#=20CONFIG_=
REGULATOR_MAX77857=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_MAX8649=20is=
=20not=20set=0D=0A#=20CONFIG_REGULATOR_MAX8660=20is=20not=20set=0D=0A#=20CO=
NFIG_REGULATOR_MAX8893=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_MAX8952=
=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_MAX20086=20is=20not=20set=0D=0A=
#=20CONFIG_REGULATOR_MAX20411=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_MA=
X77826=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_MAX77838=20is=20not=20set=
=0D=0A#=20CONFIG_REGULATOR_MCP16502=20is=20not=20set=0D=0A#=20CONFIG_REGULA=
TOR_MP5416=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_MP8859=20is=20not=20s=
et=0D=0A#=20CONFIG_REGULATOR_MP886X=20is=20not=20set=0D=0A#=20CONFIG_REGULA=
TOR_MPQ7920=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_MT6311=20is=20not=20=
set=0D=0A#=20CONFIG_REGULATOR_MT6360=20is=20not=20set=0D=0A#=20CONFIG_REGUL=
ATOR_MT6370=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_PCA9450=20is=20not=
=20set=0D=0A#=20CONFIG_REGULATOR_PF9453=20is=20not=20set=0D=0A#=20CONFIG_RE=
GULATOR_PF0900=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_PF530X=20is=20not=
=20set=0D=0A#=20CONFIG_REGULATOR_PF8X00=20is=20not=20set=0D=0A#=20CONFIG_RE=
GULATOR_PFUZE100=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_PV88060=20is=20=
not=20set=0D=0A#=20CONFIG_REGULATOR_PV88080=20is=20not=20set=0D=0A#=20CONFI=
G_REGULATOR_PV88090=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_RAA215300=20=
is=20not=20set=0D=0A#=20CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=20i=
s=20not=20set=0D=0A#=20CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2=20is=20n=
ot=20set=0D=0A#=20CONFIG_REGULATOR_RT4801=20is=20not=20set=0D=0A#=20CONFIG_=
REGULATOR_RT4803=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_RT5133=20is=20n=
ot=20set=0D=0A#=20CONFIG_REGULATOR_RT5190A=20is=20not=20set=0D=0A#=20CONFIG=
_REGULATOR_RT5739=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_RT5759=20is=20=
not=20set=0D=0A#=20CONFIG_REGULATOR_RT6160=20is=20not=20set=0D=0A#=20CONFIG=
_REGULATOR_RT6190=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_RT6245=20is=20=
not=20set=0D=0A#=20CONFIG_REGULATOR_RTQ2134=20is=20not=20set=0D=0A#=20CONFI=
G_REGULATOR_RTMV20=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_RTQ6752=20is=
=20not=20set=0D=0A#=20CONFIG_REGULATOR_RTQ2208=20is=20not=20set=0D=0A#=20CO=
NFIG_REGULATOR_SLG51000=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_SY8106A=
=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_SY8824X=20is=20not=20set=0D=0A#=
=20CONFIG_REGULATOR_SY8827N=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_TPS5=
1632=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_TPS62360=20is=20not=20set=
=0D=0A#=20CONFIG_REGULATOR_TPS6286X=20is=20not=20set=0D=0A#=20CONFIG_REGULA=
TOR_TPS6287X=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_TPS65023=20is=20not=
=20set=0D=0A#=20CONFIG_REGULATOR_TPS6507X=20is=20not=20set=0D=0A#=20CONFIG_=
REGULATOR_TPS65132=20is=20not=20set=0D=0A#=20CONFIG_REGULATOR_TPS6524X=20is=
=20not=20set=0D=0ACONFIG_REGULATOR_TWL4030=3Dy=0D=0A#=20CONFIG_REGULATOR_VC=
TRL=20is=20not=20set=0D=0ACONFIG_RC_CORE=3Dy=0D=0A#=20CONFIG_LIRC=20is=20no=
t=20set=0D=0A#=20CONFIG_RC_MAP=20is=20not=20set=0D=0A#=20CONFIG_RC_DECODERS=
=20is=20not=20set=0D=0ACONFIG_RC_DEVICES=3Dy=0D=0A#=20CONFIG_IR_ENE=20is=20=
not=20set=0D=0A#=20CONFIG_IR_FINTEK=20is=20not=20set=0D=0A#=20CONFIG_IR_GPI=
O_CIR=20is=20not=20set=0D=0A#=20CONFIG_IR_HIX5HD2=20is=20not=20set=0D=0ACON=
FIG_IR_IGORPLUGUSB=3Dy=0D=0ACONFIG_IR_IGUANA=3Dy=0D=0ACONFIG_IR_IMON=3Dy=0D=
=0ACONFIG_IR_IMON_RAW=3Dy=0D=0A#=20CONFIG_IR_ITE_CIR=20is=20not=20set=0D=0A=
CONFIG_IR_MCEUSB=3Dy=0D=0A#=20CONFIG_IR_NUVOTON=20is=20not=20set=0D=0ACONFI=
G_IR_REDRAT3=3Dy=0D=0A#=20CONFIG_IR_SERIAL=20is=20not=20set=0D=0ACONFIG_IR_=
STREAMZAP=3Dy=0D=0ACONFIG_IR_TOY=3Dy=0D=0ACONFIG_IR_TTUSBIR=3Dy=0D=0A#=20CO=
NFIG_IR_WINBOND_CIR=20is=20not=20set=0D=0ACONFIG_RC_ATI_REMOTE=3Dy=0D=0A#=
=20CONFIG_RC_LOOPBACK=20is=20not=20set=0D=0ACONFIG_RC_XBOX_DVD=3Dy=0D=0ACON=
FIG_CEC_CORE=3Dy=0D=0A=0D=0A#=0D=0A#=20CEC=20support=0D=0A#=0D=0A#=20CONFIG=
_MEDIA_CEC_RC=20is=20not=20set=0D=0ACONFIG_MEDIA_CEC_SUPPORT=3Dy=0D=0A#=20C=
ONFIG_CEC_CH7322=20is=20not=20set=0D=0A#=20CONFIG_CEC_NXP_TDA9950=20is=20no=
t=20set=0D=0A#=20CONFIG_CEC_CROS_EC=20is=20not=20set=0D=0A#=20CONFIG_CEC_GP=
IO=20is=20not=20set=0D=0A#=20CONFIG_CEC_SECO=20is=20not=20set=0D=0A#=20CONF=
IG_USB_EXTRON_DA_HD_4K_PLUS_CEC=20is=20not=20set=0D=0ACONFIG_USB_PULSE8_CEC=
=3Dy=0D=0ACONFIG_USB_RAINSHADOW_CEC=3Dy=0D=0A#=20end=20of=20CEC=20support=
=0D=0A=0D=0ACONFIG_MEDIA_SUPPORT=3Dy=0D=0A#=20CONFIG_MEDIA_SUPPORT_FILTER=
=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_SUBDRV_AUTOSELECT=20is=20not=20set=
=0D=0A=0D=0A#=0D=0A#=20Media=20device=20types=0D=0A#=0D=0ACONFIG_MEDIA_CAME=
RA_SUPPORT=3Dy=0D=0ACONFIG_MEDIA_ANALOG_TV_SUPPORT=3Dy=0D=0ACONFIG_MEDIA_DI=
GITAL_TV_SUPPORT=3Dy=0D=0ACONFIG_MEDIA_RADIO_SUPPORT=3Dy=0D=0ACONFIG_MEDIA_=
SDR_SUPPORT=3Dy=0D=0ACONFIG_MEDIA_PLATFORM_SUPPORT=3Dy=0D=0ACONFIG_MEDIA_TE=
ST_SUPPORT=3Dy=0D=0A#=20end=20of=20Media=20device=20types=0D=0A=0D=0A#=0D=
=0A#=20Media=20core=20support=0D=0A#=0D=0ACONFIG_VIDEO_DEV=3Dy=0D=0ACONFIG_=
MEDIA_CONTROLLER=3Dy=0D=0ACONFIG_DVB_CORE=3Dy=0D=0A#=20end=20of=20Media=20c=
ore=20support=0D=0A=0D=0A#=0D=0A#=20Video4Linux=20options=0D=0A#=0D=0ACONFI=
G_VIDEO_V4L2_I2C=3Dy=0D=0A#=20CONFIG_VIDEO_ADV_DEBUG=20is=20not=20set=0D=0A=
#=20CONFIG_VIDEO_FIXED_MINOR_RANGES=20is=20not=20set=0D=0ACONFIG_VIDEO_TUNE=
R=3Dy=0D=0A#=20end=20of=20Video4Linux=20options=0D=0A=0D=0A#=0D=0A#=20Media=
=20controller=20options=0D=0A#=0D=0ACONFIG_MEDIA_CONTROLLER_DVB=3Dy=0D=0A#=
=20end=20of=20Media=20controller=20options=0D=0A=0D=0A#=0D=0A#=20Digital=20=
TV=20options=0D=0A#=0D=0A#=20CONFIG_DVB_MMAP=20is=20not=20set=0D=0A#=20CONF=
IG_DVB_NET=20is=20not=20set=0D=0ACONFIG_DVB_MAX_ADAPTERS=3D16=0D=0A#=20CONF=
IG_DVB_DYNAMIC_MINORS=20is=20not=20set=0D=0A#=20CONFIG_DVB_DEMUX_SECTION_LO=
SS_LOG=20is=20not=20set=0D=0A#=20CONFIG_DVB_ULE_DEBUG=20is=20not=20set=0D=
=0A#=20end=20of=20Digital=20TV=20options=0D=0A=0D=0A#=0D=0A#=20Media=20driv=
ers=0D=0A#=0D=0A=0D=0A#=0D=0A#=20Media=20drivers=0D=0A#=0D=0ACONFIG_MEDIA_U=
SB_SUPPORT=3Dy=0D=0A=0D=0A#=0D=0A#=20Webcam=20devices=0D=0A#=0D=0ACONFIG_US=
B_GSPCA=3Dy=0D=0ACONFIG_USB_GSPCA_BENQ=3Dy=0D=0ACONFIG_USB_GSPCA_CONEX=3Dy=
=0D=0ACONFIG_USB_GSPCA_CPIA1=3Dy=0D=0ACONFIG_USB_GSPCA_DTCS033=3Dy=0D=0ACON=
FIG_USB_GSPCA_ETOMS=3Dy=0D=0ACONFIG_USB_GSPCA_FINEPIX=3Dy=0D=0ACONFIG_USB_G=
SPCA_JEILINJ=3Dy=0D=0ACONFIG_USB_GSPCA_JL2005BCD=3Dy=0D=0ACONFIG_USB_GSPCA_=
KINECT=3Dy=0D=0ACONFIG_USB_GSPCA_KONICA=3Dy=0D=0ACONFIG_USB_GSPCA_MARS=3Dy=
=0D=0ACONFIG_USB_GSPCA_MR97310A=3Dy=0D=0ACONFIG_USB_GSPCA_NW80X=3Dy=0D=0ACO=
NFIG_USB_GSPCA_OV519=3Dy=0D=0ACONFIG_USB_GSPCA_OV534=3Dy=0D=0ACONFIG_USB_GS=
PCA_OV534_9=3Dy=0D=0ACONFIG_USB_GSPCA_PAC207=3Dy=0D=0ACONFIG_USB_GSPCA_PAC7=
302=3Dy=0D=0ACONFIG_USB_GSPCA_PAC7311=3Dy=0D=0ACONFIG_USB_GSPCA_SE401=3Dy=
=0D=0ACONFIG_USB_GSPCA_SN9C2028=3Dy=0D=0ACONFIG_USB_GSPCA_SN9C20X=3Dy=0D=0A=
CONFIG_USB_GSPCA_SONIXB=3Dy=0D=0ACONFIG_USB_GSPCA_SONIXJ=3Dy=0D=0ACONFIG_US=
B_GSPCA_SPCA1528=3Dy=0D=0ACONFIG_USB_GSPCA_SPCA500=3Dy=0D=0ACONFIG_USB_GSPC=
A_SPCA501=3Dy=0D=0ACONFIG_USB_GSPCA_SPCA505=3Dy=0D=0ACONFIG_USB_GSPCA_SPCA5=
06=3Dy=0D=0ACONFIG_USB_GSPCA_SPCA508=3Dy=0D=0ACONFIG_USB_GSPCA_SPCA561=3Dy=
=0D=0ACONFIG_USB_GSPCA_SQ905=3Dy=0D=0ACONFIG_USB_GSPCA_SQ905C=3Dy=0D=0ACONF=
IG_USB_GSPCA_SQ930X=3Dy=0D=0ACONFIG_USB_GSPCA_STK014=3Dy=0D=0ACONFIG_USB_GS=
PCA_STK1135=3Dy=0D=0ACONFIG_USB_GSPCA_STV0680=3Dy=0D=0ACONFIG_USB_GSPCA_SUN=
PLUS=3Dy=0D=0ACONFIG_USB_GSPCA_T613=3Dy=0D=0ACONFIG_USB_GSPCA_TOPRO=3Dy=0D=
=0ACONFIG_USB_GSPCA_TOUPTEK=3Dy=0D=0ACONFIG_USB_GSPCA_TV8532=3Dy=0D=0ACONFI=
G_USB_GSPCA_VC032X=3Dy=0D=0ACONFIG_USB_GSPCA_VICAM=3Dy=0D=0ACONFIG_USB_GSPC=
A_XIRLINK_CIT=3Dy=0D=0ACONFIG_USB_GSPCA_ZC3XX=3Dy=0D=0ACONFIG_USB_GL860=3Dy=
=0D=0ACONFIG_USB_M5602=3Dy=0D=0ACONFIG_USB_STV06XX=3Dy=0D=0ACONFIG_USB_PWC=
=3Dy=0D=0A#=20CONFIG_USB_PWC_DEBUG=20is=20not=20set=0D=0ACONFIG_USB_PWC_INP=
UT_EVDEV=3Dy=0D=0ACONFIG_USB_S2255=3Dy=0D=0ACONFIG_VIDEO_USBTV=3Dy=0D=0ACON=
FIG_USB_VIDEO_CLASS=3Dy=0D=0ACONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy=0D=0A=
=0D=0A#=0D=0A#=20Analog=20TV=20USB=20devices=0D=0A#=0D=0ACONFIG_VIDEO_GO700=
7=3Dy=0D=0ACONFIG_VIDEO_GO7007_USB=3Dy=0D=0ACONFIG_VIDEO_GO7007_LOADER=3Dy=
=0D=0ACONFIG_VIDEO_GO7007_USB_S2250_BOARD=3Dy=0D=0ACONFIG_VIDEO_HDPVR=3Dy=
=0D=0ACONFIG_VIDEO_PVRUSB2=3Dy=0D=0ACONFIG_VIDEO_PVRUSB2_SYSFS=3Dy=0D=0ACON=
FIG_VIDEO_PVRUSB2_DVB=3Dy=0D=0A#=20CONFIG_VIDEO_PVRUSB2_DEBUGIFC=20is=20not=
=20set=0D=0ACONFIG_VIDEO_STK1160=3Dy=0D=0A=0D=0A#=0D=0A#=20Analog/digital=
=20TV=20USB=20devices=0D=0A#=0D=0ACONFIG_VIDEO_AU0828=3Dy=0D=0ACONFIG_VIDEO=
_AU0828_V4L2=3Dy=0D=0ACONFIG_VIDEO_AU0828_RC=3Dy=0D=0ACONFIG_VIDEO_CX231XX=
=3Dy=0D=0ACONFIG_VIDEO_CX231XX_RC=3Dy=0D=0ACONFIG_VIDEO_CX231XX_ALSA=3Dy=0D=
=0ACONFIG_VIDEO_CX231XX_DVB=3Dy=0D=0A=0D=0A#=0D=0A#=20Digital=20TV=20USB=20=
devices=0D=0A#=0D=0ACONFIG_DVB_AS102=3Dy=0D=0ACONFIG_DVB_B2C2_FLEXCOP_USB=
=3Dy=0D=0A#=20CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG=20is=20not=20set=0D=0ACONFI=
G_DVB_USB_V2=3Dy=0D=0ACONFIG_DVB_USB_AF9015=3Dy=0D=0ACONFIG_DVB_USB_AF9035=
=3Dy=0D=0ACONFIG_DVB_USB_ANYSEE=3Dy=0D=0ACONFIG_DVB_USB_AU6610=3Dy=0D=0ACON=
FIG_DVB_USB_AZ6007=3Dy=0D=0ACONFIG_DVB_USB_CE6230=3Dy=0D=0ACONFIG_DVB_USB_D=
VBSKY=3Dy=0D=0ACONFIG_DVB_USB_EC168=3Dy=0D=0ACONFIG_DVB_USB_GL861=3Dy=0D=0A=
CONFIG_DVB_USB_LME2510=3Dy=0D=0ACONFIG_DVB_USB_MXL111SF=3Dy=0D=0ACONFIG_DVB=
_USB_RTL28XXU=3Dy=0D=0ACONFIG_DVB_USB_ZD1301=3Dy=0D=0ACONFIG_DVB_USB=3Dy=0D=
=0A#=20CONFIG_DVB_USB_DEBUG=20is=20not=20set=0D=0ACONFIG_DVB_USB_A800=3Dy=
=0D=0ACONFIG_DVB_USB_AF9005=3Dy=0D=0ACONFIG_DVB_USB_AF9005_REMOTE=3Dy=0D=0A=
CONFIG_DVB_USB_AZ6027=3Dy=0D=0ACONFIG_DVB_USB_CINERGY_T2=3Dy=0D=0ACONFIG_DV=
B_USB_CXUSB=3Dy=0D=0ACONFIG_DVB_USB_CXUSB_ANALOG=3Dy=0D=0ACONFIG_DVB_USB_DI=
B0700=3Dy=0D=0ACONFIG_DVB_USB_DIB3000MC=3Dy=0D=0ACONFIG_DVB_USB_DIBUSB_MB=
=3Dy=0D=0A#=20CONFIG_DVB_USB_DIBUSB_MB_FAULTY=20is=20not=20set=0D=0ACONFIG_=
DVB_USB_DIBUSB_MC=3Dy=0D=0ACONFIG_DVB_USB_DIGITV=3Dy=0D=0ACONFIG_DVB_USB_DT=
T200U=3Dy=0D=0ACONFIG_DVB_USB_DTV5100=3Dy=0D=0ACONFIG_DVB_USB_DW2102=3Dy=0D=
=0ACONFIG_DVB_USB_GP8PSK=3Dy=0D=0ACONFIG_DVB_USB_M920X=3Dy=0D=0ACONFIG_DVB_=
USB_NOVA_T_USB2=3Dy=0D=0ACONFIG_DVB_USB_OPERA1=3Dy=0D=0ACONFIG_DVB_USB_PCTV=
452E=3Dy=0D=0ACONFIG_DVB_USB_TECHNISAT_USB2=3Dy=0D=0ACONFIG_DVB_USB_TTUSB2=
=3Dy=0D=0ACONFIG_DVB_USB_UMT_010=3Dy=0D=0ACONFIG_DVB_USB_VP702X=3Dy=0D=0ACO=
NFIG_DVB_USB_VP7045=3Dy=0D=0ACONFIG_SMS_USB_DRV=3Dy=0D=0ACONFIG_DVB_TTUSB_B=
UDGET=3Dy=0D=0ACONFIG_DVB_TTUSB_DEC=3Dy=0D=0A=0D=0A#=0D=0A#=20Webcam,=20TV=
=20(analog/digital)=20USB=20devices=0D=0A#=0D=0ACONFIG_VIDEO_EM28XX=3Dy=0D=
=0ACONFIG_VIDEO_EM28XX_V4L2=3Dy=0D=0ACONFIG_VIDEO_EM28XX_ALSA=3Dy=0D=0ACONF=
IG_VIDEO_EM28XX_DVB=3Dy=0D=0ACONFIG_VIDEO_EM28XX_RC=3Dy=0D=0A=0D=0A#=0D=0A#=
=20Software=20defined=20radio=20USB=20devices=0D=0A#=0D=0ACONFIG_USB_AIRSPY=
=3Dy=0D=0ACONFIG_USB_HACKRF=3Dy=0D=0ACONFIG_USB_MSI2500=3Dy=0D=0ACONFIG_MED=
IA_PCI_SUPPORT=3Dy=0D=0A=0D=0A#=0D=0A#=20Media=20capture=20support=0D=0A#=
=0D=0A#=20CONFIG_VIDEO_SOLO6X10=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_TW58=
64=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_TW68=20is=20not=20set=0D=0A#=20CO=
NFIG_VIDEO_TW686X=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_ZORAN=20is=20not=
=20set=0D=0A=0D=0A#=0D=0A#=20Media=20capture/analog=20TV=20support=0D=0A#=
=0D=0A#=20CONFIG_VIDEO_DT3155=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_IVTV=
=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_HEXIUM_GEMINI=20is=20not=20set=0D=
=0A#=20CONFIG_VIDEO_HEXIUM_ORION=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_MXB=
=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Media=20capture/analog/hybrid=20TV=
=20support=0D=0A#=0D=0A#=20CONFIG_VIDEO_BT848=20is=20not=20set=0D=0A#=20CON=
FIG_VIDEO_CX18=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_CX23885=20is=20not=20=
set=0D=0A#=20CONFIG_VIDEO_CX25821=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_CX=
88=20is=20not=20set=0D=0ACONFIG_VIDEO_SAA7134=3Dy=0D=0A#=20CONFIG_VIDEO_SAA=
7134_ALSA=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_SAA7134_RC=20is=20not=20se=
t=0D=0A#=20CONFIG_VIDEO_SAA7134_DVB=20is=20not=20set=0D=0ACONFIG_VIDEO_SAA7=
134_GO7007=3Dy=0D=0A#=20CONFIG_VIDEO_SAA7164=20is=20not=20set=0D=0A=0D=0A#=
=0D=0A#=20Media=20digital=20TV=20PCI=20Adapters=0D=0A#=0D=0ACONFIG_DVB_B2C2=
_FLEXCOP_PCI=3Dy=0D=0A#=20CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG=20is=20not=20se=
t=0D=0A#=20CONFIG_DVB_DDBRIDGE=20is=20not=20set=0D=0A#=20CONFIG_DVB_DM1105=
=20is=20not=20set=0D=0A#=20CONFIG_MANTIS_CORE=20is=20not=20set=0D=0A#=20CON=
FIG_DVB_NETUP_UNIDVB=20is=20not=20set=0D=0A#=20CONFIG_DVB_NGENE=20is=20not=
=20set=0D=0A#=20CONFIG_DVB_PLUTO2=20is=20not=20set=0D=0A#=20CONFIG_DVB_PT1=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_PT3=20is=20not=20set=0D=0A#=20CONFIG_=
DVB_SMIPCIE=20is=20not=20set=0D=0A#=20CONFIG_DVB_BUDGET_CORE=20is=20not=20s=
et=0D=0A#=20CONFIG_VIDEO_IPU3_CIO2=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_I=
NTEL_IPU6=20is=20not=20set=0D=0A#=20CONFIG_INTEL_VSC=20is=20not=20set=0D=0A=
#=20CONFIG_IPU_BRIDGE=20is=20not=20set=0D=0ACONFIG_RADIO_ADAPTERS=3Dy=0D=0A=
#=20CONFIG_RADIO_MAXIRADIO=20is=20not=20set=0D=0A#=20CONFIG_RADIO_SAA7706H=
=20is=20not=20set=0D=0ACONFIG_RADIO_SHARK=3Dy=0D=0ACONFIG_RADIO_SHARK2=3Dy=
=0D=0ACONFIG_RADIO_SI4713=3Dy=0D=0ACONFIG_RADIO_TEA575X=3Dy=0D=0A#=20CONFIG=
_RADIO_TEA5764=20is=20not=20set=0D=0A#=20CONFIG_RADIO_TEF6862=20is=20not=20=
set=0D=0ACONFIG_USB_DSBR=3Dy=0D=0ACONFIG_USB_KEENE=3Dy=0D=0ACONFIG_USB_MA90=
1=3Dy=0D=0ACONFIG_USB_MR800=3Dy=0D=0ACONFIG_USB_RAREMONO=3Dy=0D=0ACONFIG_RA=
DIO_SI470X=3Dy=0D=0ACONFIG_USB_SI470X=3Dy=0D=0A#=20CONFIG_I2C_SI470X=20is=
=20not=20set=0D=0ACONFIG_USB_SI4713=3Dy=0D=0A#=20CONFIG_PLATFORM_SI4713=20i=
s=20not=20set=0D=0ACONFIG_I2C_SI4713=3Dy=0D=0A#=20CONFIG_MEDIA_PLATFORM_DRI=
VERS=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20MMC/SDIO=20DVB=20adapters=0D=0A=
#=0D=0ACONFIG_SMS_SDIO_DRV=3Dy=0D=0A#=20CONFIG_V4L_TEST_DRIVERS=20is=20not=
=20set=0D=0A#=20CONFIG_DVB_TEST_DRIVERS=20is=20not=20set=0D=0ACONFIG_MEDIA_=
COMMON_OPTIONS=3Dy=0D=0A=0D=0A#=0D=0A#=20common=20driver=20options=0D=0A#=
=0D=0ACONFIG_CYPRESS_FIRMWARE=3Dy=0D=0ACONFIG_TTPCI_EEPROM=3Dy=0D=0ACONFIG_=
UVC_COMMON=3Dy=0D=0ACONFIG_VIDEO_CX2341X=3Dy=0D=0ACONFIG_VIDEO_TVEEPROM=3Dy=
=0D=0ACONFIG_DVB_B2C2_FLEXCOP=3Dy=0D=0ACONFIG_SMS_SIANO_MDTV=3Dy=0D=0ACONFI=
G_SMS_SIANO_RC=3Dy=0D=0ACONFIG_SMS_SIANO_DEBUGFS=3Dy=0D=0ACONFIG_VIDEOBUF2_=
CORE=3Dy=0D=0ACONFIG_VIDEOBUF2_V4L2=3Dy=0D=0ACONFIG_VIDEOBUF2_MEMOPS=3Dy=0D=
=0ACONFIG_VIDEOBUF2_VMALLOC=3Dy=0D=0ACONFIG_VIDEOBUF2_DMA_SG=3Dy=0D=0A#=20e=
nd=20of=20Media=20drivers=0D=0A=0D=0A#=0D=0A#=20Media=20ancillary=20drivers=
=0D=0A#=0D=0ACONFIG_MEDIA_ATTACH=3Dy=0D=0A#=20CONFIG_VIDEO_IR_I2C=20is=20no=
t=20set=0D=0A#=20CONFIG_VIDEO_CAMERA_SENSOR=20is=20not=20set=0D=0A=0D=0A#=
=0D=0A#=20Camera=20ISPs=0D=0A#=0D=0A#=20CONFIG_VIDEO_THP7312=20is=20not=20s=
et=0D=0A#=20end=20of=20Camera=20ISPs=0D=0A=0D=0A#=20CONFIG_VIDEO_CAMERA_LEN=
S=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Flash=20devices=0D=0A#=0D=0A#=20CO=
NFIG_VIDEO_ADP1653=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_LM3560=20is=20not=
=20set=0D=0A#=20CONFIG_VIDEO_LM3646=20is=20not=20set=0D=0A#=20end=20of=20Fl=
ash=20devices=0D=0A=0D=0A#=0D=0A#=20Audio=20decoders,=20processors=20and=20=
mixers=0D=0A#=0D=0A#=20CONFIG_VIDEO_CS3308=20is=20not=20set=0D=0A#=20CONFIG=
_VIDEO_CS5345=20is=20not=20set=0D=0ACONFIG_VIDEO_CS53L32A=3Dy=0D=0ACONFIG_V=
IDEO_MSP3400=3Dy=0D=0A#=20CONFIG_VIDEO_SONY_BTF_MPX=20is=20not=20set=0D=0A#=
=20CONFIG_VIDEO_TDA1997X=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_TDA7432=20i=
s=20not=20set=0D=0A#=20CONFIG_VIDEO_TDA9840=20is=20not=20set=0D=0A#=20CONFI=
G_VIDEO_TEA6415C=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_TEA6420=20is=20not=
=20set=0D=0A#=20CONFIG_VIDEO_TLV320AIC23B=20is=20not=20set=0D=0A#=20CONFIG_=
VIDEO_TVAUDIO=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_UDA1342=20is=20not=20s=
et=0D=0A#=20CONFIG_VIDEO_VP27SMPX=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_WM=
8739=20is=20not=20set=0D=0ACONFIG_VIDEO_WM8775=3Dy=0D=0A#=20end=20of=20Audi=
o=20decoders,=20processors=20and=20mixers=0D=0A=0D=0A#=0D=0A#=20RDS=20decod=
ers=0D=0A#=0D=0A#=20CONFIG_VIDEO_SAA6588=20is=20not=20set=0D=0A#=20end=20of=
=20RDS=20decoders=0D=0A=0D=0A#=0D=0A#=20Video=20decoders=0D=0A#=0D=0A#=20CO=
NFIG_VIDEO_ADV7180=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_ADV7183=20is=20no=
t=20set=0D=0A#=20CONFIG_VIDEO_ADV748X=20is=20not=20set=0D=0A#=20CONFIG_VIDE=
O_ADV7604=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_ADV7842=20is=20not=20set=
=0D=0A#=20CONFIG_VIDEO_BT819=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_BT856=
=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_BT866=20is=20not=20set=0D=0A#=20CON=
FIG_VIDEO_ISL7998X=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_LT6911UXE=20is=20=
not=20set=0D=0A#=20CONFIG_VIDEO_KS0127=20is=20not=20set=0D=0A#=20CONFIG_VID=
EO_MAX9286=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_ML86V7667=20is=20not=20se=
t=0D=0A#=20CONFIG_VIDEO_SAA7110=20is=20not=20set=0D=0ACONFIG_VIDEO_SAA711X=
=3Dy=0D=0A#=20CONFIG_VIDEO_TC358743=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_=
TC358746=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_TVP514X=20is=20not=20set=0D=
=0A#=20CONFIG_VIDEO_TVP5150=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_TVP7002=
=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_TW2804=20is=20not=20set=0D=0A#=20CO=
NFIG_VIDEO_TW9900=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_TW9903=20is=20not=
=20set=0D=0A#=20CONFIG_VIDEO_TW9906=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_=
TW9910=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_VPX3220=20is=20not=20set=0D=
=0A=0D=0A#=0D=0A#=20Video=20and=20audio=20decoders=0D=0A#=0D=0A#=20CONFIG_V=
IDEO_SAA717X=20is=20not=20set=0D=0ACONFIG_VIDEO_CX25840=3Dy=0D=0A#=20end=20=
of=20Video=20decoders=0D=0A=0D=0A#=0D=0A#=20Video=20encoders=0D=0A#=0D=0A#=
=20CONFIG_VIDEO_ADV7170=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_ADV7175=20is=
=20not=20set=0D=0A#=20CONFIG_VIDEO_ADV7343=20is=20not=20set=0D=0A#=20CONFIG=
_VIDEO_ADV7393=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_ADV7511=20is=20not=20=
set=0D=0A#=20CONFIG_VIDEO_AK881X=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_SAA=
7127=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_SAA7185=20is=20not=20set=0D=0A#=
=20CONFIG_VIDEO_THS8200=20is=20not=20set=0D=0A#=20end=20of=20Video=20encode=
rs=0D=0A=0D=0A#=0D=0A#=20Video=20improvement=20chips=0D=0A#=0D=0A#=20CONFIG=
_VIDEO_UPD64031A=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_UPD64083=20is=20not=
=20set=0D=0A#=20end=20of=20Video=20improvement=20chips=0D=0A=0D=0A#=0D=0A#=
=20Audio/Video=20compression=20chips=0D=0A#=0D=0A#=20CONFIG_VIDEO_SAA6752HS=
=20is=20not=20set=0D=0A#=20end=20of=20Audio/Video=20compression=20chips=0D=
=0A=0D=0A#=0D=0A#=20SDR=20tuner=20chips=0D=0A#=0D=0A#=20CONFIG_SDR_MAX2175=
=20is=20not=20set=0D=0A#=20end=20of=20SDR=20tuner=20chips=0D=0A=0D=0A#=0D=
=0A#=20Miscellaneous=20helper=20chips=0D=0A#=0D=0A#=20CONFIG_VIDEO_I2C=20is=
=20not=20set=0D=0A#=20CONFIG_VIDEO_M52790=20is=20not=20set=0D=0A#=20CONFIG_=
VIDEO_ST_MIPID02=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_THS7303=20is=20not=
=20set=0D=0A#=20end=20of=20Miscellaneous=20helper=20chips=0D=0A=0D=0A#=0D=
=0A#=20Video=20serializers=20and=20deserializers=0D=0A#=0D=0A#=20CONFIG_VID=
EO_DS90UB913=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_DS90UB953=20is=20not=20=
set=0D=0A#=20CONFIG_VIDEO_DS90UB960=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_=
MAX96714=20is=20not=20set=0D=0A#=20CONFIG_VIDEO_MAX96717=20is=20not=20set=
=0D=0A#=20end=20of=20Video=20serializers=20and=20deserializers=0D=0A=0D=0A#=
=0D=0A#=20Media=20SPI=20Adapters=0D=0A#=0D=0A#=20CONFIG_CXD2880_SPI_DRV=20i=
s=20not=20set=0D=0A#=20CONFIG_VIDEO_GS1662=20is=20not=20set=0D=0A#=20end=20=
of=20Media=20SPI=20Adapters=0D=0A=0D=0ACONFIG_MEDIA_TUNER=3Dy=0D=0A=0D=0A#=
=0D=0A#=20Customize=20TV=20tuners=0D=0A#=0D=0A#=20CONFIG_MEDIA_TUNER_E4000=
=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_FC0011=20is=20not=20set=0D=0A=
#=20CONFIG_MEDIA_TUNER_FC0012=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_=
FC0013=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_FC2580=20is=20not=20set=
=0D=0A#=20CONFIG_MEDIA_TUNER_IT913X=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_=
TUNER_M88RS6000T=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_MAX2165=20is=
=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_MC44S803=20is=20not=20set=0D=0ACON=
FIG_MEDIA_TUNER_MSI001=3Dy=0D=0A#=20CONFIG_MEDIA_TUNER_MT2060=20is=20not=20=
set=0D=0A#=20CONFIG_MEDIA_TUNER_MT2063=20is=20not=20set=0D=0A#=20CONFIG_MED=
IA_TUNER_MT20XX=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_MT2131=20is=20=
not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_MT2266=20is=20not=20set=0D=0A#=20CONF=
IG_MEDIA_TUNER_MXL301RF=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_MXL500=
5S=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_MXL5007T=20is=20not=20set=
=0D=0A#=20CONFIG_MEDIA_TUNER_QM1D1B0004=20is=20not=20set=0D=0A#=20CONFIG_ME=
DIA_TUNER_QM1D1C0042=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_QT1010=20=
is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_R820T=20is=20not=20set=0D=0A#=20=
CONFIG_MEDIA_TUNER_SI2157=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_SIMP=
LE=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_TDA18212=20is=20not=20set=
=0D=0A#=20CONFIG_MEDIA_TUNER_TDA18218=20is=20not=20set=0D=0A#=20CONFIG_MEDI=
A_TUNER_TDA18250=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_TDA18271=20is=
=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_TDA827X=20is=20not=20set=0D=0A#=20=
CONFIG_MEDIA_TUNER_TDA8290=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_TDA=
9887=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_TEA5761=20is=20not=20set=
=0D=0A#=20CONFIG_MEDIA_TUNER_TEA5767=20is=20not=20set=0D=0A#=20CONFIG_MEDIA=
_TUNER_TUA9001=20is=20not=20set=0D=0A#=20CONFIG_MEDIA_TUNER_XC2028=20is=20n=
ot=20set=0D=0A#=20CONFIG_MEDIA_TUNER_XC4000=20is=20not=20set=0D=0A#=20CONFI=
G_MEDIA_TUNER_XC5000=20is=20not=20set=0D=0A#=20end=20of=20Customize=20TV=20=
tuners=0D=0A=0D=0A#=0D=0A#=20Customise=20DVB=20Frontends=0D=0A#=0D=0A=0D=0A=
#=0D=0A#=20Multistandard=20(satellite)=20frontends=0D=0A#=0D=0A#=20CONFIG_D=
VB_M88DS3103=20is=20not=20set=0D=0A#=20CONFIG_DVB_MXL5XX=20is=20not=20set=
=0D=0A#=20CONFIG_DVB_STB0899=20is=20not=20set=0D=0A#=20CONFIG_DVB_STB6100=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_STV090x=20is=20not=20set=0D=0A#=20CON=
FIG_DVB_STV0910=20is=20not=20set=0D=0A#=20CONFIG_DVB_STV6110x=20is=20not=20=
set=0D=0A#=20CONFIG_DVB_STV6111=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Mult=
istandard=20(cable=20+=20terrestrial)=20frontends=0D=0A#=0D=0A#=20CONFIG_DV=
B_DRXK=20is=20not=20set=0D=0A#=20CONFIG_DVB_MN88472=20is=20not=20set=0D=0A#=
=20CONFIG_DVB_MN88473=20is=20not=20set=0D=0A#=20CONFIG_DVB_SI2165=20is=20no=
t=20set=0D=0A#=20CONFIG_DVB_TDA18271C2DD=20is=20not=20set=0D=0A=0D=0A#=0D=
=0A#=20DVB-S=20(satellite)=20frontends=0D=0A#=0D=0A#=20CONFIG_DVB_CX24110=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_CX24116=20is=20not=20set=0D=0A#=20CON=
FIG_DVB_CX24117=20is=20not=20set=0D=0A#=20CONFIG_DVB_CX24120=20is=20not=20s=
et=0D=0A#=20CONFIG_DVB_CX24123=20is=20not=20set=0D=0A#=20CONFIG_DVB_DS3000=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_MB86A16=20is=20not=20set=0D=0A#=20CON=
FIG_DVB_MT312=20is=20not=20set=0D=0A#=20CONFIG_DVB_S5H1420=20is=20not=20set=
=0D=0A#=20CONFIG_DVB_SI21XX=20is=20not=20set=0D=0A#=20CONFIG_DVB_STB6000=20=
is=20not=20set=0D=0A#=20CONFIG_DVB_STV0288=20is=20not=20set=0D=0A#=20CONFIG=
_DVB_STV0299=20is=20not=20set=0D=0A#=20CONFIG_DVB_STV0900=20is=20not=20set=
=0D=0A#=20CONFIG_DVB_STV6110=20is=20not=20set=0D=0A#=20CONFIG_DVB_TDA10071=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_TDA10086=20is=20not=20set=0D=0A#=20CO=
NFIG_DVB_TDA8083=20is=20not=20set=0D=0A#=20CONFIG_DVB_TDA8261=20is=20not=20=
set=0D=0A#=20CONFIG_DVB_TDA826X=20is=20not=20set=0D=0A#=20CONFIG_DVB_TS2020=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_TUA6100=20is=20not=20set=0D=0A#=20CON=
FIG_DVB_TUNER_CX24113=20is=20not=20set=0D=0A#=20CONFIG_DVB_TUNER_ITD1000=20=
is=20not=20set=0D=0A#=20CONFIG_DVB_VES1X93=20is=20not=20set=0D=0A#=20CONFIG=
_DVB_ZL10036=20is=20not=20set=0D=0A#=20CONFIG_DVB_ZL10039=20is=20not=20set=
=0D=0A=0D=0A#=0D=0A#=20DVB-T=20(terrestrial)=20frontends=0D=0A#=0D=0ACONFIG=
_DVB_AF9013=3Dy=0D=0ACONFIG_DVB_AS102_FE=3Dy=0D=0A#=20CONFIG_DVB_CX22700=20=
is=20not=20set=0D=0A#=20CONFIG_DVB_CX22702=20is=20not=20set=0D=0A#=20CONFIG=
_DVB_CXD2820R=20is=20not=20set=0D=0A#=20CONFIG_DVB_CXD2841ER=20is=20not=20s=
et=0D=0ACONFIG_DVB_DIB3000MB=3Dy=0D=0ACONFIG_DVB_DIB3000MC=3Dy=0D=0A#=20CON=
FIG_DVB_DIB7000M=20is=20not=20set=0D=0A#=20CONFIG_DVB_DIB7000P=20is=20not=
=20set=0D=0A#=20CONFIG_DVB_DIB9000=20is=20not=20set=0D=0A#=20CONFIG_DVB_DRX=
D=20is=20not=20set=0D=0ACONFIG_DVB_EC100=3Dy=0D=0ACONFIG_DVB_GP8PSK_FE=3Dy=
=0D=0A#=20CONFIG_DVB_L64781=20is=20not=20set=0D=0A#=20CONFIG_DVB_MT352=20is=
=20not=20set=0D=0A#=20CONFIG_DVB_NXT6000=20is=20not=20set=0D=0ACONFIG_DVB_R=
TL2830=3Dy=0D=0ACONFIG_DVB_RTL2832=3Dy=0D=0ACONFIG_DVB_RTL2832_SDR=3Dy=0D=
=0A#=20CONFIG_DVB_S5H1432=20is=20not=20set=0D=0A#=20CONFIG_DVB_SI2168=20is=
=20not=20set=0D=0A#=20CONFIG_DVB_SP887X=20is=20not=20set=0D=0A#=20CONFIG_DV=
B_STV0367=20is=20not=20set=0D=0A#=20CONFIG_DVB_TDA10048=20is=20not=20set=0D=
=0A#=20CONFIG_DVB_TDA1004X=20is=20not=20set=0D=0A#=20CONFIG_DVB_ZD1301_DEMO=
D=20is=20not=20set=0D=0ACONFIG_DVB_ZL10353=3Dy=0D=0A#=20CONFIG_DVB_CXD2880=
=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20DVB-C=20(cable)=20frontends=0D=0A#=
=0D=0A#=20CONFIG_DVB_STV0297=20is=20not=20set=0D=0A#=20CONFIG_DVB_TDA10021=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_TDA10023=20is=20not=20set=0D=0A#=20CO=
NFIG_DVB_VES1820=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20ATSC=20(North=20Ame=
rican/Korean=20Terrestrial/Cable=20DTV)=20frontends=0D=0A#=0D=0A#=20CONFIG_=
DVB_AU8522_DTV=20is=20not=20set=0D=0A#=20CONFIG_DVB_AU8522_V4L=20is=20not=
=20set=0D=0A#=20CONFIG_DVB_BCM3510=20is=20not=20set=0D=0A#=20CONFIG_DVB_LG2=
160=20is=20not=20set=0D=0A#=20CONFIG_DVB_LGDT3305=20is=20not=20set=0D=0A#=
=20CONFIG_DVB_LGDT3306A=20is=20not=20set=0D=0A#=20CONFIG_DVB_LGDT330X=20is=
=20not=20set=0D=0A#=20CONFIG_DVB_MXL692=20is=20not=20set=0D=0A#=20CONFIG_DV=
B_NXT200X=20is=20not=20set=0D=0A#=20CONFIG_DVB_OR51132=20is=20not=20set=0D=
=0A#=20CONFIG_DVB_OR51211=20is=20not=20set=0D=0A#=20CONFIG_DVB_S5H1409=20is=
=20not=20set=0D=0A#=20CONFIG_DVB_S5H1411=20is=20not=20set=0D=0A=0D=0A#=0D=
=0A#=20ISDB-T=20(terrestrial)=20frontends=0D=0A#=0D=0A#=20CONFIG_DVB_DIB800=
0=20is=20not=20set=0D=0A#=20CONFIG_DVB_MB86A20S=20is=20not=20set=0D=0A#=20C=
ONFIG_DVB_S921=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20ISDB-S=20(satellite)=
=20&=20ISDB-T=20(terrestrial)=20frontends=0D=0A#=0D=0A#=20CONFIG_DVB_MN8844=
3X=20is=20not=20set=0D=0A#=20CONFIG_DVB_TC90522=20is=20not=20set=0D=0A=0D=
=0A#=0D=0A#=20Digital=20terrestrial=20only=20tuners/PLL=0D=0A#=0D=0A#=20CON=
FIG_DVB_PLL=20is=20not=20set=0D=0A#=20CONFIG_DVB_TUNER_DIB0070=20is=20not=
=20set=0D=0A#=20CONFIG_DVB_TUNER_DIB0090=20is=20not=20set=0D=0A=0D=0A#=0D=
=0A#=20SEC=20control=20devices=20for=20DVB-S=0D=0A#=0D=0A#=20CONFIG_DVB_A82=
93=20is=20not=20set=0D=0ACONFIG_DVB_AF9033=3Dy=0D=0A#=20CONFIG_DVB_ASCOT2E=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_ATBM8830=20is=20not=20set=0D=0A#=20CO=
NFIG_DVB_HELENE=20is=20not=20set=0D=0A#=20CONFIG_DVB_HORUS3A=20is=20not=20s=
et=0D=0A#=20CONFIG_DVB_ISL6405=20is=20not=20set=0D=0A#=20CONFIG_DVB_ISL6421=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_ISL6423=20is=20not=20set=0D=0A#=20CON=
FIG_DVB_IX2505V=20is=20not=20set=0D=0A#=20CONFIG_DVB_LGS8GL5=20is=20not=20s=
et=0D=0A#=20CONFIG_DVB_LGS8GXX=20is=20not=20set=0D=0A#=20CONFIG_DVB_LNBH25=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_LNBH29=20is=20not=20set=0D=0A#=20CONF=
IG_DVB_LNBP21=20is=20not=20set=0D=0A#=20CONFIG_DVB_LNBP22=20is=20not=20set=
=0D=0A#=20CONFIG_DVB_M88RS2000=20is=20not=20set=0D=0A#=20CONFIG_DVB_TDA665x=
=20is=20not=20set=0D=0A#=20CONFIG_DVB_DRX39XYJ=20is=20not=20set=0D=0A=0D=0A=
#=0D=0A#=20Common=20Interface=20(EN50221)=20controller=20drivers=0D=0A#=0D=
=0A#=20CONFIG_DVB_CXD2099=20is=20not=20set=0D=0A#=20CONFIG_DVB_SP2=20is=20n=
ot=20set=0D=0A#=20end=20of=20Customise=20DVB=20Frontends=0D=0A=0D=0A#=0D=0A=
#=20Tools=20to=20develop=20new=20frontends=0D=0A#=0D=0A#=20CONFIG_DVB_DUMMY=
_FE=20is=20not=20set=0D=0A#=20end=20of=20Media=20ancillary=20drivers=0D=0A=
=0D=0A#=0D=0A#=20Graphics=20support=0D=0A#=0D=0ACONFIG_APERTURE_HELPERS=3Dy=
=0D=0ACONFIG_SCREEN_INFO=3Dy=0D=0ACONFIG_VIDEO=3Dy=0D=0A#=20CONFIG_AUXDISPL=
AY=20is=20not=20set=0D=0A#=20CONFIG_PANEL=20is=20not=20set=0D=0ACONFIG_AGP=
=3Dy=0D=0ACONFIG_AGP_AMD64=3Dy=0D=0ACONFIG_AGP_INTEL=3Dy=0D=0A#=20CONFIG_AG=
P_SIS=20is=20not=20set=0D=0A#=20CONFIG_AGP_VIA=20is=20not=20set=0D=0ACONFIG=
_INTEL_GTT=3Dy=0D=0A#=20CONFIG_VGA_SWITCHEROO=20is=20not=20set=0D=0ACONFIG_=
DRM=3Dy=0D=0A=0D=0A#=0D=0A#=20DRM=20debugging=20options=0D=0A#=0D=0A#=20CON=
FIG_DRM_WERROR=20is=20not=20set=0D=0A#=20CONFIG_DRM_DEBUG_MM=20is=20not=20s=
et=0D=0A#=20end=20of=20DRM=20debugging=20options=0D=0A=0D=0ACONFIG_DRM_MIPI=
_DSI=3Dy=0D=0ACONFIG_DRM_KMS_HELPER=3Dy=0D=0A#=20CONFIG_DRM_PANIC=20is=20no=
t=20set=0D=0A#=20CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=20is=20not=20set=0D=
=0A#=20CONFIG_DRM_DEBUG_MODESET_LOCK=20is=20not=20set=0D=0ACONFIG_DRM_CLIEN=
T_SELECTION=3Dy=0D=0A=0D=0A#=0D=0A#=20Supported=20DRM=20clients=0D=0A#=0D=
=0A#=20CONFIG_DRM_FBDEV_EMULATION=20is=20not=20set=0D=0A#=20CONFIG_DRM_CLIE=
NT_LOG=20is=20not=20set=0D=0A#=20end=20of=20Supported=20DRM=20clients=0D=0A=
=0D=0A#=20CONFIG_DRM_LOAD_EDID_FIRMWARE=20is=20not=20set=0D=0ACONFIG_DRM_DI=
SPLAY_HELPER=3Dy=0D=0A#=20CONFIG_DRM_DISPLAY_DP_AUX_CEC=20is=20not=20set=0D=
=0A#=20CONFIG_DRM_DISPLAY_DP_AUX_CHARDEV=20is=20not=20set=0D=0ACONFIG_DRM_D=
ISPLAY_DP_HELPER=3Dy=0D=0ACONFIG_DRM_DISPLAY_DSC_HELPER=3Dy=0D=0ACONFIG_DRM=
_DISPLAY_HDCP_HELPER=3Dy=0D=0ACONFIG_DRM_DISPLAY_HDMI_HELPER=3Dy=0D=0ACONFI=
G_DRM_TTM=3Dy=0D=0ACONFIG_DRM_BUDDY=3Dy=0D=0ACONFIG_DRM_GEM_SHMEM_HELPER=3D=
y=0D=0A=0D=0A#=0D=0A#=20Drivers=20for=20system=20framebuffers=0D=0A#=0D=0A#=
=20CONFIG_DRM_SIMPLEDRM=20is=20not=20set=0D=0A#=20CONFIG_DRM_VESADRM=20is=
=20not=20set=0D=0A#=20end=20of=20Drivers=20for=20system=20framebuffers=0D=
=0A=0D=0A#=0D=0A#=20ARM=20devices=0D=0A#=0D=0A#=20CONFIG_DRM_KOMEDA=20is=20=
not=20set=0D=0A#=20end=20of=20ARM=20devices=0D=0A=0D=0A#=20CONFIG_DRM_RADEO=
N=20is=20not=20set=0D=0A#=20CONFIG_DRM_AMDGPU=20is=20not=20set=0D=0A#=20CON=
FIG_DRM_NOUVEAU=20is=20not=20set=0D=0ACONFIG_DRM_I915=3Dy=0D=0ACONFIG_DRM_I=
915_FORCE_PROBE=3D""=0D=0ACONFIG_DRM_I915_CAPTURE_ERROR=3Dy=0D=0ACONFIG_DRM=
_I915_COMPRESS_ERROR=3Dy=0D=0ACONFIG_DRM_I915_USERPTR=3Dy=0D=0A=0D=0A#=0D=
=0A#=20drm/i915=20Debugging=0D=0A#=0D=0A#=20CONFIG_DRM_I915_WERROR=20is=20n=
ot=20set=0D=0A#=20CONFIG_DRM_I915_REPLAY_GPU_HANGS_API=20is=20not=20set=0D=
=0A#=20CONFIG_DRM_I915_DEBUG=20is=20not=20set=0D=0A#=20CONFIG_DRM_I915_DEBU=
G_MMIO=20is=20not=20set=0D=0A#=20CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=20i=
s=20not=20set=0D=0A#=20CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=20is=20not=20set=
=0D=0A#=20CONFIG_DRM_I915_DEBUG_GUC=20is=20not=20set=0D=0A#=20CONFIG_DRM_I9=
15_SELFTEST=20is=20not=20set=0D=0A#=20CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=
=20is=20not=20set=0D=0A#=20CONFIG_DRM_I915_DEBUG_VBLANK_EVADE=20is=20not=20=
set=0D=0A#=20CONFIG_DRM_I915_DEBUG_RUNTIME_PM=20is=20not=20set=0D=0A#=20CON=
FIG_DRM_I915_DEBUG_WAKEREF=20is=20not=20set=0D=0A#=20end=20of=20drm/i915=20=
Debugging=0D=0A=0D=0A#=0D=0A#=20drm/i915=20Profile=20Guided=20Optimisation=
=0D=0A#=0D=0ACONFIG_DRM_I915_REQUEST_TIMEOUT=3D20000=0D=0ACONFIG_DRM_I915_F=
ENCE_TIMEOUT=3D10000=0D=0ACONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=3D250=0D=0A=
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500=0D=0ACONFIG_DRM_I915_PREEMPT_TIME=
OUT=3D640=0D=0ACONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=3D7500=0D=0ACONFIG_D=
RM_I915_MAX_REQUEST_BUSYWAIT=3D8000=0D=0ACONFIG_DRM_I915_STOP_TIMEOUT=3D100=
=0D=0ACONFIG_DRM_I915_TIMESLICE_DURATION=3D1=0D=0A#=20end=20of=20drm/i915=
=20Profile=20Guided=20Optimisation=0D=0A=0D=0A#=20CONFIG_DRM_XE=20is=20not=
=20set=0D=0A#=20CONFIG_DRM_VGEM=20is=20not=20set=0D=0A#=20CONFIG_DRM_VKMS=
=20is=20not=20set=0D=0A#=20CONFIG_DRM_VMWGFX=20is=20not=20set=0D=0A#=20CONF=
IG_DRM_GMA500=20is=20not=20set=0D=0ACONFIG_DRM_UDL=3Dy=0D=0A#=20CONFIG_DRM_=
AST=20is=20not=20set=0D=0A#=20CONFIG_DRM_MGAG200=20is=20not=20set=0D=0A#=20=
CONFIG_DRM_QXL=20is=20not=20set=0D=0ACONFIG_DRM_VIRTIO_GPU=3Dy=0D=0ACONFIG_=
DRM_VIRTIO_GPU_KMS=3Dy=0D=0ACONFIG_DRM_PANEL=3Dy=0D=0A=0D=0A#=0D=0A#=20Disp=
lay=20Panels=0D=0A#=0D=0A#=20CONFIG_DRM_PANEL_ABT_Y030XX067A=20is=20not=20s=
et=0D=0A#=20CONFIG_DRM_PANEL_ARM_VERSATILE=20is=20not=20set=0D=0A#=20CONFIG=
_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=20is=20not=20set=0D=0A#=20CONFIG_DRM_PAN=
EL_AUO_A030JTN01=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ=
0=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_BOE_HIMAX8279D=20is=20not=20se=
t=0D=0A#=20CONFIG_DRM_PANEL_BOE_TD4320=20is=20not=20set=0D=0A#=20CONFIG_DRM=
_PANEL_BOE_TH101MB31UIG002_28A=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_B=
OE_TV101WUM_NL6=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_BOE_TV101WUM_LL2=
=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_EBBG_FT8719=20is=20not=20set=0D=
=0A#=20CONFIG_DRM_PANEL_ELIDA_KD35T133=20is=20not=20set=0D=0A#=20CONFIG_DRM=
_PANEL_FEIXIN_K101_IM2BA02=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_FEIYA=
NG_FY07024DI26A30D=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_DSI_CM=20is=
=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_LVDS=20is=20not=20set=0D=0A#=20CONFI=
G_DRM_PANEL_HIMAX_HX8279=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_HIMAX_H=
X83102=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_HIMAX_HX83112A=20is=20not=
=20set=0D=0A#=20CONFIG_DRM_PANEL_HIMAX_HX83112B=20is=20not=20set=0D=0A#=20C=
ONFIG_DRM_PANEL_HIMAX_HX8394=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_HYD=
IS_HV101HD1=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_ILITEK_IL9322=20is=
=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_ILITEK_ILI9341=20is=20not=20set=0D=
=0A#=20CONFIG_DRM_PANEL_ILITEK_ILI9805=20is=20not=20set=0D=0A#=20CONFIG_DRM=
_PANEL_ILITEK_ILI9806E=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_ILITEK_IL=
I9881C=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_ILITEK_ILI9882T=20is=20no=
t=20set=0D=0A#=20CONFIG_DRM_PANEL_INNOLUX_EJ030NA=20is=20not=20set=0D=0A#=
=20CONFIG_DRM_PANEL_INNOLUX_P079ZCA=20is=20not=20set=0D=0A#=20CONFIG_DRM_PA=
NEL_JADARD_JD9365DA_H3=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_JDI_LPM10=
2A188A=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_JDI_LT070ME05000=20is=20n=
ot=20set=0D=0A#=20CONFIG_DRM_PANEL_JDI_R63452=20is=20not=20set=0D=0A#=20CON=
FIG_DRM_PANEL_KHADAS_TS050=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_KINGD=
ISPLAY_KD097D04=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_LEADTEK_LTK050H3=
146W=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=20is=
=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_LINCOLNTECH_LCD197=20is=20not=20set=
=0D=0A#=20CONFIG_DRM_PANEL_LG_LB035Q02=20is=20not=20set=0D=0A#=20CONFIG_DRM=
_PANEL_LG_LG4573=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_LG_SW43408=20is=
=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966=20is=20not=20s=
et=0D=0A#=20CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=20is=20not=20set=0D=0A#=20C=
ONFIG_DRM_PANEL_NEC_NL8048HL11=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_N=
EWVISION_NV3051D=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_NEWVISION_NV305=
2C=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_NOVATEK_NT35510=20is=20not=20=
set=0D=0A#=20CONFIG_DRM_PANEL_NOVATEK_NT35560=20is=20not=20set=0D=0A#=20CON=
FIG_DRM_PANEL_NOVATEK_NT35950=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_NO=
VATEK_NT36523=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_NOVATEK_NT36672A=
=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_NOVATEK_NT36672E=20is=20not=20s=
et=0D=0A#=20CONFIG_DRM_PANEL_NOVATEK_NT37801=20is=20not=20set=0D=0A#=20CONF=
IG_DRM_PANEL_NOVATEK_NT39016=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_OLI=
MEX_LCD_OLINUXINO=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_ORISETECH_OTA5=
601A=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_ORISETECH_OTM8009A=20is=20n=
ot=20set=0D=0A#=20CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=20is=20not=20set=0D=
=0A#=20CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=20is=20not=20set=0D=0A#=20CO=
NFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=20is=20not=20set=0D=0A#=20CONFIG_DRM=
_PANEL_RAYDIUM_RM67191=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_RAYDIUM_R=
M67200=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_RAYDIUM_RM68200=20is=20no=
t=20set=0D=0A#=20CONFIG_DRM_PANEL_RAYDIUM_RM692E5=20is=20not=20set=0D=0A#=
=20CONFIG_DRM_PANEL_RAYDIUM_RM69380=20is=20not=20set=0D=0A#=20CONFIG_DRM_PA=
NEL_RENESAS_R61307=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_RENESAS_R6932=
8=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_RONBO_RB070D30=20is=20not=20se=
t=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_AMS581VF01=20is=20not=20set=0D=0A#=20CO=
NFIG_DRM_PANEL_SAMSUNG_AMS639RQ08=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANE=
L_SAMSUNG_S6E88A0_AMS427AP24=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SAM=
SUNG_S6E88A0_AMS452EF01=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_=
ATNA33XC20=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_DB7430=20is=
=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_LD9040=20is=20not=20set=0D=
=0A#=20CONFIG_DRM_PANEL_SAMSUNG_S6E3FA7=20is=20not=20set=0D=0A#=20CONFIG_DR=
M_PANEL_SAMSUNG_S6D16D0=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_=
S6D27A1=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_S6D7AA0=20is=20n=
ot=20set=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=20is=20not=20set=0D=0A#=
=20CONFIG_DRM_PANEL_SAMSUNG_S6E3HA8=20is=20not=20set=0D=0A#=20CONFIG_DRM_PA=
NEL_SAMSUNG_S6E63J0X03=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_S=
6E63M0=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=20is=20no=
t=20set=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_S6E8AA5X01_AMS561RA01=20is=20not=
=20set=0D=0A#=20CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=20is=20not=20set=0D=0A#=20=
CONFIG_DRM_PANEL_SEIKO_43WVF1G=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_S=
HARP_LQ101R1SX01=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SHARP_LS037V7DW=
01=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SHARP_LS043T1LE01=20is=20not=
=20set=0D=0A#=20CONFIG_DRM_PANEL_SHARP_LS060T1SX01=20is=20not=20set=0D=0A#=
=20CONFIG_DRM_PANEL_SITRONIX_ST7701=20is=20not=20set=0D=0A#=20CONFIG_DRM_PA=
NEL_SITRONIX_ST7703=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SITRONIX_ST7=
789V=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SONY_ACX565AKM=20is=20not=
=20set=0D=0A#=20CONFIG_DRM_PANEL_SONY_TD4353_JDI=20is=20not=20set=0D=0A#=20=
CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521=20is=20not=20set=0D=0A#=20CONFIG_=
DRM_PANEL_STARTEK_KD070FHFID015=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_=
EDP=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_SIMPLE=20is=20not=20set=0D=
=0A#=20CONFIG_DRM_PANEL_SUMMIT=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_S=
YNAPTICS_R63353=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_TDO_TL070WSH30=
=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_TPO_TD028TTEC1=20is=20not=20set=
=0D=0A#=20CONFIG_DRM_PANEL_TPO_TD043MTEA1=20is=20not=20set=0D=0A#=20CONFIG_=
DRM_PANEL_TPO_TPG110=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_TRULY_NT355=
97_WQXGA=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_VISIONOX_G2647FB105=20i=
s=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_VISIONOX_R66451=20is=20not=20set=0D=
=0A#=20CONFIG_DRM_PANEL_VISIONOX_RM69299=20is=20not=20set=0D=0A#=20CONFIG_D=
RM_PANEL_VISIONOX_RM692E5=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_VISION=
OX_VTDR6130=20is=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_WIDECHIPS_WS2401=20i=
s=20not=20set=0D=0A#=20CONFIG_DRM_PANEL_XINPENG_XPP055C272=20is=20not=20set=
=0D=0A#=20end=20of=20Display=20Panels=0D=0A=0D=0ACONFIG_DRM_BRIDGE=3Dy=0D=
=0ACONFIG_DRM_PANEL_BRIDGE=3Dy=0D=0ACONFIG_DRM_AUX_BRIDGE=3Dy=0D=0A=0D=0A#=
=0D=0A#=20Display=20Interface=20Bridges=0D=0A#=0D=0A#=20CONFIG_DRM_CHIPONE_=
ICN6211=20is=20not=20set=0D=0A#=20CONFIG_DRM_CHRONTEL_CH7033=20is=20not=20s=
et=0D=0A#=20CONFIG_DRM_DISPLAY_CONNECTOR=20is=20not=20set=0D=0A#=20CONFIG_D=
RM_I2C_NXP_TDA998X=20is=20not=20set=0D=0A#=20CONFIG_DRM_ITE_IT6263=20is=20n=
ot=20set=0D=0A#=20CONFIG_DRM_ITE_IT6505=20is=20not=20set=0D=0A#=20CONFIG_DR=
M_LONTIUM_LT8912B=20is=20not=20set=0D=0A#=20CONFIG_DRM_LONTIUM_LT9211=20is=
=20not=20set=0D=0A#=20CONFIG_DRM_LONTIUM_LT9611=20is=20not=20set=0D=0A#=20C=
ONFIG_DRM_LONTIUM_LT9611UXC=20is=20not=20set=0D=0A#=20CONFIG_DRM_ITE_IT6612=
1=20is=20not=20set=0D=0A#=20CONFIG_DRM_LVDS_CODEC=20is=20not=20set=0D=0A#=
=20CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=20is=20not=20set=0D=0A#=20CON=
FIG_DRM_NWL_MIPI_DSI=20is=20not=20set=0D=0A#=20CONFIG_DRM_NXP_PTN3460=20is=
=20not=20set=0D=0A#=20CONFIG_DRM_PARADE_PS8622=20is=20not=20set=0D=0A#=20CO=
NFIG_DRM_PARADE_PS8640=20is=20not=20set=0D=0A#=20CONFIG_DRM_SAMSUNG_DSIM=20=
is=20not=20set=0D=0A#=20CONFIG_DRM_SIL_SII8620=20is=20not=20set=0D=0A#=20CO=
NFIG_DRM_SII902X=20is=20not=20set=0D=0A#=20CONFIG_DRM_SII9234=20is=20not=20=
set=0D=0A#=20CONFIG_DRM_SIMPLE_BRIDGE=20is=20not=20set=0D=0A#=20CONFIG_DRM_=
SOLOMON_SSD2825=20is=20not=20set=0D=0A#=20CONFIG_DRM_THINE_THC63LVD1024=20i=
s=20not=20set=0D=0A#=20CONFIG_DRM_TOSHIBA_TC358762=20is=20not=20set=0D=0A#=
=20CONFIG_DRM_TOSHIBA_TC358764=20is=20not=20set=0D=0A#=20CONFIG_DRM_TOSHIBA=
_TC358767=20is=20not=20set=0D=0A#=20CONFIG_DRM_TOSHIBA_TC358768=20is=20not=
=20set=0D=0A#=20CONFIG_DRM_TOSHIBA_TC358775=20is=20not=20set=0D=0A#=20CONFI=
G_DRM_TI_DLPC3433=20is=20not=20set=0D=0A#=20CONFIG_DRM_TI_TDP158=20is=20not=
=20set=0D=0A#=20CONFIG_DRM_TI_TFP410=20is=20not=20set=0D=0A#=20CONFIG_DRM_T=
I_SN65DSI83=20is=20not=20set=0D=0A#=20CONFIG_DRM_TI_SN65DSI86=20is=20not=20=
set=0D=0A#=20CONFIG_DRM_TI_TPD12S015=20is=20not=20set=0D=0A#=20CONFIG_DRM_W=
AVESHARE_BRIDGE=20is=20not=20set=0D=0A#=20CONFIG_DRM_ANALOGIX_ANX6345=20is=
=20not=20set=0D=0A#=20CONFIG_DRM_ANALOGIX_ANX78XX=20is=20not=20set=0D=0A#=
=20CONFIG_DRM_ANALOGIX_ANX7625=20is=20not=20set=0D=0A#=20CONFIG_DRM_I2C_ADV=
7511=20is=20not=20set=0D=0A#=20CONFIG_DRM_CDNS_DSI=20is=20not=20set=0D=0A#=
=20CONFIG_DRM_CDNS_MHDP8546=20is=20not=20set=0D=0A#=20end=20of=20Display=20=
Interface=20Bridges=0D=0A=0D=0A#=20CONFIG_DRM_ETNAVIV=20is=20not=20set=0D=
=0A#=20CONFIG_DRM_HISI_HIBMC=20is=20not=20set=0D=0A#=20CONFIG_DRM_LOGICVC=
=20is=20not=20set=0D=0A#=20CONFIG_DRM_APPLETBDRM=20is=20not=20set=0D=0A#=20=
CONFIG_DRM_ARCPGU=20is=20not=20set=0D=0A#=20CONFIG_DRM_BOCHS=20is=20not=20s=
et=0D=0A#=20CONFIG_DRM_CIRRUS_QEMU=20is=20not=20set=0D=0ACONFIG_DRM_GM12U32=
0=3Dy=0D=0A#=20CONFIG_DRM_PANEL_MIPI_DBI=20is=20not=20set=0D=0A#=20CONFIG_D=
RM_PIXPAPER=20is=20not=20set=0D=0A#=20CONFIG_TINYDRM_HX8357D=20is=20not=20s=
et=0D=0A#=20CONFIG_TINYDRM_ILI9163=20is=20not=20set=0D=0A#=20CONFIG_TINYDRM=
_ILI9225=20is=20not=20set=0D=0A#=20CONFIG_TINYDRM_ILI9341=20is=20not=20set=
=0D=0A#=20CONFIG_TINYDRM_ILI9486=20is=20not=20set=0D=0A#=20CONFIG_TINYDRM_M=
I0283QT=20is=20not=20set=0D=0A#=20CONFIG_TINYDRM_REPAPER=20is=20not=20set=
=0D=0A#=20CONFIG_TINYDRM_SHARP_MEMORY=20is=20not=20set=0D=0A#=20CONFIG_DRM_=
VBOXVIDEO=20is=20not=20set=0D=0ACONFIG_DRM_GUD=3Dy=0D=0A#=20CONFIG_DRM_ST75=
71_I2C=20is=20not=20set=0D=0A#=20CONFIG_DRM_ST7586=20is=20not=20set=0D=0A#=
=20CONFIG_DRM_ST7735R=20is=20not=20set=0D=0A#=20CONFIG_DRM_SSD130X=20is=20n=
ot=20set=0D=0ACONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy=0D=0A=0D=0A#=0D=0A#=
=20Frame=20buffer=20Devices=0D=0A#=0D=0ACONFIG_FB=3Dy=0D=0A#=20CONFIG_FB_CI=
RRUS=20is=20not=20set=0D=0A#=20CONFIG_FB_PM2=20is=20not=20set=0D=0A#=20CONF=
IG_FB_CYBER2000=20is=20not=20set=0D=0A#=20CONFIG_FB_ARC=20is=20not=20set=0D=
=0A#=20CONFIG_FB_ASILIANT=20is=20not=20set=0D=0A#=20CONFIG_FB_IMSTT=20is=20=
not=20set=0D=0A#=20CONFIG_FB_VGA16=20is=20not=20set=0D=0A#=20CONFIG_FB_UVES=
A=20is=20not=20set=0D=0A#=20CONFIG_FB_VESA=20is=20not=20set=0D=0A#=20CONFIG=
_FB_N411=20is=20not=20set=0D=0A#=20CONFIG_FB_HGA=20is=20not=20set=0D=0A#=20=
CONFIG_FB_OPENCORES=20is=20not=20set=0D=0A#=20CONFIG_FB_S1D13XXX=20is=20not=
=20set=0D=0A#=20CONFIG_FB_NVIDIA=20is=20not=20set=0D=0A#=20CONFIG_FB_RIVA=
=20is=20not=20set=0D=0A#=20CONFIG_FB_I740=20is=20not=20set=0D=0A#=20CONFIG_=
FB_MATROX=20is=20not=20set=0D=0A#=20CONFIG_FB_RADEON=20is=20not=20set=0D=0A=
#=20CONFIG_FB_ATY128=20is=20not=20set=0D=0A#=20CONFIG_FB_ATY=20is=20not=20s=
et=0D=0A#=20CONFIG_FB_S3=20is=20not=20set=0D=0A#=20CONFIG_FB_SAVAGE=20is=20=
not=20set=0D=0A#=20CONFIG_FB_SIS=20is=20not=20set=0D=0A#=20CONFIG_FB_VIA=20=
is=20not=20set=0D=0A#=20CONFIG_FB_NEOMAGIC=20is=20not=20set=0D=0A#=20CONFIG=
_FB_KYRO=20is=20not=20set=0D=0A#=20CONFIG_FB_3DFX=20is=20not=20set=0D=0A#=
=20CONFIG_FB_VOODOO1=20is=20not=20set=0D=0A#=20CONFIG_FB_VT8623=20is=20not=
=20set=0D=0A#=20CONFIG_FB_TRIDENT=20is=20not=20set=0D=0A#=20CONFIG_FB_ARK=
=20is=20not=20set=0D=0A#=20CONFIG_FB_PM3=20is=20not=20set=0D=0A#=20CONFIG_F=
B_CARMINE=20is=20not=20set=0D=0ACONFIG_FB_SMSCUFX=3Dy=0D=0ACONFIG_FB_UDL=3D=
y=0D=0A#=20CONFIG_FB_IBM_GXT4500=20is=20not=20set=0D=0A#=20CONFIG_FB_VIRTUA=
L=20is=20not=20set=0D=0A#=20CONFIG_FB_METRONOME=20is=20not=20set=0D=0A#=20C=
ONFIG_FB_MB862XX=20is=20not=20set=0D=0A#=20CONFIG_FB_SIMPLE=20is=20not=20se=
t=0D=0A#=20CONFIG_FB_SSD1307=20is=20not=20set=0D=0A#=20CONFIG_FB_SM712=20is=
=20not=20set=0D=0ACONFIG_FB_CORE=3Dy=0D=0ACONFIG_FB_NOTIFY=3Dy=0D=0ACONFIG_=
FB_DEVICE=3Dy=0D=0ACONFIG_FB_SYS_FILLRECT=3Dy=0D=0ACONFIG_FB_SYS_COPYAREA=
=3Dy=0D=0ACONFIG_FB_SYS_IMAGEBLIT=3Dy=0D=0A#=20CONFIG_FB_FOREIGN_ENDIAN=20i=
s=20not=20set=0D=0ACONFIG_FB_SYSMEM_FOPS=3Dy=0D=0ACONFIG_FB_DEFERRED_IO=3Dy=
=0D=0ACONFIG_FB_SYSMEM_HELPERS=3Dy=0D=0ACONFIG_FB_SYSMEM_HELPERS_DEFERRED=
=3Dy=0D=0ACONFIG_FB_MODE_HELPERS=3Dy=0D=0A#=20CONFIG_FB_TILEBLITTING=20is=
=20not=20set=0D=0A#=20end=20of=20Frame=20buffer=20Devices=0D=0A=0D=0A#=0D=
=0A#=20Backlight=20&=20LCD=20device=20support=0D=0A#=0D=0ACONFIG_LCD_CLASS_=
DEVICE=3Dy=0D=0A#=20CONFIG_LCD_L4F00242T03=20is=20not=20set=0D=0A#=20CONFIG=
_LCD_LMS283GF05=20is=20not=20set=0D=0A#=20CONFIG_LCD_LTV350QV=20is=20not=20=
set=0D=0A#=20CONFIG_LCD_ILI922X=20is=20not=20set=0D=0A#=20CONFIG_LCD_ILI932=
0=20is=20not=20set=0D=0A#=20CONFIG_LCD_TDO24M=20is=20not=20set=0D=0A#=20CON=
FIG_LCD_VGG2432A4=20is=20not=20set=0D=0A#=20CONFIG_LCD_PLATFORM=20is=20not=
=20set=0D=0A#=20CONFIG_LCD_AMS369FG06=20is=20not=20set=0D=0A#=20CONFIG_LCD_=
LMS501KF03=20is=20not=20set=0D=0A#=20CONFIG_LCD_HX8357=20is=20not=20set=0D=
=0A#=20CONFIG_LCD_OTM3225A=20is=20not=20set=0D=0ACONFIG_BACKLIGHT_CLASS_DEV=
ICE=3Dy=0D=0A#=20CONFIG_BACKLIGHT_KTD253=20is=20not=20set=0D=0A#=20CONFIG_B=
ACKLIGHT_KTD2801=20is=20not=20set=0D=0A#=20CONFIG_BACKLIGHT_KTZ8866=20is=20=
not=20set=0D=0A#=20CONFIG_BACKLIGHT_MT6370=20is=20not=20set=0D=0A#=20CONFIG=
_BACKLIGHT_APPLE=20is=20not=20set=0D=0A#=20CONFIG_BACKLIGHT_QCOM_WLED=20is=
=20not=20set=0D=0A#=20CONFIG_BACKLIGHT_SAHARA=20is=20not=20set=0D=0A#=20CON=
FIG_BACKLIGHT_ADP8860=20is=20not=20set=0D=0A#=20CONFIG_BACKLIGHT_ADP8870=20=
is=20not=20set=0D=0A#=20CONFIG_BACKLIGHT_LM3509=20is=20not=20set=0D=0A#=20C=
ONFIG_BACKLIGHT_LM3639=20is=20not=20set=0D=0A#=20CONFIG_BACKLIGHT_PANDORA=
=20is=20not=20set=0D=0A#=20CONFIG_BACKLIGHT_GPIO=20is=20not=20set=0D=0A#=20=
CONFIG_BACKLIGHT_LV5207LP=20is=20not=20set=0D=0A#=20CONFIG_BACKLIGHT_BD6107=
=20is=20not=20set=0D=0A#=20CONFIG_BACKLIGHT_ARCXCNN=20is=20not=20set=0D=0A#=
=20CONFIG_BACKLIGHT_LED=20is=20not=20set=0D=0A#=20end=20of=20Backlight=20&=
=20LCD=20device=20support=0D=0A=0D=0ACONFIG_HDMI=3Dy=0D=0A#=20CONFIG_FIRMWA=
RE_EDID=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Console=20display=20driver=
=20support=0D=0A#=0D=0ACONFIG_VGA_CONSOLE=3Dy=0D=0ACONFIG_DUMMY_CONSOLE=3Dy=
=0D=0ACONFIG_DUMMY_CONSOLE_COLUMNS=3D80=0D=0ACONFIG_DUMMY_CONSOLE_ROWS=3D25=
=0D=0A#=20CONFIG_FRAMEBUFFER_CONSOLE=20is=20not=20set=0D=0A#=20end=20of=20C=
onsole=20display=20driver=20support=0D=0A=0D=0A#=20CONFIG_LOGO=20is=20not=
=20set=0D=0A#=20CONFIG_TRACE_GPU_MEM=20is=20not=20set=0D=0A#=20end=20of=20G=
raphics=20support=0D=0A=0D=0A#=20CONFIG_DRM_ACCEL=20is=20not=20set=0D=0ACON=
FIG_SOUND=3Dy=0D=0ACONFIG_SND=3Dy=0D=0ACONFIG_SND_TIMER=3Dy=0D=0ACONFIG_SND=
_PCM=3Dy=0D=0ACONFIG_SND_HWDEP=3Dy=0D=0ACONFIG_SND_SEQ_DEVICE=3Dy=0D=0ACONF=
IG_SND_RAWMIDI=3Dy=0D=0ACONFIG_SND_UMP=3Dy=0D=0A#=20CONFIG_SND_UMP_LEGACY_R=
AWMIDI=20is=20not=20set=0D=0ACONFIG_SND_JACK=3Dy=0D=0ACONFIG_SND_JACK_INPUT=
_DEV=3Dy=0D=0A#=20CONFIG_SND_OSSEMUL=20is=20not=20set=0D=0ACONFIG_SND_PCM_T=
IMER=3Dy=0D=0ACONFIG_SND_HRTIMER=3Dy=0D=0A#=20CONFIG_SND_DYNAMIC_MINORS=20i=
s=20not=20set=0D=0ACONFIG_SND_SUPPORT_OLD_API=3Dy=0D=0ACONFIG_SND_PROC_FS=
=3Dy=0D=0ACONFIG_SND_VERBOSE_PROCFS=3Dy=0D=0ACONFIG_SND_CTL_FAST_LOOKUP=3Dy=
=0D=0ACONFIG_SND_DEBUG=3Dy=0D=0A#=20CONFIG_SND_DEBUG_VERBOSE=20is=20not=20s=
et=0D=0ACONFIG_SND_PCM_XRUN_DEBUG=3Dy=0D=0A#=20CONFIG_SND_CTL_INPUT_VALIDAT=
ION=20is=20not=20set=0D=0A#=20CONFIG_SND_CTL_DEBUG=20is=20not=20set=0D=0A#=
=20CONFIG_SND_JACK_INJECTION_DEBUG=20is=20not=20set=0D=0A#=20CONFIG_SND_UTI=
MER=20is=20not=20set=0D=0ACONFIG_SND_VMASTER=3Dy=0D=0ACONFIG_SND_DMA_SGBUF=
=3Dy=0D=0ACONFIG_SND_SEQUENCER=3Dy=0D=0ACONFIG_SND_SEQ_DUMMY=3Dy=0D=0ACONFI=
G_SND_SEQ_HRTIMER_DEFAULT=3Dy=0D=0ACONFIG_SND_SEQ_MIDI_EVENT=3Dy=0D=0ACONFI=
G_SND_SEQ_MIDI=3Dy=0D=0A#=20CONFIG_SND_SEQ_UMP=20is=20not=20set=0D=0ACONFIG=
_SND_DRIVERS=3Dy=0D=0A#=20CONFIG_SND_PCSP=20is=20not=20set=0D=0A#=20CONFIG_=
SND_DUMMY=20is=20not=20set=0D=0A#=20CONFIG_SND_ALOOP=20is=20not=20set=0D=0A=
#=20CONFIG_SND_PCMTEST=20is=20not=20set=0D=0A#=20CONFIG_SND_VIRMIDI=20is=20=
not=20set=0D=0A#=20CONFIG_SND_MTPAV=20is=20not=20set=0D=0A#=20CONFIG_SND_MT=
S64=20is=20not=20set=0D=0A#=20CONFIG_SND_SERIAL_U16550=20is=20not=20set=0D=
=0A#=20CONFIG_SND_SERIAL_GENERIC=20is=20not=20set=0D=0A#=20CONFIG_SND_MPU40=
1=20is=20not=20set=0D=0A#=20CONFIG_SND_PORTMAN2X4=20is=20not=20set=0D=0ACON=
FIG_SND_PCI=3Dy=0D=0A#=20CONFIG_SND_AD1889=20is=20not=20set=0D=0A#=20CONFIG=
_SND_ALS300=20is=20not=20set=0D=0A#=20CONFIG_SND_ALS4000=20is=20not=20set=
=0D=0A#=20CONFIG_SND_ALI5451=20is=20not=20set=0D=0A#=20CONFIG_SND_ASIHPI=20=
is=20not=20set=0D=0A#=20CONFIG_SND_ATIIXP=20is=20not=20set=0D=0A#=20CONFIG_=
SND_ATIIXP_MODEM=20is=20not=20set=0D=0A#=20CONFIG_SND_AU8810=20is=20not=20s=
et=0D=0A#=20CONFIG_SND_AU8820=20is=20not=20set=0D=0A#=20CONFIG_SND_AU8830=
=20is=20not=20set=0D=0A#=20CONFIG_SND_AW2=20is=20not=20set=0D=0A#=20CONFIG_=
SND_AZT3328=20is=20not=20set=0D=0A#=20CONFIG_SND_BT87X=20is=20not=20set=0D=
=0A#=20CONFIG_SND_CA0106=20is=20not=20set=0D=0A#=20CONFIG_SND_CMIPCI=20is=
=20not=20set=0D=0A#=20CONFIG_SND_OXYGEN=20is=20not=20set=0D=0A#=20CONFIG_SN=
D_CS4281=20is=20not=20set=0D=0A#=20CONFIG_SND_CS46XX=20is=20not=20set=0D=0A=
#=20CONFIG_SND_CTXFI=20is=20not=20set=0D=0A#=20CONFIG_SND_DARLA20=20is=20no=
t=20set=0D=0A#=20CONFIG_SND_GINA20=20is=20not=20set=0D=0A#=20CONFIG_SND_LAY=
LA20=20is=20not=20set=0D=0A#=20CONFIG_SND_DARLA24=20is=20not=20set=0D=0A#=
=20CONFIG_SND_GINA24=20is=20not=20set=0D=0A#=20CONFIG_SND_LAYLA24=20is=20no=
t=20set=0D=0A#=20CONFIG_SND_MONA=20is=20not=20set=0D=0A#=20CONFIG_SND_MIA=
=20is=20not=20set=0D=0A#=20CONFIG_SND_ECHO3G=20is=20not=20set=0D=0A#=20CONF=
IG_SND_INDIGO=20is=20not=20set=0D=0A#=20CONFIG_SND_INDIGOIO=20is=20not=20se=
t=0D=0A#=20CONFIG_SND_INDIGODJ=20is=20not=20set=0D=0A#=20CONFIG_SND_INDIGOI=
OX=20is=20not=20set=0D=0A#=20CONFIG_SND_INDIGODJX=20is=20not=20set=0D=0A#=
=20CONFIG_SND_EMU10K1=20is=20not=20set=0D=0A#=20CONFIG_SND_EMU10K1X=20is=20=
not=20set=0D=0A#=20CONFIG_SND_ENS1370=20is=20not=20set=0D=0A#=20CONFIG_SND_=
ENS1371=20is=20not=20set=0D=0A#=20CONFIG_SND_ES1938=20is=20not=20set=0D=0A#=
=20CONFIG_SND_ES1968=20is=20not=20set=0D=0A#=20CONFIG_SND_FM801=20is=20not=
=20set=0D=0A#=20CONFIG_SND_HDSP=20is=20not=20set=0D=0A#=20CONFIG_SND_HDSPM=
=20is=20not=20set=0D=0A#=20CONFIG_SND_ICE1712=20is=20not=20set=0D=0A#=20CON=
FIG_SND_ICE1724=20is=20not=20set=0D=0A#=20CONFIG_SND_INTEL8X0=20is=20not=20=
set=0D=0A#=20CONFIG_SND_INTEL8X0M=20is=20not=20set=0D=0A#=20CONFIG_SND_KORG=
1212=20is=20not=20set=0D=0A#=20CONFIG_SND_LOLA=20is=20not=20set=0D=0A#=20CO=
NFIG_SND_LX6464ES=20is=20not=20set=0D=0A#=20CONFIG_SND_MAESTRO3=20is=20not=
=20set=0D=0A#=20CONFIG_SND_MIXART=20is=20not=20set=0D=0A#=20CONFIG_SND_NM25=
6=20is=20not=20set=0D=0A#=20CONFIG_SND_PCXHR=20is=20not=20set=0D=0A#=20CONF=
IG_SND_RIPTIDE=20is=20not=20set=0D=0A#=20CONFIG_SND_RME32=20is=20not=20set=
=0D=0A#=20CONFIG_SND_RME96=20is=20not=20set=0D=0A#=20CONFIG_SND_RME9652=20i=
s=20not=20set=0D=0A#=20CONFIG_SND_SE6X=20is=20not=20set=0D=0A#=20CONFIG_SND=
_SONICVIBES=20is=20not=20set=0D=0A#=20CONFIG_SND_TRIDENT=20is=20not=20set=
=0D=0A#=20CONFIG_SND_VIA82XX=20is=20not=20set=0D=0A#=20CONFIG_SND_VIA82XX_M=
ODEM=20is=20not=20set=0D=0A#=20CONFIG_SND_VIRTUOSO=20is=20not=20set=0D=0A#=
=20CONFIG_SND_VX222=20is=20not=20set=0D=0A#=20CONFIG_SND_YMFPCI=20is=20not=
=20set=0D=0A=0D=0A#=0D=0A#=20HD-Audio=0D=0A#=0D=0ACONFIG_SND_HDA=3Dy=0D=0AC=
ONFIG_SND_HDA_HWDEP=3Dy=0D=0A#=20CONFIG_SND_HDA_RECONFIG=20is=20not=20set=
=0D=0A#=20CONFIG_SND_HDA_INPUT_BEEP=20is=20not=20set=0D=0A#=20CONFIG_SND_HD=
A_PATCH_LOADER=20is=20not=20set=0D=0ACONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D0=
=0D=0A#=20CONFIG_SND_HDA_CTL_DEV_ID=20is=20not=20set=0D=0ACONFIG_SND_HDA_PR=
EALLOC_SIZE=3D0=0D=0ACONFIG_SND_HDA_INTEL=3Dy=0D=0A#=20CONFIG_SND_HDA_ACPI=
=20is=20not=20set=0D=0A#=20CONFIG_SND_HDA_CODEC_ANALOG=20is=20not=20set=0D=
=0A#=20CONFIG_SND_HDA_CODEC_SIGMATEL=20is=20not=20set=0D=0A#=20CONFIG_SND_H=
DA_CODEC_VIA=20is=20not=20set=0D=0A#=20CONFIG_SND_HDA_CODEC_CONEXANT=20is=
=20not=20set=0D=0A#=20CONFIG_SND_HDA_CODEC_SENARYTECH=20is=20not=20set=0D=
=0A#=20CONFIG_SND_HDA_CODEC_CA0110=20is=20not=20set=0D=0A#=20CONFIG_SND_HDA=
_CODEC_CA0132=20is=20not=20set=0D=0A#=20CONFIG_SND_HDA_CODEC_CMEDIA=20is=20=
not=20set=0D=0A#=20CONFIG_SND_HDA_CODEC_CM9825=20is=20not=20set=0D=0A#=20CO=
NFIG_SND_HDA_CODEC_SI3054=20is=20not=20set=0D=0A#=20CONFIG_SND_HDA_GENERIC=
=20is=20not=20set=0D=0A#=20CONFIG_SND_HDA_CODEC_REALTEK=20is=20not=20set=0D=
=0A#=20CONFIG_SND_HDA_CODEC_CIRRUS=20is=20not=20set=0D=0A#=20CONFIG_SND_HDA=
_CODEC_HDMI=20is=20not=20set=0D=0A#=20CONFIG_SND_HDA_SCODEC_CS35L56_I2C=20i=
s=20not=20set=0D=0A#=20CONFIG_SND_HDA_SCODEC_CS35L56_SPI=20is=20not=20set=
=0D=0ACONFIG_SND_HDA_CORE=3Dy=0D=0ACONFIG_SND_HDA_COMPONENT=3Dy=0D=0ACONFIG=
_SND_HDA_I915=3Dy=0D=0ACONFIG_SND_INTEL_NHLT=3Dy=0D=0ACONFIG_SND_INTEL_DSP_=
CONFIG=3Dy=0D=0ACONFIG_SND_INTEL_SOUNDWIRE_ACPI=3Dy=0D=0A#=20end=20of=20HD-=
Audio=0D=0A=0D=0A#=20CONFIG_SND_SPI=20is=20not=20set=0D=0ACONFIG_SND_USB=3D=
y=0D=0ACONFIG_SND_USB_AUDIO=3Dy=0D=0ACONFIG_SND_USB_AUDIO_MIDI_V2=3Dy=0D=0A=
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=3Dy=0D=0ACONFIG_SND_USB_UA101=3Dy=
=0D=0ACONFIG_SND_USB_USX2Y=3Dy=0D=0ACONFIG_SND_USB_CAIAQ=3Dy=0D=0ACONFIG_SN=
D_USB_CAIAQ_INPUT=3Dy=0D=0ACONFIG_SND_USB_US122L=3Dy=0D=0A#=20CONFIG_SND_US=
B_US144MKII=20is=20not=20set=0D=0ACONFIG_SND_USB_6FIRE=3Dy=0D=0ACONFIG_SND_=
USB_HIFACE=3Dy=0D=0ACONFIG_SND_BCD2000=3Dy=0D=0ACONFIG_SND_USB_LINE6=3Dy=0D=
=0ACONFIG_SND_USB_POD=3Dy=0D=0ACONFIG_SND_USB_PODHD=3Dy=0D=0ACONFIG_SND_USB=
_TONEPORT=3Dy=0D=0ACONFIG_SND_USB_VARIAX=3Dy=0D=0ACONFIG_SND_PCMCIA=3Dy=0D=
=0A#=20CONFIG_SND_VXPOCKET=20is=20not=20set=0D=0A#=20CONFIG_SND_PDAUDIOCF=
=20is=20not=20set=0D=0ACONFIG_SND_SOC=3Dy=0D=0A#=20CONFIG_SND_SOC_USB=20is=
=20not=20set=0D=0A=0D=0A#=0D=0A#=20Analog=20Devices=0D=0A#=0D=0A#=20CONFIG_=
SND_SOC_ADI_AXI_I2S=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ADI_AXI_SPDIF=
=20is=20not=20set=0D=0A#=20end=20of=20Analog=20Devices=0D=0A=0D=0A#=0D=0A#=
=20AMD=0D=0A#=0D=0A#=20CONFIG_SND_SOC_AMD_ACP=20is=20not=20set=0D=0A#=20CON=
FIG_SND_SOC_AMD_ACP3x=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AMD_RENOIR=
=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AMD_ACP5x=20is=20not=20set=0D=0A#=
=20CONFIG_SND_SOC_AMD_ACP6x=20is=20not=20set=0D=0A#=20CONFIG_SND_AMD_ACP_CO=
NFIG=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AMD_ACP_COMMON=20is=20not=20s=
et=0D=0A#=20CONFIG_SND_SOC_AMD_RPL_ACP6x=20is=20not=20set=0D=0A#=20end=20of=
=20AMD=0D=0A=0D=0A#=0D=0A#=20Apple=0D=0A#=0D=0A#=20end=20of=20Apple=0D=0A=
=0D=0A#=0D=0A#=20Atmel=0D=0A#=0D=0A#=20CONFIG_SND_SOC_MIKROE_PROTO=20is=20n=
ot=20set=0D=0A#=20end=20of=20Atmel=0D=0A=0D=0A#=0D=0A#=20Au1x=0D=0A#=0D=0A#=
=20end=20of=20Au1x=0D=0A=0D=0A#=0D=0A#=20Broadcom=0D=0A#=0D=0A#=20CONFIG_SN=
D_BCM63XX_I2S_WHISTLER=20is=20not=20set=0D=0A#=20end=20of=20Broadcom=0D=0A=
=0D=0A#=0D=0A#=20Cirrus=20Logic=0D=0A#=0D=0A#=20end=20of=20Cirrus=20Logic=
=0D=0A=0D=0A#=0D=0A#=20DesignWare=0D=0A#=0D=0A#=20CONFIG_SND_DESIGNWARE_I2S=
=20is=20not=20set=0D=0A#=20end=20of=20DesignWare=0D=0A=0D=0A#=0D=0A#=20Free=
scale=0D=0A#=0D=0A=0D=0A#=0D=0A#=20Common=20SoC=20Audio=20options=20for=20F=
reescale=20CPUs:=0D=0A#=0D=0A#=20CONFIG_SND_SOC_FSL_ASRC=20is=20not=20set=
=0D=0A#=20CONFIG_SND_SOC_FSL_SAI=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_F=
SL_AUDMIX=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_FSL_SSI=20is=20not=20set=
=0D=0A#=20CONFIG_SND_SOC_FSL_SPDIF=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC=
_FSL_ESAI=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_FSL_MICFIL=20is=20not=20=
set=0D=0A#=20CONFIG_SND_SOC_FSL_XCVR=20is=20not=20set=0D=0A#=20CONFIG_SND_S=
OC_IMX_AUDMUX=20is=20not=20set=0D=0A#=20end=20of=20Freescale=0D=0A=0D=0A#=
=0D=0A#=20Google=0D=0A#=0D=0A#=20CONFIG_SND_SOC_CHV3_I2S=20is=20not=20set=
=0D=0A#=20end=20of=20Google=0D=0A=0D=0A#=0D=0A#=20Hisilicon=0D=0A#=0D=0A#=
=20CONFIG_SND_I2S_HI6210_I2S=20is=20not=20set=0D=0A#=20end=20of=20Hisilicon=
=0D=0A=0D=0A#=0D=0A#=20JZ4740=0D=0A#=0D=0A#=20end=20of=20JZ4740=0D=0A=0D=0A=
#=0D=0A#=20Kirkwood=0D=0A#=0D=0A#=20end=20of=20Kirkwood=0D=0A=0D=0A#=0D=0A#=
=20Loongson=0D=0A#=0D=0A#=20end=20of=20Loongson=0D=0A=0D=0A#=0D=0A#=20Intel=
=0D=0A#=0D=0A#=20CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=20is=20not=20set=0D=0A#=
=20CONFIG_SND_SOC_INTEL_AVS=20is=20not=20set=0D=0A#=20end=20of=20Intel=0D=
=0A=0D=0A#=0D=0A#=20Mediatek=0D=0A#=0D=0A#=20CONFIG_SND_SOC_MTK_BTCVSD=20is=
=20not=20set=0D=0A#=20end=20of=20Mediatek=0D=0A=0D=0A#=0D=0A#=20PXA=0D=0A#=
=0D=0A#=20end=20of=20PXA=0D=0A=0D=0A#=0D=0A#=20SoundWire=20(SDCA)=0D=0A#=0D=
=0ACONFIG_SND_SOC_SDCA_OPTIONAL=3Dy=0D=0A#=20end=20of=20SoundWire=20(SDCA)=
=0D=0A=0D=0A#=0D=0A#=20ST=20SPEAr=0D=0A#=0D=0A#=20end=20of=20ST=20SPEAr=0D=
=0A=0D=0A#=0D=0A#=20Spreadtrum=0D=0A#=0D=0A#=20end=20of=20Spreadtrum=0D=0A=
=0D=0A#=0D=0A#=20STMicroelectronics=20STM32=0D=0A#=0D=0A#=20end=20of=20STMi=
croelectronics=20STM32=0D=0A=0D=0A#=0D=0A#=20Tegra=0D=0A#=0D=0A#=20end=20of=
=20Tegra=0D=0A=0D=0A#=0D=0A#=20Xilinx=0D=0A#=0D=0A#=20CONFIG_SND_SOC_XILINX=
_I2S=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_XILINX_SPDIF=20is=20not=20set=0D=0A#=
=20end=20of=20Xilinx=0D=0A=0D=0A#=0D=0A#=20Xtensa=0D=0A#=0D=0A#=20CONFIG_SN=
D_SOC_XTFPGA_I2S=20is=20not=20set=0D=0A#=20end=20of=20Xtensa=0D=0A=0D=0A#=
=20CONFIG_SND_SOC_SOF_TOPLEVEL=20is=20not=20set=0D=0ACONFIG_SND_SOC_I2C_AND=
_SPI=3Dy=0D=0A=0D=0A#=0D=0A#=20CODEC=20drivers=0D=0A#=0D=0A#=20CONFIG_SND_S=
OC_AC97_CODEC=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ADAU1372_I2C=20is=20=
not=20set=0D=0A#=20CONFIG_SND_SOC_ADAU1372_SPI=20is=20not=20set=0D=0A#=20CO=
NFIG_SND_SOC_ADAU1373=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ADAU1701=20i=
s=20not=20set=0D=0A#=20CONFIG_SND_SOC_ADAU1761_I2C=20is=20not=20set=0D=0A#=
=20CONFIG_SND_SOC_ADAU1761_SPI=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ADA=
U7002=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ADAU7118_HW=20is=20not=20set=
=0D=0A#=20CONFIG_SND_SOC_ADAU7118_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_=
SOC_AK4104=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AK4118=20is=20not=20set=
=0D=0A#=20CONFIG_SND_SOC_AK4375=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AK=
4458=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AK4554=20is=20not=20set=0D=0A=
#=20CONFIG_SND_SOC_AK4613=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AK4619=
=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AK4642=20is=20not=20set=0D=0A#=20=
CONFIG_SND_SOC_AK5386=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AK5558=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_ALC5623=20is=20not=20set=0D=0A#=20CONF=
IG_SND_SOC_AUDIO_IIO_AUX=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AW8738=20=
is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AW88395=20is=20not=20set=0D=0A#=20CO=
NFIG_SND_SOC_AW88166=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AW88261=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_AW88081=20is=20not=20set=0D=0A#=20CONF=
IG_SND_SOC_AW87390=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_AW88399=20is=20=
not=20set=0D=0A#=20CONFIG_SND_SOC_BD28623=20is=20not=20set=0D=0A#=20CONFIG_=
SND_SOC_BT_SCO=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CHV3_CODEC=20is=20n=
ot=20set=0D=0A#=20CONFIG_SND_SOC_CROS_EC_CODEC=20is=20not=20set=0D=0A#=20CO=
NFIG_SND_SOC_CS35L32=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS35L33=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS35L34=20is=20not=20set=0D=0A#=20CONF=
IG_SND_SOC_CS35L35=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS35L36=20is=20=
not=20set=0D=0A#=20CONFIG_SND_SOC_CS35L41_SPI=20is=20not=20set=0D=0A#=20CON=
FIG_SND_SOC_CS35L41_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS35L45_SP=
I=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS35L45_I2C=20is=20not=20set=0D=
=0A#=20CONFIG_SND_SOC_CS35L56_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_=
CS35L56_SPI=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS35L56_SDW=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_CS42L42=20is=20not=20set=0D=0A#=20CONFIG_SND=
_SOC_CS42L42_SDW=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS42L51_I2C=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS42L52=20is=20not=20set=0D=0A#=20CONF=
IG_SND_SOC_CS42L56=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS42L73=20is=20=
not=20set=0D=0A#=20CONFIG_SND_SOC_CS42L83=20is=20not=20set=0D=0A#=20CONFIG_=
SND_SOC_CS42L84=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS4234=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_CS4265=20is=20not=20set=0D=0A#=20CONFIG_SND_=
SOC_CS4270=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS4271_I2C=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_CS4271_SPI=20is=20not=20set=0D=0A#=20CONFIG_=
SND_SOC_CS42XX8_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS43130=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS4341=20is=20not=20set=0D=0A#=20CONFI=
G_SND_SOC_CS4349=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CS48L32=20is=20no=
t=20set=0D=0A#=20CONFIG_SND_SOC_CS53L30=20is=20not=20set=0D=0A#=20CONFIG_SN=
D_SOC_CS530X_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_CX2072X=20is=20no=
t=20set=0D=0A#=20CONFIG_SND_SOC_DA7213=20is=20not=20set=0D=0A#=20CONFIG_SND=
_SOC_DMIC=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ES7134=20is=20not=20set=
=0D=0A#=20CONFIG_SND_SOC_ES7241=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ES=
8311=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ES8316=20is=20not=20set=0D=0A=
#=20CONFIG_SND_SOC_ES8323=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ES8326=
=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ES8328_I2C=20is=20not=20set=0D=0A=
#=20CONFIG_SND_SOC_ES8328_SPI=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ES83=
75=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_ES8389=20is=20not=20set=0D=0A#=
=20CONFIG_SND_SOC_FS210X=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_GTM601=20=
is=20not=20set=0D=0A#=20CONFIG_SND_SOC_HDA=20is=20not=20set=0D=0A#=20CONFIG=
_SND_SOC_ICS43432=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_IDT821034=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_MAX98088=20is=20not=20set=0D=0A#=20CON=
FIG_SND_SOC_MAX98090=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_MAX98357A=20i=
s=20not=20set=0D=0A#=20CONFIG_SND_SOC_MAX98504=20is=20not=20set=0D=0A#=20CO=
NFIG_SND_SOC_MAX9867=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_MAX98927=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_MAX98520=20is=20not=20set=0D=0A#=20CON=
FIG_SND_SOC_MAX98363=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_MAX98373_I2C=
=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_MAX98373_SDW=20is=20not=20set=0D=
=0A#=20CONFIG_SND_SOC_MAX98388=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_MAX=
98390=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_MAX98396=20is=20not=20set=0D=
=0A#=20CONFIG_SND_SOC_MAX9860=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_MSM8=
916_WCD_DIGITAL=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_PCM1681=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_PCM1754=20is=20not=20set=0D=0A#=20CONFIG_SND=
_SOC_PCM1789_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_PCM179X_I2C=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_PCM179X_SPI=20is=20not=20set=0D=0A#=20=
CONFIG_SND_SOC_PCM186X_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_PCM186X=
_SPI=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_PCM3060_I2C=20is=20not=20set=
=0D=0A#=20CONFIG_SND_SOC_PCM3060_SPI=20is=20not=20set=0D=0A#=20CONFIG_SND_S=
OC_PCM3168A_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_PCM3168A_SPI=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_PCM5102A=20is=20not=20set=0D=0A#=20CON=
FIG_SND_SOC_PCM512x_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_PCM512x_SP=
I=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_PCM6240=20is=20not=20set=0D=0A#=
=20CONFIG_SND_SOC_PEB2466=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_PM4125_S=
DW=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_RT1017_SDCA_SDW=20is=20not=20se=
t=0D=0A#=20CONFIG_SND_SOC_RT1308_SDW=20is=20not=20set=0D=0A#=20CONFIG_SND_S=
OC_RT1316_SDW=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_RT1318_SDW=20is=20no=
t=20set=0D=0A#=20CONFIG_SND_SOC_RT1320_SDW=20is=20not=20set=0D=0A#=20CONFIG=
_SND_SOC_RT5616=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_RT5631=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_RT5640=20is=20not=20set=0D=0A#=20CONFIG_SND_=
SOC_RT5659=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_RT5682_SDW=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_RT700_SDW=20is=20not=20set=0D=0A#=20CONFIG_S=
ND_SOC_RT711_SDW=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_RT711_SDCA_SDW=20=
is=20not=20set=0D=0A#=20CONFIG_SND_SOC_RT712_SDCA_SDW=20is=20not=20set=0D=
=0A#=20CONFIG_SND_SOC_RT712_SDCA_DMIC_SDW=20is=20not=20set=0D=0A#=20CONFIG_=
SND_SOC_RT721_SDCA_SDW=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_RT722_SDCA_=
SDW=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_RT715_SDW=20is=20not=20set=0D=
=0A#=20CONFIG_SND_SOC_RT715_SDCA_SDW=20is=20not=20set=0D=0A#=20CONFIG_SND_S=
OC_RT9120=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_RT9123=20is=20not=20set=
=0D=0A#=20CONFIG_SND_SOC_RT9123P=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_R=
TQ9124=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_RTQ9128=20is=20not=20set=0D=
=0A#=20CONFIG_SND_SOC_SDW_MOCKUP=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_S=
GTL5000=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_SIMPLE_AMPLIFIER=20is=20no=
t=20set=0D=0A#=20CONFIG_SND_SOC_SIMPLE_MUX=20is=20not=20set=0D=0A#=20CONFIG=
_SND_SOC_SMA1303=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_SMA1307=20is=20no=
t=20set=0D=0A#=20CONFIG_SND_SOC_SPDIF=20is=20not=20set=0D=0A#=20CONFIG_SND_=
SOC_SRC4XXX_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_SSM2305=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_SSM2518=20is=20not=20set=0D=0A#=20CONFIG_SND=
_SOC_SSM2602_SPI=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_SSM2602_I2C=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_SSM3515=20is=20not=20set=0D=0A#=20CONF=
IG_SND_SOC_SSM4567=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_STA32X=20is=20n=
ot=20set=0D=0A#=20CONFIG_SND_SOC_STA350=20is=20not=20set=0D=0A#=20CONFIG_SN=
D_SOC_STI_SAS=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TAS2552=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_TAS2562=20is=20not=20set=0D=0A#=20CONFIG_SND=
_SOC_TAS2764=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TAS2770=20is=20not=20=
set=0D=0A#=20CONFIG_SND_SOC_TAS2780=20is=20not=20set=0D=0A#=20CONFIG_SND_SO=
C_TAS2781_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TAS5086=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_TAS571X=20is=20not=20set=0D=0A#=20CONFIG_SND=
_SOC_TAS5720=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TAS5805M=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_TAS6424=20is=20not=20set=0D=0A#=20CONFIG_SND=
_SOC_TDA7419=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TFA9879=20is=20not=20=
set=0D=0A#=20CONFIG_SND_SOC_TFA989X=20is=20not=20set=0D=0A#=20CONFIG_SND_SO=
C_TLV320ADC3XXX=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TLV320AIC23_I2C=20=
is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TLV320AIC23_SPI=20is=20not=20set=0D=
=0A#=20CONFIG_SND_SOC_TLV320AIC31XX=20is=20not=20set=0D=0A#=20CONFIG_SND_SO=
C_TLV320AIC32X4_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TLV320AIC32X4_=
SPI=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TLV320AIC3X_I2C=20is=20not=20s=
et=0D=0A#=20CONFIG_SND_SOC_TLV320AIC3X_SPI=20is=20not=20set=0D=0A#=20CONFIG=
_SND_SOC_TLV320ADCX140=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TS3A227E=20=
is=20not=20set=0D=0A#=20CONFIG_SND_SOC_TSCS42XX=20is=20not=20set=0D=0A#=20C=
ONFIG_SND_SOC_TSCS454=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_UDA1334=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_UDA1342=20is=20not=20set=0D=0A#=20CONF=
IG_SND_SOC_WCD937X_SDW=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WCD938X_SDW=
=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WCD939X_SDW=20is=20not=20set=0D=
=0A#=20CONFIG_SND_SOC_WM8510=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM852=
3=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8524=20is=20not=20set=0D=0A#=
=20CONFIG_SND_SOC_WM8580=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8711=20=
is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8728=20is=20not=20set=0D=0A#=20CON=
FIG_SND_SOC_WM8731_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8731_SPI=
=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8737=20is=20not=20set=0D=0A#=20=
CONFIG_SND_SOC_WM8741=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8750=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8753=20is=20not=20set=0D=0A#=20CONFI=
G_SND_SOC_WM8770=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8776=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_WM8782=20is=20not=20set=0D=0A#=20CONFIG_SND_=
SOC_WM8804_I2C=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8804_SPI=20is=20n=
ot=20set=0D=0A#=20CONFIG_SND_SOC_WM8903=20is=20not=20set=0D=0A#=20CONFIG_SN=
D_SOC_WM8904=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8940=20is=20not=20s=
et=0D=0A#=20CONFIG_SND_SOC_WM8960=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_=
WM8961=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8962=20is=20not=20set=0D=
=0A#=20CONFIG_SND_SOC_WM8974=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM897=
8=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WM8985=20is=20not=20set=0D=0A#=
=20CONFIG_SND_SOC_WSA881X=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WSA883X=
=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_WSA884X=20is=20not=20set=0D=0A#=
=20CONFIG_SND_SOC_ZL38060=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_MAX9759=
=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_MT6351=20is=20not=20set=0D=0A#=20=
CONFIG_SND_SOC_MT6357=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_MT6358=20is=
=20not=20set=0D=0A#=20CONFIG_SND_SOC_MT6660=20is=20not=20set=0D=0A#=20CONFI=
G_SND_SOC_NAU8315=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_NAU8540=20is=20n=
ot=20set=0D=0A#=20CONFIG_SND_SOC_NAU8810=20is=20not=20set=0D=0A#=20CONFIG_S=
ND_SOC_NAU8821=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_NAU8822=20is=20not=
=20set=0D=0A#=20CONFIG_SND_SOC_NAU8824=20is=20not=20set=0D=0A#=20CONFIG_SND=
_SOC_NTP8918=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_NTP8835=20is=20not=20=
set=0D=0A#=20CONFIG_SND_SOC_TPA6130A2=20is=20not=20set=0D=0A#=20CONFIG_SND_=
SOC_LPASS_WSA_MACRO=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_LPASS_VA_MACRO=
=20is=20not=20set=0D=0A#=20CONFIG_SND_SOC_LPASS_RX_MACRO=20is=20not=20set=
=0D=0A#=20CONFIG_SND_SOC_LPASS_TX_MACRO=20is=20not=20set=0D=0A#=20end=20of=
=20CODEC=20drivers=0D=0A=0D=0A#=0D=0A#=20Generic=20drivers=0D=0A#=0D=0A#=20=
CONFIG_SND_SIMPLE_CARD=20is=20not=20set=0D=0A#=20CONFIG_SND_AUDIO_GRAPH_CAR=
D=20is=20not=20set=0D=0A#=20CONFIG_SND_AUDIO_GRAPH_CARD2=20is=20not=20set=
=0D=0A#=20CONFIG_SND_TEST_COMPONENT=20is=20not=20set=0D=0A#=20end=20of=20Ge=
neric=20drivers=0D=0A=0D=0ACONFIG_SND_X86=3Dy=0D=0A#=20CONFIG_HDMI_LPE_AUDI=
O=20is=20not=20set=0D=0A#=20CONFIG_SND_VIRTIO=20is=20not=20set=0D=0ACONFIG_=
HID_SUPPORT=3Dy=0D=0ACONFIG_HID=3Dy=0D=0ACONFIG_HID_BATTERY_STRENGTH=3Dy=0D=
=0ACONFIG_HIDRAW=3Dy=0D=0ACONFIG_UHID=3Dy=0D=0ACONFIG_HID_GENERIC=3Dy=0D=0A=
#=20CONFIG_HID_HAPTIC=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Special=20HID=
=20drivers=0D=0A#=0D=0ACONFIG_HID_A4TECH=3Dy=0D=0ACONFIG_HID_ACCUTOUCH=3Dy=
=0D=0ACONFIG_HID_ACRUX=3Dy=0D=0ACONFIG_HID_ACRUX_FF=3Dy=0D=0ACONFIG_HID_APP=
LE=3Dy=0D=0ACONFIG_HID_APPLEIR=3Dy=0D=0A#=20CONFIG_HID_APPLETB_BL=20is=20no=
t=20set=0D=0A#=20CONFIG_HID_APPLETB_KBD=20is=20not=20set=0D=0ACONFIG_HID_AS=
US=3Dy=0D=0ACONFIG_HID_AUREAL=3Dy=0D=0ACONFIG_HID_BELKIN=3Dy=0D=0ACONFIG_HI=
D_BETOP_FF=3Dy=0D=0ACONFIG_HID_BIGBEN_FF=3Dy=0D=0ACONFIG_HID_CHERRY=3Dy=0D=
=0ACONFIG_HID_CHICONY=3Dy=0D=0ACONFIG_HID_CORSAIR=3Dy=0D=0ACONFIG_HID_COUGA=
R=3Dy=0D=0ACONFIG_HID_MACALLY=3Dy=0D=0ACONFIG_HID_PRODIKEYS=3Dy=0D=0ACONFIG=
_HID_CMEDIA=3Dy=0D=0ACONFIG_HID_CP2112=3Dy=0D=0ACONFIG_HID_CREATIVE_SB0540=
=3Dy=0D=0ACONFIG_HID_CYPRESS=3Dy=0D=0ACONFIG_HID_DRAGONRISE=3Dy=0D=0ACONFIG=
_DRAGONRISE_FF=3Dy=0D=0ACONFIG_HID_EMS_FF=3Dy=0D=0ACONFIG_HID_ELAN=3Dy=0D=
=0ACONFIG_HID_ELECOM=3Dy=0D=0ACONFIG_HID_ELO=3Dy=0D=0ACONFIG_HID_EVISION=3D=
y=0D=0ACONFIG_HID_EZKEY=3Dy=0D=0ACONFIG_HID_FT260=3Dy=0D=0ACONFIG_HID_GEMBI=
RD=3Dy=0D=0ACONFIG_HID_GFRM=3Dy=0D=0ACONFIG_HID_GLORIOUS=3Dy=0D=0ACONFIG_HI=
D_HOLTEK=3Dy=0D=0ACONFIG_HOLTEK_FF=3Dy=0D=0ACONFIG_HID_VIVALDI_COMMON=3Dy=
=0D=0A#=20CONFIG_HID_GOODIX_SPI=20is=20not=20set=0D=0ACONFIG_HID_GOOGLE_HAM=
MER=3Dy=0D=0ACONFIG_HID_GOOGLE_STADIA_FF=3Dy=0D=0ACONFIG_HID_VIVALDI=3Dy=0D=
=0ACONFIG_HID_GT683R=3Dy=0D=0ACONFIG_HID_KEYTOUCH=3Dy=0D=0ACONFIG_HID_KYE=
=3Dy=0D=0A#=20CONFIG_HID_KYSONA=20is=20not=20set=0D=0ACONFIG_HID_UCLOGIC=3D=
y=0D=0ACONFIG_HID_WALTOP=3Dy=0D=0ACONFIG_HID_VIEWSONIC=3Dy=0D=0ACONFIG_HID_=
VRC2=3Dy=0D=0ACONFIG_HID_XIAOMI=3Dy=0D=0ACONFIG_HID_GYRATION=3Dy=0D=0ACONFI=
G_HID_ICADE=3Dy=0D=0ACONFIG_HID_ITE=3Dy=0D=0ACONFIG_HID_JABRA=3Dy=0D=0ACONF=
IG_HID_TWINHAN=3Dy=0D=0ACONFIG_HID_KENSINGTON=3Dy=0D=0ACONFIG_HID_LCPOWER=
=3Dy=0D=0ACONFIG_HID_LED=3Dy=0D=0ACONFIG_HID_LENOVO=3Dy=0D=0ACONFIG_HID_LET=
SKETCH=3Dy=0D=0ACONFIG_HID_LOGITECH=3Dy=0D=0ACONFIG_HID_LOGITECH_DJ=3Dy=0D=
=0ACONFIG_HID_LOGITECH_HIDPP=3Dy=0D=0ACONFIG_LOGITECH_FF=3Dy=0D=0ACONFIG_LO=
GIRUMBLEPAD2_FF=3Dy=0D=0ACONFIG_LOGIG940_FF=3Dy=0D=0ACONFIG_LOGIWHEELS_FF=
=3Dy=0D=0ACONFIG_HID_MAGICMOUSE=3Dy=0D=0ACONFIG_HID_MALTRON=3Dy=0D=0ACONFIG=
_HID_MAYFLASH=3Dy=0D=0ACONFIG_HID_MEGAWORLD_FF=3Dy=0D=0ACONFIG_HID_REDRAGON=
=3Dy=0D=0ACONFIG_HID_MICROSOFT=3Dy=0D=0ACONFIG_HID_MONTEREY=3Dy=0D=0ACONFIG=
_HID_MULTITOUCH=3Dy=0D=0ACONFIG_HID_NINTENDO=3Dy=0D=0ACONFIG_NINTENDO_FF=3D=
y=0D=0ACONFIG_HID_NTI=3Dy=0D=0ACONFIG_HID_NTRIG=3Dy=0D=0ACONFIG_HID_NVIDIA_=
SHIELD=3Dy=0D=0ACONFIG_NVIDIA_SHIELD_FF=3Dy=0D=0ACONFIG_HID_ORTEK=3Dy=0D=0A=
CONFIG_HID_PANTHERLORD=3Dy=0D=0ACONFIG_PANTHERLORD_FF=3Dy=0D=0ACONFIG_HID_P=
ENMOUNT=3Dy=0D=0ACONFIG_HID_PETALYNX=3Dy=0D=0ACONFIG_HID_PICOLCD=3Dy=0D=0AC=
ONFIG_HID_PICOLCD_FB=3Dy=0D=0ACONFIG_HID_PICOLCD_BACKLIGHT=3Dy=0D=0ACONFIG_=
HID_PICOLCD_LCD=3Dy=0D=0ACONFIG_HID_PICOLCD_LEDS=3Dy=0D=0ACONFIG_HID_PICOLC=
D_CIR=3Dy=0D=0ACONFIG_HID_PLANTRONICS=3Dy=0D=0ACONFIG_HID_PLAYSTATION=3Dy=
=0D=0ACONFIG_PLAYSTATION_FF=3Dy=0D=0ACONFIG_HID_PXRC=3Dy=0D=0ACONFIG_HID_RA=
ZER=3Dy=0D=0ACONFIG_HID_PRIMAX=3Dy=0D=0ACONFIG_HID_RETRODE=3Dy=0D=0ACONFIG_=
HID_ROCCAT=3Dy=0D=0ACONFIG_HID_SAITEK=3Dy=0D=0ACONFIG_HID_SAMSUNG=3Dy=0D=0A=
CONFIG_HID_SEMITEK=3Dy=0D=0ACONFIG_HID_SIGMAMICRO=3Dy=0D=0ACONFIG_HID_SONY=
=3Dy=0D=0ACONFIG_SONY_FF=3Dy=0D=0ACONFIG_HID_SPEEDLINK=3Dy=0D=0ACONFIG_HID_=
STEAM=3Dy=0D=0ACONFIG_STEAM_FF=3Dy=0D=0ACONFIG_HID_STEELSERIES=3Dy=0D=0ACON=
FIG_HID_SUNPLUS=3Dy=0D=0ACONFIG_HID_RMI=3Dy=0D=0ACONFIG_HID_GREENASIA=3Dy=
=0D=0ACONFIG_GREENASIA_FF=3Dy=0D=0ACONFIG_HID_SMARTJOYPLUS=3Dy=0D=0ACONFIG_=
SMARTJOYPLUS_FF=3Dy=0D=0ACONFIG_HID_TIVO=3Dy=0D=0ACONFIG_HID_TOPSEED=3Dy=0D=
=0ACONFIG_HID_TOPRE=3Dy=0D=0ACONFIG_HID_THINGM=3Dy=0D=0ACONFIG_HID_THRUSTMA=
STER=3Dy=0D=0ACONFIG_THRUSTMASTER_FF=3Dy=0D=0ACONFIG_HID_UDRAW_PS3=3Dy=0D=
=0ACONFIG_HID_U2FZERO=3Dy=0D=0A#=20CONFIG_HID_UNIVERSAL_PIDFF=20is=20not=20=
set=0D=0ACONFIG_HID_WACOM=3Dy=0D=0ACONFIG_HID_WIIMOTE=3Dy=0D=0A#=20CONFIG_H=
ID_WINWING=20is=20not=20set=0D=0ACONFIG_HID_XINMO=3Dy=0D=0ACONFIG_HID_ZEROP=
LUS=3Dy=0D=0ACONFIG_ZEROPLUS_FF=3Dy=0D=0ACONFIG_HID_ZYDACRON=3Dy=0D=0ACONFI=
G_HID_SENSOR_HUB=3Dy=0D=0ACONFIG_HID_SENSOR_CUSTOM_SENSOR=3Dy=0D=0ACONFIG_H=
ID_ALPS=3Dy=0D=0ACONFIG_HID_MCP2200=3Dy=0D=0ACONFIG_HID_MCP2221=3Dy=0D=0A#=
=20end=20of=20Special=20HID=20drivers=0D=0A=0D=0A#=0D=0A#=20HID-BPF=20suppo=
rt=0D=0A#=0D=0A#=20end=20of=20HID-BPF=20support=0D=0A=0D=0ACONFIG_I2C_HID=
=3Dy=0D=0ACONFIG_I2C_HID_ACPI=3Dy=0D=0ACONFIG_I2C_HID_OF=3Dy=0D=0A#=20CONFI=
G_I2C_HID_OF_ELAN=20is=20not=20set=0D=0A#=20CONFIG_I2C_HID_OF_GOODIX=20is=
=20not=20set=0D=0ACONFIG_I2C_HID_CORE=3Dy=0D=0A=0D=0A#=0D=0A#=20Intel=20ISH=
=20HID=20support=0D=0A#=0D=0ACONFIG_INTEL_ISH_HID=3Dy=0D=0ACONFIG_INTEL_ISH=
_FIRMWARE_DOWNLOADER=3Dy=0D=0A#=20end=20of=20Intel=20ISH=20HID=20support=0D=
=0A=0D=0A#=0D=0A#=20AMD=20SFH=20HID=20Support=0D=0A#=0D=0ACONFIG_AMD_SFH_HI=
D=3Dy=0D=0A#=20end=20of=20AMD=20SFH=20HID=20Support=0D=0A=0D=0A#=0D=0A#=20S=
urface=20System=20Aggregator=20Module=20HID=20support=0D=0A#=0D=0ACONFIG_SU=
RFACE_HID=3Dy=0D=0ACONFIG_SURFACE_KBD=3Dy=0D=0A#=20end=20of=20Surface=20Sys=
tem=20Aggregator=20Module=20HID=20support=0D=0A=0D=0ACONFIG_SURFACE_HID_COR=
E=3Dy=0D=0A=0D=0A#=0D=0A#=20Intel=20THC=20HID=20Support=0D=0A#=0D=0A#=20CON=
FIG_INTEL_THC_HID=20is=20not=20set=0D=0A#=20end=20of=20Intel=20THC=20HID=20=
Support=0D=0A=0D=0A#=0D=0A#=20USB=20HID=20support=0D=0A#=0D=0ACONFIG_USB_HI=
D=3Dy=0D=0ACONFIG_HID_PID=3Dy=0D=0ACONFIG_USB_HIDDEV=3Dy=0D=0A#=20end=20of=
=20USB=20HID=20support=0D=0A=0D=0ACONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy=0D=0ACO=
NFIG_USB_SUPPORT=3Dy=0D=0ACONFIG_USB_COMMON=3Dy=0D=0ACONFIG_USB_LED_TRIG=3D=
y=0D=0ACONFIG_USB_ULPI_BUS=3Dy=0D=0ACONFIG_USB_CONN_GPIO=3Dy=0D=0ACONFIG_US=
B_ARCH_HAS_HCD=3Dy=0D=0ACONFIG_USB=3Dy=0D=0ACONFIG_USB_PCI=3Dy=0D=0ACONFIG_=
USB_PCI_AMD=3Dy=0D=0ACONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy=0D=0A=0D=0A#=0D=0A=
#=20Miscellaneous=20USB=20options=0D=0A#=0D=0ACONFIG_USB_DEFAULT_PERSIST=3D=
y=0D=0A#=20CONFIG_USB_FEW_INIT_RETRIES=20is=20not=20set=0D=0ACONFIG_USB_DYN=
AMIC_MINORS=3Dy=0D=0ACONFIG_USB_OTG=3Dy=0D=0A#=20CONFIG_USB_OTG_PRODUCTLIST=
=20is=20not=20set=0D=0A#=20CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=20is=20not=
=20set=0D=0ACONFIG_USB_OTG_FSM=3Dy=0D=0ACONFIG_USB_LEDS_TRIGGER_USBPORT=3Dy=
=0D=0ACONFIG_USB_AUTOSUSPEND_DELAY=3D2=0D=0ACONFIG_USB_DEFAULT_AUTHORIZATIO=
N_MODE=3D1=0D=0ACONFIG_USB_MON=3Dy=0D=0A=0D=0A#=0D=0A#=20USB=20Host=20Contr=
oller=20Drivers=0D=0A#=0D=0ACONFIG_USB_C67X00_HCD=3Dy=0D=0ACONFIG_USB_XHCI_=
HCD=3Dy=0D=0ACONFIG_USB_XHCI_DBGCAP=3Dy=0D=0ACONFIG_USB_XHCI_PCI=3Dy=0D=0AC=
ONFIG_USB_XHCI_PCI_RENESAS=3Dy=0D=0ACONFIG_USB_XHCI_PLATFORM=3Dy=0D=0A#=20C=
ONFIG_USB_XHCI_SIDEBAND=20is=20not=20set=0D=0ACONFIG_USB_EHCI_HCD=3Dy=0D=0A=
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy=0D=0ACONFIG_USB_EHCI_TT_NEWSCHED=3Dy=0D=0AC=
ONFIG_USB_EHCI_PCI=3Dy=0D=0ACONFIG_USB_EHCI_FSL=3Dy=0D=0ACONFIG_USB_EHCI_HC=
D_PLATFORM=3Dy=0D=0ACONFIG_USB_OXU210HP_HCD=3Dy=0D=0ACONFIG_USB_ISP116X_HCD=
=3Dy=0D=0ACONFIG_USB_MAX3421_HCD=3Dy=0D=0ACONFIG_USB_OHCI_HCD=3Dy=0D=0ACONF=
IG_USB_OHCI_HCD_PCI=3Dy=0D=0A#=20CONFIG_USB_OHCI_HCD_SSB=20is=20not=20set=
=0D=0ACONFIG_USB_OHCI_HCD_PLATFORM=3Dy=0D=0ACONFIG_USB_UHCI_HCD=3Dy=0D=0ACO=
NFIG_USB_SL811_HCD=3Dy=0D=0ACONFIG_USB_SL811_HCD_ISO=3Dy=0D=0ACONFIG_USB_SL=
811_CS=3Dy=0D=0ACONFIG_USB_R8A66597_HCD=3Dy=0D=0ACONFIG_USB_HCD_BCMA=3Dy=0D=
=0ACONFIG_USB_HCD_SSB=3Dy=0D=0A#=20CONFIG_USB_HCD_TEST_MODE=20is=20not=20se=
t=0D=0A=0D=0A#=0D=0A#=20USB=20Device=20Class=20drivers=0D=0A#=0D=0ACONFIG_U=
SB_ACM=3Dy=0D=0ACONFIG_USB_PRINTER=3Dy=0D=0ACONFIG_USB_WDM=3Dy=0D=0ACONFIG_=
USB_TMC=3Dy=0D=0A=0D=0A#=0D=0A#=20NOTE:=20USB_STORAGE=20depends=20on=20SCSI=
=20but=20BLK_DEV_SD=20may=20also=20be=20needed;=20see=20USB_STORAGE=20Help=
=20for=20more=20info=0D=0A#=0D=0ACONFIG_USB_STORAGE=3Dy=0D=0A#=20CONFIG_USB=
_STORAGE_DEBUG=20is=20not=20set=0D=0ACONFIG_USB_STORAGE_REALTEK=3Dy=0D=0ACO=
NFIG_REALTEK_AUTOPM=3Dy=0D=0ACONFIG_USB_STORAGE_DATAFAB=3Dy=0D=0ACONFIG_USB=
_STORAGE_FREECOM=3Dy=0D=0ACONFIG_USB_STORAGE_ISD200=3Dy=0D=0ACONFIG_USB_STO=
RAGE_USBAT=3Dy=0D=0ACONFIG_USB_STORAGE_SDDR09=3Dy=0D=0ACONFIG_USB_STORAGE_S=
DDR55=3Dy=0D=0ACONFIG_USB_STORAGE_JUMPSHOT=3Dy=0D=0ACONFIG_USB_STORAGE_ALAU=
DA=3Dy=0D=0ACONFIG_USB_STORAGE_ONETOUCH=3Dy=0D=0ACONFIG_USB_STORAGE_KARMA=
=3Dy=0D=0ACONFIG_USB_STORAGE_CYPRESS_ATACB=3Dy=0D=0ACONFIG_USB_STORAGE_ENE_=
UB6250=3Dy=0D=0ACONFIG_USB_UAS=3Dy=0D=0A=0D=0A#=0D=0A#=20USB=20Imaging=20de=
vices=0D=0A#=0D=0ACONFIG_USB_MDC800=3Dy=0D=0ACONFIG_USB_MICROTEK=3Dy=0D=0AC=
ONFIG_USBIP_CORE=3Dy=0D=0ACONFIG_USBIP_VHCI_HCD=3Dy=0D=0ACONFIG_USBIP_VHCI_=
HC_PORTS=3D8=0D=0ACONFIG_USBIP_VHCI_NR_HCS=3D1=0D=0ACONFIG_USBIP_HOST=3Dy=
=0D=0ACONFIG_USBIP_VUDC=3Dy=0D=0A#=20CONFIG_USBIP_DEBUG=20is=20not=20set=0D=
=0A=0D=0A#=0D=0A#=20USB=20dual-mode=20controller=20drivers=0D=0A#=0D=0ACONF=
IG_USB_CDNS_SUPPORT=3Dy=0D=0ACONFIG_USB_CDNS_HOST=3Dy=0D=0ACONFIG_USB_CDNS3=
=3Dy=0D=0ACONFIG_USB_CDNS3_GADGET=3Dy=0D=0ACONFIG_USB_CDNS3_HOST=3Dy=0D=0AC=
ONFIG_USB_CDNS3_PCI_WRAP=3Dy=0D=0ACONFIG_USB_CDNSP_PCI=3Dy=0D=0ACONFIG_USB_=
CDNSP_GADGET=3Dy=0D=0ACONFIG_USB_CDNSP_HOST=3Dy=0D=0ACONFIG_USB_MUSB_HDRC=
=3Dy=0D=0A#=20CONFIG_USB_MUSB_HOST=20is=20not=20set=0D=0A#=20CONFIG_USB_MUS=
B_GADGET=20is=20not=20set=0D=0ACONFIG_USB_MUSB_DUAL_ROLE=3Dy=0D=0A=0D=0A#=
=0D=0A#=20Platform=20Glue=20Layer=0D=0A#=0D=0A=0D=0A#=0D=0A#=20MUSB=20DMA=
=20mode=0D=0A#=0D=0ACONFIG_MUSB_PIO_ONLY=3Dy=0D=0ACONFIG_USB_DWC3=3Dy=0D=0A=
CONFIG_USB_DWC3_ULPI=3Dy=0D=0A#=20CONFIG_USB_DWC3_HOST=20is=20not=20set=0D=
=0A#=20CONFIG_USB_DWC3_GADGET=20is=20not=20set=0D=0ACONFIG_USB_DWC3_DUAL_RO=
LE=3Dy=0D=0A=0D=0A#=0D=0A#=20Platform=20Glue=20Driver=20Support=0D=0A#=0D=
=0ACONFIG_USB_DWC3_PCI=3Dy=0D=0ACONFIG_USB_DWC3_HAPS=3Dy=0D=0ACONFIG_USB_DW=
C3_OF_SIMPLE=3Dy=0D=0ACONFIG_USB_DWC3_GENERIC_PLAT=3Dy=0D=0ACONFIG_USB_DWC2=
=3Dy=0D=0ACONFIG_USB_DWC2_HOST=3Dy=0D=0A=0D=0A#=0D=0A#=20Gadget/Dual-role=
=20mode=20requires=20USB=20Gadget=20support=20to=20be=20enabled=0D=0A#=0D=
=0A#=20CONFIG_USB_DWC2_PERIPHERAL=20is=20not=20set=0D=0A#=20CONFIG_USB_DWC2=
_DUAL_ROLE=20is=20not=20set=0D=0ACONFIG_USB_DWC2_PCI=3Dy=0D=0A#=20CONFIG_US=
B_DWC2_DEBUG=20is=20not=20set=0D=0A#=20CONFIG_USB_DWC2_TRACK_MISSED_SOFS=20=
is=20not=20set=0D=0ACONFIG_USB_CHIPIDEA=3Dy=0D=0ACONFIG_USB_CHIPIDEA_UDC=3D=
y=0D=0ACONFIG_USB_CHIPIDEA_HOST=3Dy=0D=0ACONFIG_USB_CHIPIDEA_PCI=3Dy=0D=0AC=
ONFIG_USB_CHIPIDEA_MSM=3Dy=0D=0ACONFIG_USB_CHIPIDEA_NPCM=3Dy=0D=0A#=20CONFI=
G_USB_CHIPIDEA_IMX=20is=20not=20set=0D=0ACONFIG_USB_CHIPIDEA_GENERIC=3Dy=0D=
=0A#=20CONFIG_USB_CHIPIDEA_TEGRA=20is=20not=20set=0D=0ACONFIG_USB_ISP1760=
=3Dy=0D=0ACONFIG_USB_ISP1760_HCD=3Dy=0D=0ACONFIG_USB_ISP1761_UDC=3Dy=0D=0A#=
=20CONFIG_USB_ISP1760_HOST_ROLE=20is=20not=20set=0D=0A#=20CONFIG_USB_ISP176=
0_GADGET_ROLE=20is=20not=20set=0D=0ACONFIG_USB_ISP1760_DUAL_ROLE=3Dy=0D=0A=
=0D=0A#=0D=0A#=20USB=20port=20drivers=0D=0A#=0D=0ACONFIG_USB_SERIAL=3Dy=0D=
=0ACONFIG_USB_SERIAL_CONSOLE=3Dy=0D=0ACONFIG_USB_SERIAL_GENERIC=3Dy=0D=0ACO=
NFIG_USB_SERIAL_SIMPLE=3Dy=0D=0ACONFIG_USB_SERIAL_AIRCABLE=3Dy=0D=0ACONFIG_=
USB_SERIAL_ARK3116=3Dy=0D=0ACONFIG_USB_SERIAL_BELKIN=3Dy=0D=0ACONFIG_USB_SE=
RIAL_CH341=3Dy=0D=0ACONFIG_USB_SERIAL_WHITEHEAT=3Dy=0D=0ACONFIG_USB_SERIAL_=
DIGI_ACCELEPORT=3Dy=0D=0ACONFIG_USB_SERIAL_CP210X=3Dy=0D=0ACONFIG_USB_SERIA=
L_CYPRESS_M8=3Dy=0D=0ACONFIG_USB_SERIAL_EMPEG=3Dy=0D=0ACONFIG_USB_SERIAL_FT=
DI_SIO=3Dy=0D=0ACONFIG_USB_SERIAL_VISOR=3Dy=0D=0ACONFIG_USB_SERIAL_IPAQ=3Dy=
=0D=0ACONFIG_USB_SERIAL_IR=3Dy=0D=0ACONFIG_USB_SERIAL_EDGEPORT=3Dy=0D=0ACON=
FIG_USB_SERIAL_EDGEPORT_TI=3Dy=0D=0ACONFIG_USB_SERIAL_F81232=3Dy=0D=0ACONFI=
G_USB_SERIAL_F8153X=3Dy=0D=0ACONFIG_USB_SERIAL_GARMIN=3Dy=0D=0ACONFIG_USB_S=
ERIAL_IPW=3Dy=0D=0ACONFIG_USB_SERIAL_IUU=3Dy=0D=0ACONFIG_USB_SERIAL_KEYSPAN=
_PDA=3Dy=0D=0ACONFIG_USB_SERIAL_KEYSPAN=3Dy=0D=0ACONFIG_USB_SERIAL_KLSI=3Dy=
=0D=0ACONFIG_USB_SERIAL_KOBIL_SCT=3Dy=0D=0ACONFIG_USB_SERIAL_MCT_U232=3Dy=
=0D=0ACONFIG_USB_SERIAL_METRO=3Dy=0D=0ACONFIG_USB_SERIAL_MOS7720=3Dy=0D=0AC=
ONFIG_USB_SERIAL_MOS7715_PARPORT=3Dy=0D=0ACONFIG_USB_SERIAL_MOS7840=3Dy=0D=
=0ACONFIG_USB_SERIAL_MXUPORT=3Dy=0D=0ACONFIG_USB_SERIAL_NAVMAN=3Dy=0D=0ACON=
FIG_USB_SERIAL_PL2303=3Dy=0D=0ACONFIG_USB_SERIAL_OTI6858=3Dy=0D=0ACONFIG_US=
B_SERIAL_QCAUX=3Dy=0D=0ACONFIG_USB_SERIAL_QUALCOMM=3Dy=0D=0ACONFIG_USB_SERI=
AL_SPCP8X5=3Dy=0D=0ACONFIG_USB_SERIAL_SAFE=3Dy=0D=0A#=20CONFIG_USB_SERIAL_S=
AFE_PADDED=20is=20not=20set=0D=0ACONFIG_USB_SERIAL_SIERRAWIRELESS=3Dy=0D=0A=
CONFIG_USB_SERIAL_SYMBOL=3Dy=0D=0ACONFIG_USB_SERIAL_TI=3Dy=0D=0ACONFIG_USB_=
SERIAL_CYBERJACK=3Dy=0D=0ACONFIG_USB_SERIAL_WWAN=3Dy=0D=0ACONFIG_USB_SERIAL=
_OPTION=3Dy=0D=0ACONFIG_USB_SERIAL_OMNINET=3Dy=0D=0ACONFIG_USB_SERIAL_OPTIC=
ON=3Dy=0D=0ACONFIG_USB_SERIAL_XSENS_MT=3Dy=0D=0ACONFIG_USB_SERIAL_WISHBONE=
=3Dy=0D=0ACONFIG_USB_SERIAL_SSU100=3Dy=0D=0ACONFIG_USB_SERIAL_QT2=3Dy=0D=0A=
CONFIG_USB_SERIAL_UPD78F0730=3Dy=0D=0ACONFIG_USB_SERIAL_XR=3Dy=0D=0ACONFIG_=
USB_SERIAL_DEBUG=3Dy=0D=0A=0D=0A#=0D=0A#=20USB=20Miscellaneous=20drivers=0D=
=0A#=0D=0ACONFIG_USB_USS720=3Dy=0D=0ACONFIG_USB_EMI62=3Dy=0D=0ACONFIG_USB_E=
MI26=3Dy=0D=0ACONFIG_USB_ADUTUX=3Dy=0D=0ACONFIG_USB_SEVSEG=3Dy=0D=0ACONFIG_=
USB_LEGOTOWER=3Dy=0D=0ACONFIG_USB_LCD=3Dy=0D=0ACONFIG_USB_CYPRESS_CY7C63=3D=
y=0D=0ACONFIG_USB_CYTHERM=3Dy=0D=0ACONFIG_USB_IDMOUSE=3Dy=0D=0ACONFIG_USB_A=
PPLEDISPLAY=3Dy=0D=0ACONFIG_APPLE_MFI_FASTCHARGE=3Dy=0D=0ACONFIG_USB_LJCA=
=3Dy=0D=0A#=20CONFIG_USB_USBIO=20is=20not=20set=0D=0ACONFIG_USB_SISUSBVGA=
=3Dy=0D=0ACONFIG_USB_LD=3Dy=0D=0ACONFIG_USB_TRANCEVIBRATOR=3Dy=0D=0ACONFIG_=
USB_IOWARRIOR=3Dy=0D=0ACONFIG_USB_TEST=3Dy=0D=0ACONFIG_USB_EHSET_TEST_FIXTU=
RE=3Dy=0D=0ACONFIG_USB_ISIGHTFW=3Dy=0D=0ACONFIG_USB_YUREX=3Dy=0D=0ACONFIG_U=
SB_EZUSB_FX2=3Dy=0D=0ACONFIG_USB_HUB_USB251XB=3Dy=0D=0ACONFIG_USB_HSIC_USB3=
503=3Dy=0D=0ACONFIG_USB_HSIC_USB4604=3Dy=0D=0ACONFIG_USB_LINK_LAYER_TEST=3D=
y=0D=0ACONFIG_USB_CHAOSKEY=3Dy=0D=0A#=20CONFIG_USB_ONBOARD_DEV=20is=20not=
=20set=0D=0ACONFIG_USB_ATM=3Dy=0D=0ACONFIG_USB_SPEEDTOUCH=3Dy=0D=0ACONFIG_U=
SB_CXACRU=3Dy=0D=0ACONFIG_USB_UEAGLEATM=3Dy=0D=0ACONFIG_USB_XUSBATM=3Dy=0D=
=0A=0D=0A#=0D=0A#=20USB=20Physical=20Layer=20drivers=0D=0A#=0D=0ACONFIG_USB=
_PHY=3Dy=0D=0ACONFIG_NOP_USB_XCEIV=3Dy=0D=0ACONFIG_TAHVO_USB=3Dy=0D=0ACONFI=
G_TAHVO_USB_HOST_BY_DEFAULT=3Dy=0D=0ACONFIG_USB_ISP1301=3Dy=0D=0A#=20end=20=
of=20USB=20Physical=20Layer=20drivers=0D=0A=0D=0ACONFIG_USB_GADGET=3Dy=0D=
=0A#=20CONFIG_USB_GADGET_DEBUG=20is=20not=20set=0D=0ACONFIG_USB_GADGET_DEBU=
G_FILES=3Dy=0D=0ACONFIG_USB_GADGET_DEBUG_FS=3Dy=0D=0ACONFIG_USB_GADGET_VBUS=
_DRAW=3D2=0D=0ACONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=3D2=0D=0A=0D=0A#=0D=0A=
#=20USB=20Peripheral=20Controller=0D=0A#=0D=0ACONFIG_USB_GR_UDC=3Dy=0D=0ACO=
NFIG_USB_R8A66597=3Dy=0D=0ACONFIG_USB_PXA27X=3Dy=0D=0ACONFIG_USB_SNP_CORE=
=3Dy=0D=0A#=20CONFIG_USB_SNP_UDC_PLAT=20is=20not=20set=0D=0A#=20CONFIG_USB_=
M66592=20is=20not=20set=0D=0ACONFIG_USB_BDC_UDC=3Dy=0D=0ACONFIG_USB_AMD5536=
UDC=3Dy=0D=0ACONFIG_USB_NET2280=3Dy=0D=0ACONFIG_USB_GOKU=3Dy=0D=0ACONFIG_US=
B_EG20T=3Dy=0D=0A#=20CONFIG_USB_GADGET_XILINX=20is=20not=20set=0D=0ACONFIG_=
USB_MAX3420_UDC=3Dy=0D=0ACONFIG_USB_CDNS2_UDC=3Dy=0D=0ACONFIG_USB_DUMMY_HCD=
=3Dy=0D=0A#=20end=20of=20USB=20Peripheral=20Controller=0D=0A=0D=0A#=20CONFI=
G_USB_CONFIGFS=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20USB=20Gadget=20precom=
posed=20configurations=0D=0A#=0D=0A#=20CONFIG_USB_ZERO=20is=20not=20set=0D=
=0A#=20CONFIG_USB_AUDIO=20is=20not=20set=0D=0A#=20CONFIG_USB_ETH=20is=20not=
=20set=0D=0A#=20CONFIG_USB_G_NCM=20is=20not=20set=0D=0A#=20CONFIG_USB_GADGE=
TFS=20is=20not=20set=0D=0A#=20CONFIG_USB_FUNCTIONFS=20is=20not=20set=0D=0A#=
=20CONFIG_USB_MASS_STORAGE=20is=20not=20set=0D=0A#=20CONFIG_USB_GADGET_TARG=
ET=20is=20not=20set=0D=0A#=20CONFIG_USB_G_SERIAL=20is=20not=20set=0D=0A#=20=
CONFIG_USB_MIDI_GADGET=20is=20not=20set=0D=0A#=20CONFIG_USB_G_PRINTER=20is=
=20not=20set=0D=0A#=20CONFIG_USB_CDC_COMPOSITE=20is=20not=20set=0D=0A#=20CO=
NFIG_USB_G_NOKIA=20is=20not=20set=0D=0A#=20CONFIG_USB_G_ACM_MS=20is=20not=
=20set=0D=0A#=20CONFIG_USB_G_MULTI=20is=20not=20set=0D=0A#=20CONFIG_USB_G_H=
ID=20is=20not=20set=0D=0A#=20CONFIG_USB_G_DBGP=20is=20not=20set=0D=0A#=20CO=
NFIG_USB_G_WEBCAM=20is=20not=20set=0D=0ACONFIG_USB_RAW_GADGET=3Dy=0D=0A#=20=
end=20of=20USB=20Gadget=20precomposed=20configurations=0D=0A=0D=0ACONFIG_TY=
PEC=3Dy=0D=0ACONFIG_TYPEC_TCPM=3Dy=0D=0ACONFIG_TYPEC_TCPCI=3Dy=0D=0ACONFIG_=
TYPEC_RT1711H=3Dy=0D=0ACONFIG_TYPEC_MT6360=3Dy=0D=0ACONFIG_TYPEC_TCPCI_MT63=
70=3Dy=0D=0ACONFIG_TYPEC_TCPCI_MAXIM=3Dy=0D=0ACONFIG_TYPEC_FUSB302=3Dy=0D=
=0ACONFIG_TYPEC_WCOVE=3Dy=0D=0ACONFIG_TYPEC_UCSI=3Dy=0D=0ACONFIG_UCSI_CCG=
=3Dy=0D=0ACONFIG_UCSI_ACPI=3Dy=0D=0ACONFIG_UCSI_STM32G0=3Dy=0D=0A#=20CONFIG=
_CROS_EC_UCSI=20is=20not=20set=0D=0ACONFIG_TYPEC_TPS6598X=3Dy=0D=0ACONFIG_T=
YPEC_ANX7411=3Dy=0D=0ACONFIG_TYPEC_RT1719=3Dy=0D=0ACONFIG_TYPEC_HD3SS3220=
=3Dy=0D=0ACONFIG_TYPEC_STUSB160X=3Dy=0D=0ACONFIG_TYPEC_WUSB3801=3Dy=0D=0A=
=0D=0A#=0D=0A#=20USB=20Type-C=20Multiplexer/DeMultiplexer=20Switch=20suppor=
t=0D=0A#=0D=0ACONFIG_TYPEC_MUX_FSA4480=3Dy=0D=0ACONFIG_TYPEC_MUX_GPIO_SBU=
=3Dy=0D=0ACONFIG_TYPEC_MUX_PI3USB30532=3Dy=0D=0ACONFIG_TYPEC_MUX_INTEL_PMC=
=3Dy=0D=0A#=20CONFIG_TYPEC_MUX_IT5205=20is=20not=20set=0D=0ACONFIG_TYPEC_MU=
X_NB7VPQ904M=3Dy=0D=0A#=20CONFIG_TYPEC_MUX_PS883X=20is=20not=20set=0D=0ACON=
FIG_TYPEC_MUX_PTN36502=3Dy=0D=0A#=20CONFIG_TYPEC_MUX_TUSB1046=20is=20not=20=
set=0D=0ACONFIG_TYPEC_MUX_WCD939X_USBSS=3Dy=0D=0A#=20end=20of=20USB=20Type-=
C=20Multiplexer/DeMultiplexer=20Switch=20support=0D=0A=0D=0A#=0D=0A#=20USB=
=20Type-C=20Alternate=20Mode=20drivers=0D=0A#=0D=0ACONFIG_TYPEC_DP_ALTMODE=
=3Dy=0D=0ACONFIG_TYPEC_NVIDIA_ALTMODE=3Dy=0D=0A#=20CONFIG_TYPEC_TBT_ALTMODE=
=20is=20not=20set=0D=0A#=20end=20of=20USB=20Type-C=20Alternate=20Mode=20dri=
vers=0D=0A=0D=0ACONFIG_USB_ROLE_SWITCH=3Dy=0D=0ACONFIG_USB_ROLES_INTEL_XHCI=
=3Dy=0D=0ACONFIG_MMC=3Dy=0D=0A#=20CONFIG_PWRSEQ_EMMC=20is=20not=20set=0D=0A=
#=20CONFIG_PWRSEQ_SD8787=20is=20not=20set=0D=0A#=20CONFIG_PWRSEQ_SIMPLE=20i=
s=20not=20set=0D=0A#=20CONFIG_MMC_BLOCK=20is=20not=20set=0D=0A#=20CONFIG_SD=
IO_UART=20is=20not=20set=0D=0A#=20CONFIG_MMC_TEST=20is=20not=20set=0D=0A=0D=
=0A#=0D=0A#=20MMC/SD/SDIO=20Host=20Controller=20Drivers=0D=0A#=0D=0A#=20CON=
FIG_MMC_DEBUG=20is=20not=20set=0D=0A#=20CONFIG_MMC_SDHCI=20is=20not=20set=
=0D=0A#=20CONFIG_MMC_WBSD=20is=20not=20set=0D=0A#=20CONFIG_MMC_TIFM_SD=20is=
=20not=20set=0D=0A#=20CONFIG_MMC_SPI=20is=20not=20set=0D=0A#=20CONFIG_MMC_S=
DRICOH_CS=20is=20not=20set=0D=0A#=20CONFIG_MMC_CB710=20is=20not=20set=0D=0A=
#=20CONFIG_MMC_VIA_SDMMC=20is=20not=20set=0D=0ACONFIG_MMC_VUB300=3Dy=0D=0AC=
ONFIG_MMC_USHC=3Dy=0D=0A#=20CONFIG_MMC_USDHI6ROL0=20is=20not=20set=0D=0ACON=
FIG_MMC_REALTEK_USB=3Dy=0D=0A#=20CONFIG_MMC_CQHCI=20is=20not=20set=0D=0A#=
=20CONFIG_MMC_HSQ=20is=20not=20set=0D=0A#=20CONFIG_MMC_TOSHIBA_PCI=20is=20n=
ot=20set=0D=0A#=20CONFIG_MMC_MTK=20is=20not=20set=0D=0A#=20CONFIG_SCSI_UFSH=
CD=20is=20not=20set=0D=0ACONFIG_MEMSTICK=3Dy=0D=0A#=20CONFIG_MEMSTICK_DEBUG=
=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20MemoryStick=20drivers=0D=0A#=0D=0A#=
=20CONFIG_MEMSTICK_UNSAFE_RESUME=20is=20not=20set=0D=0A#=20CONFIG_MSPRO_BLO=
CK=20is=20not=20set=0D=0A#=20CONFIG_MS_BLOCK=20is=20not=20set=0D=0A=0D=0A#=
=0D=0A#=20MemoryStick=20Host=20Controller=20Drivers=0D=0A#=0D=0A#=20CONFIG_=
MEMSTICK_TIFM_MS=20is=20not=20set=0D=0A#=20CONFIG_MEMSTICK_JMICRON_38X=20is=
=20not=20set=0D=0A#=20CONFIG_MEMSTICK_R592=20is=20not=20set=0D=0ACONFIG_MEM=
STICK_REALTEK_USB=3Dy=0D=0ACONFIG_NEW_LEDS=3Dy=0D=0ACONFIG_LEDS_CLASS=3Dy=
=0D=0A#=20CONFIG_LEDS_CLASS_FLASH=20is=20not=20set=0D=0ACONFIG_LEDS_CLASS_M=
ULTICOLOR=3Dy=0D=0A#=20CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=20is=20not=20set=
=0D=0A=0D=0A#=0D=0A#=20LED=20drivers=0D=0A#=0D=0A#=20CONFIG_LEDS_AN30259A=
=20is=20not=20set=0D=0A#=20CONFIG_LEDS_APU=20is=20not=20set=0D=0A#=20CONFIG=
_LEDS_AW200XX=20is=20not=20set=0D=0A#=20CONFIG_LEDS_AW2013=20is=20not=20set=
=0D=0A#=20CONFIG_LEDS_BCM6328=20is=20not=20set=0D=0A#=20CONFIG_LEDS_BCM6358=
=20is=20not=20set=0D=0A#=20CONFIG_LEDS_CHT_WCOVE=20is=20not=20set=0D=0A#=20=
CONFIG_LEDS_CR0014114=20is=20not=20set=0D=0A#=20CONFIG_LEDS_CROS_EC=20is=20=
not=20set=0D=0A#=20CONFIG_LEDS_EL15203000=20is=20not=20set=0D=0A#=20CONFIG_=
LEDS_LM3530=20is=20not=20set=0D=0A#=20CONFIG_LEDS_LM3532=20is=20not=20set=
=0D=0A#=20CONFIG_LEDS_LM3642=20is=20not=20set=0D=0A#=20CONFIG_LEDS_LM3692X=
=20is=20not=20set=0D=0A#=20CONFIG_LEDS_PCA9532=20is=20not=20set=0D=0A#=20CO=
NFIG_LEDS_GPIO=20is=20not=20set=0D=0A#=20CONFIG_LEDS_LP3944=20is=20not=20se=
t=0D=0A#=20CONFIG_LEDS_LP3952=20is=20not=20set=0D=0A#=20CONFIG_LEDS_LP50XX=
=20is=20not=20set=0D=0A#=20CONFIG_LEDS_LP55XX_COMMON=20is=20not=20set=0D=0A=
#=20CONFIG_LEDS_LP8860=20is=20not=20set=0D=0A#=20CONFIG_LEDS_LP8864=20is=20=
not=20set=0D=0A#=20CONFIG_LEDS_PCA955X=20is=20not=20set=0D=0A#=20CONFIG_LED=
S_PCA963X=20is=20not=20set=0D=0A#=20CONFIG_LEDS_PCA995X=20is=20not=20set=0D=
=0A#=20CONFIG_LEDS_DAC124S085=20is=20not=20set=0D=0A#=20CONFIG_LEDS_REGULAT=
OR=20is=20not=20set=0D=0A#=20CONFIG_LEDS_BD2606MVV=20is=20not=20set=0D=0A#=
=20CONFIG_LEDS_BD2802=20is=20not=20set=0D=0A#=20CONFIG_LEDS_INTEL_SS4200=20=
is=20not=20set=0D=0A#=20CONFIG_LEDS_LT3593=20is=20not=20set=0D=0A#=20CONFIG=
_LEDS_TCA6507=20is=20not=20set=0D=0A#=20CONFIG_LEDS_TLC591XX=20is=20not=20s=
et=0D=0A#=20CONFIG_LEDS_LM355x=20is=20not=20set=0D=0A#=20CONFIG_LEDS_IS31FL=
319X=20is=20not=20set=0D=0A#=20CONFIG_LEDS_IS31FL32XX=20is=20not=20set=0D=
=0A=0D=0A#=0D=0A#=20LED=20driver=20for=20blink(1)=20USB=20RGB=20LED=20is=20=
under=20Special=20HID=20drivers=20(HID_THINGM)=0D=0A#=0D=0A#=20CONFIG_LEDS_=
BLINKM=20is=20not=20set=0D=0A#=20CONFIG_LEDS_SYSCON=20is=20not=20set=0D=0A#=
=20CONFIG_LEDS_MLXCPLD=20is=20not=20set=0D=0A#=20CONFIG_LEDS_MLXREG=20is=20=
not=20set=0D=0A#=20CONFIG_LEDS_USER=20is=20not=20set=0D=0A#=20CONFIG_LEDS_N=
IC78BX=20is=20not=20set=0D=0A#=20CONFIG_LEDS_SPI_BYTE=20is=20not=20set=0D=
=0A#=20CONFIG_LEDS_LM3697=20is=20not=20set=0D=0A#=20CONFIG_LEDS_ST1202=20is=
=20not=20set=0D=0A#=20CONFIG_LEDS_LGM=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=
=20Flash=20and=20Torch=20LED=20drivers=0D=0A#=0D=0A=0D=0A#=0D=0A#=20RGB=20L=
ED=20drivers=0D=0A#=0D=0A#=20CONFIG_LEDS_GROUP_MULTICOLOR=20is=20not=20set=
=0D=0A#=20CONFIG_LEDS_KTD202X=20is=20not=20set=0D=0A#=20CONFIG_LEDS_NCP5623=
=20is=20not=20set=0D=0A#=20CONFIG_LEDS_MT6370_RGB=20is=20not=20set=0D=0A=0D=
=0A#=0D=0A#=20LED=20Triggers=0D=0A#=0D=0ACONFIG_LEDS_TRIGGERS=3Dy=0D=0A#=20=
CONFIG_LEDS_TRIGGER_TIMER=20is=20not=20set=0D=0A#=20CONFIG_LEDS_TRIGGER_ONE=
SHOT=20is=20not=20set=0D=0A#=20CONFIG_LEDS_TRIGGER_DISK=20is=20not=20set=0D=
=0A#=20CONFIG_LEDS_TRIGGER_HEARTBEAT=20is=20not=20set=0D=0A#=20CONFIG_LEDS_=
TRIGGER_BACKLIGHT=20is=20not=20set=0D=0A#=20CONFIG_LEDS_TRIGGER_CPU=20is=20=
not=20set=0D=0A#=20CONFIG_LEDS_TRIGGER_ACTIVITY=20is=20not=20set=0D=0A#=20C=
ONFIG_LEDS_TRIGGER_GPIO=20is=20not=20set=0D=0A#=20CONFIG_LEDS_TRIGGER_DEFAU=
LT_ON=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20iptables=20trigger=20is=20unde=
r=20Netfilter=20config=20(LED=20target)=0D=0A#=0D=0A#=20CONFIG_LEDS_TRIGGER=
_TRANSIENT=20is=20not=20set=0D=0A#=20CONFIG_LEDS_TRIGGER_CAMERA=20is=20not=
=20set=0D=0A#=20CONFIG_LEDS_TRIGGER_PANIC=20is=20not=20set=0D=0A#=20CONFIG_=
LEDS_TRIGGER_NETDEV=20is=20not=20set=0D=0A#=20CONFIG_LEDS_TRIGGER_PATTERN=
=20is=20not=20set=0D=0A#=20CONFIG_LEDS_TRIGGER_TTY=20is=20not=20set=0D=0A#=
=20CONFIG_LEDS_TRIGGER_INPUT_EVENTS=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20=
Simatic=20LED=20drivers=0D=0A#=0D=0A#=20CONFIG_ACCESSIBILITY=20is=20not=20s=
et=0D=0A#=20CONFIG_INFINIBAND=20is=20not=20set=0D=0ACONFIG_EDAC_ATOMIC_SCRU=
B=3Dy=0D=0ACONFIG_EDAC_SUPPORT=3Dy=0D=0ACONFIG_EDAC=3Dy=0D=0A#=20CONFIG_EDA=
C_LEGACY_SYSFS=20is=20not=20set=0D=0A#=20CONFIG_EDAC_DEBUG=20is=20not=20set=
=0D=0A#=20CONFIG_EDAC_DECODE_MCE=20is=20not=20set=0D=0A#=20CONFIG_EDAC_SCRU=
B=20is=20not=20set=0D=0A#=20CONFIG_EDAC_ECS=20is=20not=20set=0D=0A#=20CONFI=
G_EDAC_MEM_REPAIR=20is=20not=20set=0D=0A#=20CONFIG_EDAC_E752X=20is=20not=20=
set=0D=0A#=20CONFIG_EDAC_I82975X=20is=20not=20set=0D=0A#=20CONFIG_EDAC_I300=
0=20is=20not=20set=0D=0A#=20CONFIG_EDAC_I3200=20is=20not=20set=0D=0A#=20CON=
FIG_EDAC_IE31200=20is=20not=20set=0D=0A#=20CONFIG_EDAC_X38=20is=20not=20set=
=0D=0A#=20CONFIG_EDAC_I5400=20is=20not=20set=0D=0A#=20CONFIG_EDAC_I7CORE=20=
is=20not=20set=0D=0A#=20CONFIG_EDAC_I5100=20is=20not=20set=0D=0A#=20CONFIG_=
EDAC_I7300=20is=20not=20set=0D=0A#=20CONFIG_EDAC_SBRIDGE=20is=20not=20set=
=0D=0A#=20CONFIG_EDAC_SKX=20is=20not=20set=0D=0A#=20CONFIG_EDAC_I10NM=20is=
=20not=20set=0D=0A#=20CONFIG_EDAC_PND2=20is=20not=20set=0D=0A#=20CONFIG_EDA=
C_IGEN6=20is=20not=20set=0D=0ACONFIG_RTC_LIB=3Dy=0D=0ACONFIG_RTC_MC146818_L=
IB=3Dy=0D=0ACONFIG_RTC_CLASS=3Dy=0D=0A#=20CONFIG_RTC_HCTOSYS=20is=20not=20s=
et=0D=0ACONFIG_RTC_SYSTOHC=3Dy=0D=0ACONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"=0D=
=0A#=20CONFIG_RTC_DEBUG=20is=20not=20set=0D=0ACONFIG_RTC_NVMEM=3Dy=0D=0A=0D=
=0A#=0D=0A#=20RTC=20interfaces=0D=0A#=0D=0ACONFIG_RTC_INTF_SYSFS=3Dy=0D=0AC=
ONFIG_RTC_INTF_PROC=3Dy=0D=0ACONFIG_RTC_INTF_DEV=3Dy=0D=0A#=20CONFIG_RTC_IN=
TF_DEV_UIE_EMUL=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_TEST=20is=20not=20=
set=0D=0A=0D=0A#=0D=0A#=20I2C=20RTC=20drivers=0D=0A#=0D=0A#=20CONFIG_RTC_DR=
V_ABB5ZES3=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_ABEOZ9=20is=20not=20set=
=0D=0A#=20CONFIG_RTC_DRV_ABX80X=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_DS=
1307=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_DS1374=20is=20not=20set=0D=0A=
#=20CONFIG_RTC_DRV_DS1672=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_HYM8563=
=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_MAX6900=20is=20not=20set=0D=0A#=
=20CONFIG_RTC_DRV_MAX31335=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_NCT3018=
Y=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_RS5C372=20is=20not=20set=0D=0A#=
=20CONFIG_RTC_DRV_ISL1208=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_ISL12022=
=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_ISL12026=20is=20not=20set=0D=0A#=
=20CONFIG_RTC_DRV_X1205=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_PCF8523=20=
is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_PCF85363=20is=20not=20set=0D=0A#=20C=
ONFIG_RTC_DRV_PCF8563=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_PCF8583=20is=
=20not=20set=0D=0A#=20CONFIG_RTC_DRV_M41T80=20is=20not=20set=0D=0A#=20CONFI=
G_RTC_DRV_BQ32K=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_TWL4030=20is=20not=
=20set=0D=0A#=20CONFIG_RTC_DRV_S35390A=20is=20not=20set=0D=0A#=20CONFIG_RTC=
_DRV_FM3130=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_RX8010=20is=20not=20se=
t=0D=0A#=20CONFIG_RTC_DRV_RX8111=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_R=
X8581=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_RX8025=20is=20not=20set=0D=
=0A#=20CONFIG_RTC_DRV_EM3027=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_RV302=
8=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_RV3032=20is=20not=20set=0D=0A#=
=20CONFIG_RTC_DRV_RV8803=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_SD2405AL=
=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_SD3078=20is=20not=20set=0D=0A=0D=
=0A#=0D=0A#=20SPI=20RTC=20drivers=0D=0A#=0D=0A#=20CONFIG_RTC_DRV_M41T93=20i=
s=20not=20set=0D=0A#=20CONFIG_RTC_DRV_M41T94=20is=20not=20set=0D=0A#=20CONF=
IG_RTC_DRV_DS1302=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_DS1305=20is=20no=
t=20set=0D=0A#=20CONFIG_RTC_DRV_DS1343=20is=20not=20set=0D=0A#=20CONFIG_RTC=
_DRV_DS1347=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_DS1390=20is=20not=20se=
t=0D=0A#=20CONFIG_RTC_DRV_MAX6916=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_=
R9701=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_RX4581=20is=20not=20set=0D=
=0A#=20CONFIG_RTC_DRV_RS5C348=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_MAX6=
902=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_PCF2123=20is=20not=20set=0D=0A=
#=20CONFIG_RTC_DRV_MCP795=20is=20not=20set=0D=0ACONFIG_RTC_I2C_AND_SPI=3Dy=
=0D=0A=0D=0A#=0D=0A#=20SPI=20and=20I2C=20RTC=20drivers=0D=0A#=0D=0A#=20CONF=
IG_RTC_DRV_DS3232=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_PCF2127=20is=20n=
ot=20set=0D=0A#=20CONFIG_RTC_DRV_PCF85063=20is=20not=20set=0D=0A#=20CONFIG_=
RTC_DRV_RV3029C2=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_RX6110=20is=20not=
=20set=0D=0A=0D=0A#=0D=0A#=20Platform=20RTC=20drivers=0D=0A#=0D=0ACONFIG_RT=
C_DRV_CMOS=3Dy=0D=0A#=20CONFIG_RTC_DRV_DS1286=20is=20not=20set=0D=0A#=20CON=
FIG_RTC_DRV_DS1511=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_DS1553=20is=20n=
ot=20set=0D=0A#=20CONFIG_RTC_DRV_DS1685_FAMILY=20is=20not=20set=0D=0A#=20CO=
NFIG_RTC_DRV_DS1742=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_DS2404=20is=20=
not=20set=0D=0A#=20CONFIG_RTC_DRV_STK17TA8=20is=20not=20set=0D=0A#=20CONFIG=
_RTC_DRV_M48T86=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_M48T35=20is=20not=
=20set=0D=0A#=20CONFIG_RTC_DRV_M48T59=20is=20not=20set=0D=0A#=20CONFIG_RTC_=
DRV_MSM6242=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_RP5C01=20is=20not=20se=
t=0D=0A#=20CONFIG_RTC_DRV_ZYNQMP=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_C=
ROS_EC=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20on-CPU=20RTC=20drivers=0D=0A#=
=0D=0A#=20CONFIG_RTC_DRV_CADENCE=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_F=
TRTC010=20is=20not=20set=0D=0A#=20CONFIG_RTC_DRV_R7301=20is=20not=20set=0D=
=0A#=20CONFIG_RTC_DRV_GOLDFISH=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20HID=
=20Sensor=20RTC=20drivers=0D=0A#=0D=0ACONFIG_RTC_DRV_HID_SENSOR_TIME=3Dy=0D=
=0ACONFIG_DMADEVICES=3Dy=0D=0A#=20CONFIG_DMADEVICES_DEBUG=20is=20not=20set=
=0D=0A=0D=0A#=0D=0A#=20DMA=20Devices=0D=0A#=0D=0ACONFIG_DMA_ENGINE=3Dy=0D=
=0ACONFIG_DMA_VIRTUAL_CHANNELS=3Dy=0D=0ACONFIG_DMA_ACPI=3Dy=0D=0ACONFIG_DMA=
_OF=3Dy=0D=0A#=20CONFIG_ALTERA_MSGDMA=20is=20not=20set=0D=0A#=20CONFIG_DW_A=
XI_DMAC=20is=20not=20set=0D=0A#=20CONFIG_FSL_EDMA=20is=20not=20set=0D=0A#=
=20CONFIG_INTEL_IDMA64=20is=20not=20set=0D=0A#=20CONFIG_INTEL_IDXD=20is=20n=
ot=20set=0D=0A#=20CONFIG_INTEL_IDXD_COMPAT=20is=20not=20set=0D=0A#=20CONFIG=
_INTEL_IOATDMA=20is=20not=20set=0D=0A#=20CONFIG_PLX_DMA=20is=20not=20set=0D=
=0A#=20CONFIG_XILINX_DMA=20is=20not=20set=0D=0A#=20CONFIG_XILINX_XDMA=20is=
=20not=20set=0D=0A#=20CONFIG_XILINX_ZYNQMP_DPDMA=20is=20not=20set=0D=0A#=20=
CONFIG_AMD_PTDMA=20is=20not=20set=0D=0A#=20CONFIG_AMD_QDMA=20is=20not=20set=
=0D=0A#=20CONFIG_QCOM_HIDMA_MGMT=20is=20not=20set=0D=0A#=20CONFIG_QCOM_HIDM=
A=20is=20not=20set=0D=0ACONFIG_DW_DMAC_CORE=3Dy=0D=0A#=20CONFIG_DW_DMAC=20i=
s=20not=20set=0D=0A#=20CONFIG_DW_DMAC_PCI=20is=20not=20set=0D=0A#=20CONFIG_=
DW_EDMA=20is=20not=20set=0D=0ACONFIG_HSU_DMA=3Dy=0D=0A#=20CONFIG_SF_PDMA=20=
is=20not=20set=0D=0A#=20CONFIG_INTEL_LDMA=20is=20not=20set=0D=0A=0D=0A#=0D=
=0A#=20DMA=20Clients=0D=0A#=0D=0A#=20CONFIG_ASYNC_TX_DMA=20is=20not=20set=
=0D=0A#=20CONFIG_DMATEST=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20DMABUF=20op=
tions=0D=0A#=0D=0ACONFIG_SYNC_FILE=3Dy=0D=0A#=20CONFIG_SW_SYNC=20is=20not=
=20set=0D=0A#=20CONFIG_UDMABUF=20is=20not=20set=0D=0A#=20CONFIG_DMABUF_MOVE=
_NOTIFY=20is=20not=20set=0D=0A#=20CONFIG_DMABUF_DEBUG=20is=20not=20set=0D=
=0A#=20CONFIG_DMABUF_SELFTESTS=20is=20not=20set=0D=0A#=20CONFIG_DMABUF_HEAP=
S=20is=20not=20set=0D=0A#=20CONFIG_DMABUF_SYSFS_STATS=20is=20not=20set=0D=
=0A#=20end=20of=20DMABUF=20options=0D=0A=0D=0A#=20CONFIG_UIO=20is=20not=20s=
et=0D=0A#=20CONFIG_VFIO=20is=20not=20set=0D=0A#=20CONFIG_VIRT_DRIVERS=20is=
=20not=20set=0D=0ACONFIG_VIRTIO_ANCHOR=3Dy=0D=0ACONFIG_VIRTIO=3Dy=0D=0ACONF=
IG_VIRTIO_PCI_LIB=3Dy=0D=0ACONFIG_VIRTIO_PCI_LIB_LEGACY=3Dy=0D=0ACONFIG_VIR=
TIO_MENU=3Dy=0D=0ACONFIG_VIRTIO_PCI=3Dy=0D=0ACONFIG_VIRTIO_PCI_ADMIN_LEGACY=
=3Dy=0D=0ACONFIG_VIRTIO_PCI_LEGACY=3Dy=0D=0A#=20CONFIG_VIRTIO_BALLOON=20is=
=20not=20set=0D=0ACONFIG_VIRTIO_INPUT=3Dy=0D=0A#=20CONFIG_VIRTIO_MMIO=20is=
=20not=20set=0D=0ACONFIG_VIRTIO_DMA_SHARED_BUFFER=3Dy=0D=0A#=20CONFIG_VIRTI=
O_DEBUG=20is=20not=20set=0D=0A#=20CONFIG_VIRTIO_RTC=20is=20not=20set=0D=0A#=
=20CONFIG_VDPA=20is=20not=20set=0D=0ACONFIG_VHOST_MENU=3Dy=0D=0A#=20CONFIG_=
VHOST_NET=20is=20not=20set=0D=0A#=20CONFIG_VHOST_SCSI=20is=20not=20set=0D=
=0A#=20CONFIG_VHOST_CROSS_ENDIAN_LEGACY=20is=20not=20set=0D=0ACONFIG_VHOST_=
ENABLE_FORK_OWNER_CONTROL=3Dy=0D=0A=0D=0A#=0D=0A#=20Microsoft=20Hyper-V=20g=
uest=20support=0D=0A#=0D=0A#=20CONFIG_HYPERV=20is=20not=20set=0D=0A#=20end=
=20of=20Microsoft=20Hyper-V=20guest=20support=0D=0A=0D=0ACONFIG_GREYBUS=3Dy=
=0D=0A#=20CONFIG_GREYBUS_BEAGLEPLAY=20is=20not=20set=0D=0ACONFIG_GREYBUS_ES=
2=3Dy=0D=0ACONFIG_COMEDI=3Dy=0D=0A#=20CONFIG_COMEDI_DEBUG=20is=20not=20set=
=0D=0ACONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=3D2048=0D=0ACONFIG_COMEDI_DEFAULT_B=
UF_MAXSIZE_KB=3D20480=0D=0A#=20CONFIG_COMEDI_MISC_DRIVERS=20is=20not=20set=
=0D=0A#=20CONFIG_COMEDI_PCI_DRIVERS=20is=20not=20set=0D=0A#=20CONFIG_COMEDI=
_PCMCIA_DRIVERS=20is=20not=20set=0D=0ACONFIG_COMEDI_USB_DRIVERS=3Dy=0D=0ACO=
NFIG_COMEDI_DT9812=3Dy=0D=0ACONFIG_COMEDI_NI_USB6501=3Dy=0D=0ACONFIG_COMEDI=
_USBDUX=3Dy=0D=0ACONFIG_COMEDI_USBDUXFAST=3Dy=0D=0ACONFIG_COMEDI_USBDUXSIGM=
A=3Dy=0D=0ACONFIG_COMEDI_VMK80XX=3Dy=0D=0A#=20CONFIG_COMEDI_8255_SA=20is=20=
not=20set=0D=0A#=20CONFIG_COMEDI_KCOMEDILIB=20is=20not=20set=0D=0A#=20CONFI=
G_COMEDI_TESTS=20is=20not=20set=0D=0ACONFIG_STAGING=3Dy=0D=0A#=20CONFIG_RTL=
8723BS=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20IIO=20staging=20drivers=0D=0A=
#=0D=0A=0D=0A#=0D=0A#=20Accelerometers=0D=0A#=0D=0A#=20CONFIG_ADIS16203=20i=
s=20not=20set=0D=0A#=20end=20of=20Accelerometers=0D=0A=0D=0A#=0D=0A#=20Anal=
og=20to=20digital=20converters=0D=0A#=0D=0A#=20CONFIG_AD7816=20is=20not=20s=
et=0D=0A#=20end=20of=20Analog=20to=20digital=20converters=0D=0A=0D=0A#=0D=
=0A#=20Analog=20digital=20bi-direction=20converters=0D=0A#=0D=0A#=20CONFIG_=
ADT7316=20is=20not=20set=0D=0A#=20end=20of=20Analog=20digital=20bi-directio=
n=20converters=0D=0A=0D=0A#=0D=0A#=20Direct=20Digital=20Synthesis=0D=0A#=0D=
=0A#=20CONFIG_AD9832=20is=20not=20set=0D=0A#=20CONFIG_AD9834=20is=20not=20s=
et=0D=0A#=20end=20of=20Direct=20Digital=20Synthesis=0D=0A=0D=0A#=0D=0A#=20N=
etwork=20Analyzer,=20Impedance=20Converters=0D=0A#=0D=0A#=20CONFIG_AD5933=
=20is=20not=20set=0D=0A#=20end=20of=20Network=20Analyzer,=20Impedance=20Con=
verters=0D=0A#=20end=20of=20IIO=20staging=20drivers=0D=0A=0D=0A#=20CONFIG_F=
B_SM750=20is=20not=20set=0D=0A#=20CONFIG_STAGING_MEDIA=20is=20not=20set=0D=
=0A#=20CONFIG_FB_TFT=20is=20not=20set=0D=0A#=20CONFIG_MOST_COMPONENTS=20is=
=20not=20set=0D=0A#=20CONFIG_GREYBUS_AUDIO=20is=20not=20set=0D=0A#=20CONFIG=
_GREYBUS_BOOTROM=20is=20not=20set=0D=0A#=20CONFIG_GREYBUS_FIRMWARE=20is=20n=
ot=20set=0D=0ACONFIG_GREYBUS_HID=3Dy=0D=0A#=20CONFIG_GREYBUS_LOG=20is=20not=
=20set=0D=0A#=20CONFIG_GREYBUS_LOOPBACK=20is=20not=20set=0D=0A#=20CONFIG_GR=
EYBUS_POWER=20is=20not=20set=0D=0A#=20CONFIG_GREYBUS_RAW=20is=20not=20set=
=0D=0A#=20CONFIG_GREYBUS_VIBRATOR=20is=20not=20set=0D=0ACONFIG_GREYBUS_BRID=
GED_PHY=3Dy=0D=0A#=20CONFIG_GREYBUS_GPIO=20is=20not=20set=0D=0A#=20CONFIG_G=
REYBUS_I2C=20is=20not=20set=0D=0A#=20CONFIG_GREYBUS_SDIO=20is=20not=20set=
=0D=0A#=20CONFIG_GREYBUS_SPI=20is=20not=20set=0D=0A#=20CONFIG_GREYBUS_UART=
=20is=20not=20set=0D=0ACONFIG_GREYBUS_USB=3Dy=0D=0A#=20CONFIG_XIL_AXIS_FIFO=
=20is=20not=20set=0D=0A#=20CONFIG_VME_BUS=20is=20not=20set=0D=0A#=20CONFIG_=
GPIB=20is=20not=20set=0D=0A#=20CONFIG_GOLDFISH=20is=20not=20set=0D=0ACONFIG=
_CHROME_PLATFORMS=3Dy=0D=0A#=20CONFIG_CHROMEOS_ACPI=20is=20not=20set=0D=0A#=
=20CONFIG_CHROMEOS_LAPTOP=20is=20not=20set=0D=0A#=20CONFIG_CHROMEOS_PSTORE=
=20is=20not=20set=0D=0A#=20CONFIG_CHROMEOS_TBMC=20is=20not=20set=0D=0A#=20C=
ONFIG_CHROMEOS_OF_HW_PROBER=20is=20not=20set=0D=0ACONFIG_CROS_EC=3Dy=0D=0A#=
=20CONFIG_CROS_EC_I2C=20is=20not=20set=0D=0ACONFIG_CROS_EC_ISHTP=3Dy=0D=0A#=
=20CONFIG_CROS_EC_SPI=20is=20not=20set=0D=0A#=20CONFIG_CROS_EC_UART=20is=20=
not=20set=0D=0A#=20CONFIG_CROS_EC_LPC=20is=20not=20set=0D=0ACONFIG_CROS_EC_=
PROTO=3Dy=0D=0A#=20CONFIG_CROS_KBD_LED_BACKLIGHT=20is=20not=20set=0D=0A#=20=
CONFIG_CROS_EC_CHARDEV=20is=20not=20set=0D=0A#=20CONFIG_CROS_EC_LIGHTBAR=20=
is=20not=20set=0D=0A#=20CONFIG_CROS_EC_VBC=20is=20not=20set=0D=0A#=20CONFIG=
_CROS_EC_DEBUGFS=20is=20not=20set=0D=0A#=20CONFIG_CROS_EC_SENSORHUB=20is=20=
not=20set=0D=0A#=20CONFIG_CROS_EC_SYSFS=20is=20not=20set=0D=0ACONFIG_CROS_E=
C_TYPEC_ALTMODES=3Dy=0D=0ACONFIG_CROS_EC_TYPEC=3Dy=0D=0ACONFIG_CROS_HPS_I2C=
=3Dy=0D=0ACONFIG_CROS_USBPD_NOTIFY=3Dy=0D=0A#=20CONFIG_CHROMEOS_PRIVACY_SCR=
EEN=20is=20not=20set=0D=0ACONFIG_CROS_TYPEC_SWITCH=3Dy=0D=0A#=20CONFIG_MELL=
ANOX_PLATFORM=20is=20not=20set=0D=0ACONFIG_SURFACE_PLATFORMS=3Dy=0D=0A#=20C=
ONFIG_SURFACE3_WMI=20is=20not=20set=0D=0A#=20CONFIG_SURFACE_3_POWER_OPREGIO=
N=20is=20not=20set=0D=0A#=20CONFIG_SURFACE_ACPI_NOTIFY=20is=20not=20set=0D=
=0A#=20CONFIG_SURFACE_AGGREGATOR_CDEV=20is=20not=20set=0D=0A#=20CONFIG_SURF=
ACE_AGGREGATOR_HUB=20is=20not=20set=0D=0ACONFIG_SURFACE_AGGREGATOR_REGISTRY=
=3Dy=0D=0A#=20CONFIG_SURFACE_AGGREGATOR_TABLET_SWITCH=20is=20not=20set=0D=
=0A#=20CONFIG_SURFACE_DTX=20is=20not=20set=0D=0A#=20CONFIG_SURFACE_GPE=20is=
=20not=20set=0D=0A#=20CONFIG_SURFACE_HOTPLUG=20is=20not=20set=0D=0A#=20CONF=
IG_SURFACE_PLATFORM_PROFILE=20is=20not=20set=0D=0A#=20CONFIG_SURFACE_PRO3_B=
UTTON=20is=20not=20set=0D=0ACONFIG_SURFACE_AGGREGATOR=3Dy=0D=0ACONFIG_SURFA=
CE_AGGREGATOR_BUS=3Dy=0D=0ACONFIG_X86_PLATFORM_DEVICES=3Dy=0D=0ACONFIG_ACPI=
_WMI=3Dy=0D=0A#=20CONFIG_ACPI_WMI_LEGACY_DEVICE_NAMES=20is=20not=20set=0D=
=0ACONFIG_WMI_BMOF=3Dy=0D=0A#=20CONFIG_HUAWEI_WMI=20is=20not=20set=0D=0A#=
=20CONFIG_MXM_WMI=20is=20not=20set=0D=0A#=20CONFIG_NVIDIA_WMI_EC_BACKLIGHT=
=20is=20not=20set=0D=0A#=20CONFIG_XIAOMI_WMI=20is=20not=20set=0D=0A#=20CONF=
IG_REDMI_WMI=20is=20not=20set=0D=0A#=20CONFIG_GIGABYTE_WMI=20is=20not=20set=
=0D=0A#=20CONFIG_ACERHDF=20is=20not=20set=0D=0A#=20CONFIG_ACER_WIRELESS=20i=
s=20not=20set=0D=0A#=20CONFIG_ACER_WMI=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=
=20AMD=20HSMP=20Driver=0D=0A#=0D=0A#=20CONFIG_AMD_HSMP_ACPI=20is=20not=20se=
t=0D=0A#=20CONFIG_AMD_HSMP_PLAT=20is=20not=20set=0D=0A#=20end=20of=20AMD=20=
HSMP=20Driver=0D=0A=0D=0ACONFIG_AMD_PMF=3Dy=0D=0ACONFIG_AMD_PMF_DEBUG=3Dy=
=0D=0A#=20CONFIG_AMD_PMC=20is=20not=20set=0D=0A#=20CONFIG_AMD_HFI=20is=20no=
t=20set=0D=0A#=20CONFIG_AMD_3D_VCACHE=20is=20not=20set=0D=0A#=20CONFIG_AMD_=
WBRF=20is=20not=20set=0D=0A#=20CONFIG_AMD_ISP_PLATFORM=20is=20not=20set=0D=
=0A#=20CONFIG_ADV_SWBUTTON=20is=20not=20set=0D=0A#=20CONFIG_APPLE_GMUX=20is=
=20not=20set=0D=0A#=20CONFIG_ASUS_LAPTOP=20is=20not=20set=0D=0A#=20CONFIG_A=
SUS_WIRELESS=20is=20not=20set=0D=0ACONFIG_ASUS_WMI=3Dy=0D=0A#=20CONFIG_ASUS=
_NB_WMI=20is=20not=20set=0D=0ACONFIG_ASUS_TF103C_DOCK=3Dy=0D=0ACONFIG_EEEPC=
_LAPTOP=3Dy=0D=0A#=20CONFIG_EEEPC_WMI=20is=20not=20set=0D=0A#=20CONFIG_X86_=
PLATFORM_DRIVERS_DELL=20is=20not=20set=0D=0A#=20CONFIG_AMILO_RFKILL=20is=20=
not=20set=0D=0A#=20CONFIG_FUJITSU_LAPTOP=20is=20not=20set=0D=0A#=20CONFIG_F=
UJITSU_TABLET=20is=20not=20set=0D=0A#=20CONFIG_GPD_POCKET_FAN=20is=20not=20=
set=0D=0A#=20CONFIG_X86_PLATFORM_DRIVERS_HP=20is=20not=20set=0D=0A#=20CONFI=
G_WIRELESS_HOTKEY=20is=20not=20set=0D=0A#=20CONFIG_IBM_RTL=20is=20not=20set=
=0D=0A#=20CONFIG_SENSORS_HDAPS=20is=20not=20set=0D=0A#=20CONFIG_INTEL_ATOMI=
SP2_PM=20is=20not=20set=0D=0A#=20CONFIG_INTEL_IFS=20is=20not=20set=0D=0A#=
=20CONFIG_INTEL_SAR_INT1092=20is=20not=20set=0D=0A#=20CONFIG_INTEL_SKL_INT3=
472=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Intel=20Speed=20Select=20Technol=
ogy=20interface=20support=0D=0A#=0D=0A#=20CONFIG_INTEL_SPEED_SELECT_INTERFA=
CE=20is=20not=20set=0D=0A#=20end=20of=20Intel=20Speed=20Select=20Technology=
=20interface=20support=0D=0A=0D=0A#=20CONFIG_INTEL_WMI_SBL_FW_UPDATE=20is=
=20not=20set=0D=0A#=20CONFIG_INTEL_WMI_THUNDERBOLT=20is=20not=20set=0D=0A=
=0D=0A#=0D=0A#=20Intel=20Uncore=20Frequency=20Control=0D=0A#=0D=0A#=20CONFI=
G_INTEL_UNCORE_FREQ_CONTROL=20is=20not=20set=0D=0A#=20end=20of=20Intel=20Un=
core=20Frequency=20Control=0D=0A=0D=0A#=20CONFIG_INTEL_HID_EVENT=20is=20not=
=20set=0D=0A#=20CONFIG_INTEL_VBTN=20is=20not=20set=0D=0A#=20CONFIG_INTEL_IN=
T0002_VGPIO=20is=20not=20set=0D=0A#=20CONFIG_INTEL_OAKTRAIL=20is=20not=20se=
t=0D=0A#=20CONFIG_INTEL_BXTWC_PMIC_TMU=20is=20not=20set=0D=0ACONFIG_INTEL_C=
HTWC_INT33FE=3Dy=0D=0ACONFIG_INTEL_ISHTP_ECLITE=3Dy=0D=0A#=20CONFIG_INTEL_P=
UNIT_IPC=20is=20not=20set=0D=0A#=20CONFIG_INTEL_RST=20is=20not=20set=0D=0A#=
=20CONFIG_INTEL_SMARTCONNECT=20is=20not=20set=0D=0A#=20CONFIG_INTEL_TURBO_M=
AX_3=20is=20not=20set=0D=0A#=20CONFIG_INTEL_VSEC=20is=20not=20set=0D=0A#=20=
CONFIG_IDEAPAD_LAPTOP=20is=20not=20set=0D=0A#=20CONFIG_LENOVO_WMI_HOTKEY_UT=
ILITIES=20is=20not=20set=0D=0A#=20CONFIG_LENOVO_WMI_CAMERA=20is=20not=20set=
=0D=0A#=20CONFIG_THINKPAD_ACPI=20is=20not=20set=0D=0A#=20CONFIG_THINKPAD_LM=
I=20is=20not=20set=0D=0A#=20CONFIG_YOGABOOK=20is=20not=20set=0D=0A#=20CONFI=
G_YT2_1380=20is=20not=20set=0D=0A#=20CONFIG_LENOVO_WMI_GAMEZONE=20is=20not=
=20set=0D=0A#=20CONFIG_LENOVO_WMI_TUNING=20is=20not=20set=0D=0A#=20CONFIG_A=
CPI_QUICKSTART=20is=20not=20set=0D=0A#=20CONFIG_MEEGOPAD_ANX7428=20is=20not=
=20set=0D=0A#=20CONFIG_MSI_EC=20is=20not=20set=0D=0A#=20CONFIG_MSI_LAPTOP=
=20is=20not=20set=0D=0A#=20CONFIG_MSI_WMI=20is=20not=20set=0D=0A#=20CONFIG_=
MSI_WMI_PLATFORM=20is=20not=20set=0D=0A#=20CONFIG_PCENGINES_APU2=20is=20not=
=20set=0D=0A#=20CONFIG_PORTWELL_EC=20is=20not=20set=0D=0A#=20CONFIG_BARCO_P=
50_GPIO=20is=20not=20set=0D=0A#=20CONFIG_SAMSUNG_GALAXYBOOK=20is=20not=20se=
t=0D=0A#=20CONFIG_SAMSUNG_LAPTOP=20is=20not=20set=0D=0A#=20CONFIG_SAMSUNG_Q=
10=20is=20not=20set=0D=0A#=20CONFIG_ACPI_TOSHIBA=20is=20not=20set=0D=0A#=20=
CONFIG_TOSHIBA_BT_RFKILL=20is=20not=20set=0D=0A#=20CONFIG_TOSHIBA_HAPS=20is=
=20not=20set=0D=0A#=20CONFIG_TOSHIBA_WMI=20is=20not=20set=0D=0A#=20CONFIG_A=
CPI_CMPC=20is=20not=20set=0D=0A#=20CONFIG_COMPAL_LAPTOP=20is=20not=20set=0D=
=0A#=20CONFIG_LG_LAPTOP=20is=20not=20set=0D=0A#=20CONFIG_PANASONIC_LAPTOP=
=20is=20not=20set=0D=0A#=20CONFIG_SONY_LAPTOP=20is=20not=20set=0D=0A#=20CON=
FIG_SYSTEM76_ACPI=20is=20not=20set=0D=0A#=20CONFIG_TOPSTAR_LAPTOP=20is=20no=
t=20set=0D=0A#=20CONFIG_SERIAL_MULTI_INSTANTIATE=20is=20not=20set=0D=0A#=20=
CONFIG_INSPUR_PLATFORM_PROFILE=20is=20not=20set=0D=0A#=20CONFIG_DASHARO_ACP=
I=20is=20not=20set=0D=0A#=20CONFIG_INTEL_IPS=20is=20not=20set=0D=0ACONFIG_I=
NTEL_SCU_IPC=3Dy=0D=0A#=20CONFIG_INTEL_SCU_PCI=20is=20not=20set=0D=0A#=20CO=
NFIG_INTEL_SCU_PLATFORM=20is=20not=20set=0D=0A#=20CONFIG_SIEMENS_SIMATIC_IP=
C=20is=20not=20set=0D=0A#=20CONFIG_SILICOM_PLATFORM=20is=20not=20set=0D=0A#=
=20CONFIG_WINMATE_FM07_KEYS=20is=20not=20set=0D=0A#=20CONFIG_OXP_EC=20is=20=
not=20set=0D=0A#=20CONFIG_TUXEDO_NB04_WMI_AB=20is=20not=20set=0D=0ACONFIG_P=
2SB=3Dy=0D=0ACONFIG_HAVE_CLK=3Dy=0D=0ACONFIG_HAVE_CLK_PREPARE=3Dy=0D=0ACONF=
IG_COMMON_CLK=3Dy=0D=0A#=20CONFIG_LMK04832=20is=20not=20set=0D=0A#=20CONFIG=
_COMMON_CLK_MAX9485=20is=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_SI5341=20is=
=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_SI5351=20is=20not=20set=0D=0A#=20CO=
NFIG_COMMON_CLK_SI514=20is=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_SI544=20i=
s=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_SI570=20is=20not=20set=0D=0A#=20CO=
NFIG_COMMON_CLK_CDCE706=20is=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_CDCE925=
=20is=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_CS2000_CP=20is=20not=20set=0D=
=0A#=20CONFIG_CLK_TWL=20is=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_AXI_CLKGE=
N=20is=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_RS9_PCIE=20is=20not=20set=0D=
=0A#=20CONFIG_COMMON_CLK_SI521XX=20is=20not=20set=0D=0A#=20CONFIG_COMMON_CL=
K_VC3=20is=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_VC5=20is=20not=20set=0D=
=0A#=20CONFIG_COMMON_CLK_VC7=20is=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_FI=
XED_MMIO=20is=20not=20set=0D=0A#=20CONFIG_CLK_LGM_CGU=20is=20not=20set=0D=
=0A#=20CONFIG_XILINX_VCU=20is=20not=20set=0D=0A#=20CONFIG_COMMON_CLK_XLNX_C=
LKWZRD=20is=20not=20set=0D=0A#=20CONFIG_HWSPINLOCK=20is=20not=20set=0D=0A=
=0D=0A#=0D=0A#=20Clock=20Source=20drivers=0D=0A#=0D=0ACONFIG_CLKEVT_I8253=
=3Dy=0D=0ACONFIG_I8253_LOCK=3Dy=0D=0ACONFIG_CLKBLD_I8253=3Dy=0D=0A#=20end=
=20of=20Clock=20Source=20drivers=0D=0A=0D=0ACONFIG_MAILBOX=3Dy=0D=0A#=20CON=
FIG_PLATFORM_MHU=20is=20not=20set=0D=0ACONFIG_PCC=3Dy=0D=0A#=20CONFIG_ALTER=
A_MBOX=20is=20not=20set=0D=0A#=20CONFIG_MAILBOX_TEST=20is=20not=20set=0D=0A=
CONFIG_IOMMU_IOVA=3Dy=0D=0ACONFIG_IOMMU_API=3Dy=0D=0ACONFIG_IOMMU_SUPPORT=
=3Dy=0D=0A=0D=0A#=0D=0A#=20Generic=20IOMMU=20Pagetable=20Support=0D=0A#=0D=
=0ACONFIG_IOMMU_IO_PGTABLE=3Dy=0D=0A#=20end=20of=20Generic=20IOMMU=20Pageta=
ble=20Support=0D=0A=0D=0A#=20CONFIG_IOMMU_DEBUGFS=20is=20not=20set=0D=0A#=
=20CONFIG_IOMMU_DEFAULT_DMA_STRICT=20is=20not=20set=0D=0ACONFIG_IOMMU_DEFAU=
LT_DMA_LAZY=3Dy=0D=0A#=20CONFIG_IOMMU_DEFAULT_PASSTHROUGH=20is=20not=20set=
=0D=0ACONFIG_OF_IOMMU=3Dy=0D=0ACONFIG_IOMMU_DMA=3Dy=0D=0ACONFIG_IOMMU_SVA=
=3Dy=0D=0ACONFIG_IOMMU_IOPF=3Dy=0D=0ACONFIG_AMD_IOMMU=3Dy=0D=0ACONFIG_DMAR_=
TABLE=3Dy=0D=0ACONFIG_INTEL_IOMMU=3Dy=0D=0A#=20CONFIG_INTEL_IOMMU_SVM=20is=
=20not=20set=0D=0A#=20CONFIG_INTEL_IOMMU_DEFAULT_ON=20is=20not=20set=0D=0AC=
ONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy=0D=0ACONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAU=
LT_ON=3Dy=0D=0ACONFIG_INTEL_IOMMU_PERF_EVENTS=3Dy=0D=0A#=20CONFIG_IOMMUFD=
=20is=20not=20set=0D=0A#=20CONFIG_IRQ_REMAP=20is=20not=20set=0D=0A#=20CONFI=
G_VIRTIO_IOMMU=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Remoteproc=20drivers=
=0D=0A#=0D=0A#=20CONFIG_REMOTEPROC=20is=20not=20set=0D=0A#=20end=20of=20Rem=
oteproc=20drivers=0D=0A=0D=0A#=0D=0A#=20Rpmsg=20drivers=0D=0A#=0D=0A#=20CON=
FIG_RPMSG_QCOM_GLINK_RPM=20is=20not=20set=0D=0A#=20CONFIG_RPMSG_VIRTIO=20is=
=20not=20set=0D=0A#=20end=20of=20Rpmsg=20drivers=0D=0A=0D=0ACONFIG_SOUNDWIR=
E=3Dy=0D=0A=0D=0A#=0D=0A#=20SoundWire=20Devices=0D=0A#=0D=0A#=20CONFIG_SOUN=
DWIRE_AMD=20is=20not=20set=0D=0A#=20CONFIG_SOUNDWIRE_INTEL=20is=20not=20set=
=0D=0A#=20CONFIG_SOUNDWIRE_QCOM=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20SOC=
=20(System=20On=20Chip)=20specific=20Drivers=0D=0A#=0D=0A=0D=0A#=0D=0A#=20A=
mlogic=20SoC=20drivers=0D=0A#=0D=0A#=20end=20of=20Amlogic=20SoC=20drivers=
=0D=0A=0D=0A#=0D=0A#=20Broadcom=20SoC=20drivers=0D=0A#=0D=0A#=20end=20of=20=
Broadcom=20SoC=20drivers=0D=0A=0D=0A#=0D=0A#=20NXP/Freescale=20QorIQ=20SoC=
=20drivers=0D=0A#=0D=0A#=20end=20of=20NXP/Freescale=20QorIQ=20SoC=20drivers=
=0D=0A=0D=0A#=0D=0A#=20fujitsu=20SoC=20drivers=0D=0A#=0D=0A#=20end=20of=20f=
ujitsu=20SoC=20drivers=0D=0A=0D=0A#=0D=0A#=20i=2EMX=20SoC=20drivers=0D=0A#=
=0D=0A#=20end=20of=20i=2EMX=20SoC=20drivers=0D=0A=0D=0A#=0D=0A#=20Enable=20=
LiteX=20SoC=20Builder=20specific=20drivers=0D=0A#=0D=0A#=20CONFIG_LITEX_SOC=
_CONTROLLER=20is=20not=20set=0D=0A#=20end=20of=20Enable=20LiteX=20SoC=20Bui=
lder=20specific=20drivers=0D=0A=0D=0A#=20CONFIG_WPCM450_SOC=20is=20not=20se=
t=0D=0A=0D=0A#=0D=0A#=20Qualcomm=20SoC=20drivers=0D=0A#=0D=0A#=20end=20of=
=20Qualcomm=20SoC=20drivers=0D=0A=0D=0A#=20CONFIG_SOC_TI=20is=20not=20set=
=0D=0A=0D=0A#=0D=0A#=20Xilinx=20SoC=20drivers=0D=0A#=0D=0A#=20end=20of=20Xi=
linx=20SoC=20drivers=0D=0A#=20end=20of=20SOC=20(System=20On=20Chip)=20speci=
fic=20Drivers=0D=0A=0D=0A#=0D=0A#=20PM=20Domains=0D=0A#=0D=0A=0D=0A#=0D=0A#=
=20Amlogic=20PM=20Domains=0D=0A#=0D=0A#=20end=20of=20Amlogic=20PM=20Domains=
=0D=0A=0D=0A#=0D=0A#=20Broadcom=20PM=20Domains=0D=0A#=0D=0A#=20end=20of=20B=
roadcom=20PM=20Domains=0D=0A=0D=0A#=0D=0A#=20i=2EMX=20PM=20Domains=0D=0A#=
=0D=0A#=20end=20of=20i=2EMX=20PM=20Domains=0D=0A=0D=0A#=0D=0A#=20Qualcomm=
=20PM=20Domains=0D=0A#=0D=0A#=20end=20of=20Qualcomm=20PM=20Domains=0D=0A#=
=20end=20of=20PM=20Domains=0D=0A=0D=0A#=20CONFIG_PM_DEVFREQ=20is=20not=20se=
t=0D=0ACONFIG_EXTCON=3Dy=0D=0A=0D=0A#=0D=0A#=20Extcon=20Device=20Drivers=0D=
=0A#=0D=0A#=20CONFIG_EXTCON_ADC_JACK=20is=20not=20set=0D=0A#=20CONFIG_EXTCO=
N_FSA9480=20is=20not=20set=0D=0A#=20CONFIG_EXTCON_GPIO=20is=20not=20set=0D=
=0A#=20CONFIG_EXTCON_INTEL_INT3496=20is=20not=20set=0D=0ACONFIG_EXTCON_INTE=
L_CHT_WC=3Dy=0D=0A#=20CONFIG_EXTCON_LC824206XA=20is=20not=20set=0D=0A#=20CO=
NFIG_EXTCON_MAX3355=20is=20not=20set=0D=0A#=20CONFIG_EXTCON_MAX14526=20is=
=20not=20set=0D=0ACONFIG_EXTCON_PTN5150=3Dy=0D=0A#=20CONFIG_EXTCON_RT8973A=
=20is=20not=20set=0D=0A#=20CONFIG_EXTCON_SM5502=20is=20not=20set=0D=0A#=20C=
ONFIG_EXTCON_USB_GPIO=20is=20not=20set=0D=0A#=20CONFIG_EXTCON_USBC_CROS_EC=
=20is=20not=20set=0D=0ACONFIG_EXTCON_USBC_TUSB320=3Dy=0D=0A#=20CONFIG_MEMOR=
Y=20is=20not=20set=0D=0ACONFIG_IIO=3Dy=0D=0ACONFIG_IIO_BUFFER=3Dy=0D=0A#=20=
CONFIG_IIO_BUFFER_CB=20is=20not=20set=0D=0A#=20CONFIG_IIO_BUFFER_DMA=20is=
=20not=20set=0D=0A#=20CONFIG_IIO_BUFFER_DMAENGINE=20is=20not=20set=0D=0A#=
=20CONFIG_IIO_BUFFER_HW_CONSUMER=20is=20not=20set=0D=0ACONFIG_IIO_KFIFO_BUF=
=3Dy=0D=0ACONFIG_IIO_TRIGGERED_BUFFER=3Dy=0D=0A#=20CONFIG_IIO_CONFIGFS=20is=
=20not=20set=0D=0ACONFIG_IIO_TRIGGER=3Dy=0D=0ACONFIG_IIO_CONSUMERS_PER_TRIG=
GER=3D2=0D=0A#=20CONFIG_IIO_SW_DEVICE=20is=20not=20set=0D=0A#=20CONFIG_IIO_=
SW_TRIGGER=20is=20not=20set=0D=0A#=20CONFIG_IIO_TRIGGERED_EVENT=20is=20not=
=20set=0D=0A=0D=0A#=0D=0A#=20Accelerometers=0D=0A#=0D=0A#=20CONFIG_ADIS1620=
1=20is=20not=20set=0D=0A#=20CONFIG_ADIS16209=20is=20not=20set=0D=0A#=20CONF=
IG_ADXL313_I2C=20is=20not=20set=0D=0A#=20CONFIG_ADXL313_SPI=20is=20not=20se=
t=0D=0A#=20CONFIG_ADXL345_I2C=20is=20not=20set=0D=0A#=20CONFIG_ADXL345_SPI=
=20is=20not=20set=0D=0A#=20CONFIG_ADXL355_I2C=20is=20not=20set=0D=0A#=20CON=
FIG_ADXL355_SPI=20is=20not=20set=0D=0A#=20CONFIG_ADXL367_SPI=20is=20not=20s=
et=0D=0A#=20CONFIG_ADXL367_I2C=20is=20not=20set=0D=0A#=20CONFIG_ADXL372_SPI=
=20is=20not=20set=0D=0A#=20CONFIG_ADXL372_I2C=20is=20not=20set=0D=0A#=20CON=
FIG_ADXL380_SPI=20is=20not=20set=0D=0A#=20CONFIG_ADXL380_I2C=20is=20not=20s=
et=0D=0A#=20CONFIG_BMA180=20is=20not=20set=0D=0A#=20CONFIG_BMA220=20is=20no=
t=20set=0D=0A#=20CONFIG_BMA400=20is=20not=20set=0D=0A#=20CONFIG_BMC150_ACCE=
L=20is=20not=20set=0D=0A#=20CONFIG_BMI088_ACCEL=20is=20not=20set=0D=0A#=20C=
ONFIG_DA280=20is=20not=20set=0D=0A#=20CONFIG_DA311=20is=20not=20set=0D=0A#=
=20CONFIG_DMARD06=20is=20not=20set=0D=0A#=20CONFIG_DMARD09=20is=20not=20set=
=0D=0A#=20CONFIG_DMARD10=20is=20not=20set=0D=0A#=20CONFIG_FXLS8962AF_I2C=20=
is=20not=20set=0D=0A#=20CONFIG_FXLS8962AF_SPI=20is=20not=20set=0D=0ACONFIG_=
HID_SENSOR_ACCEL_3D=3Dy=0D=0A#=20CONFIG_IIO_ST_ACCEL_3AXIS=20is=20not=20set=
=0D=0A#=20CONFIG_IIO_KX022A_SPI=20is=20not=20set=0D=0A#=20CONFIG_IIO_KX022A=
_I2C=20is=20not=20set=0D=0A#=20CONFIG_KXSD9=20is=20not=20set=0D=0A#=20CONFI=
G_KXCJK1013=20is=20not=20set=0D=0A#=20CONFIG_MC3230=20is=20not=20set=0D=0A#=
=20CONFIG_MMA7455_I2C=20is=20not=20set=0D=0A#=20CONFIG_MMA7455_SPI=20is=20n=
ot=20set=0D=0A#=20CONFIG_MMA7660=20is=20not=20set=0D=0A#=20CONFIG_MMA8452=
=20is=20not=20set=0D=0A#=20CONFIG_MMA9551=20is=20not=20set=0D=0A#=20CONFIG_=
MMA9553=20is=20not=20set=0D=0A#=20CONFIG_MSA311=20is=20not=20set=0D=0A#=20C=
ONFIG_MXC4005=20is=20not=20set=0D=0A#=20CONFIG_MXC6255=20is=20not=20set=0D=
=0A#=20CONFIG_SCA3000=20is=20not=20set=0D=0A#=20CONFIG_SCA3300=20is=20not=
=20set=0D=0A#=20CONFIG_STK8312=20is=20not=20set=0D=0A#=20CONFIG_STK8BA50=20=
is=20not=20set=0D=0A#=20end=20of=20Accelerometers=0D=0A=0D=0A#=0D=0A#=20Ana=
log=20to=20digital=20converters=0D=0A#=0D=0A#=20CONFIG_AD4000=20is=20not=20=
set=0D=0A#=20CONFIG_AD4030=20is=20not=20set=0D=0A#=20CONFIG_AD4080=20is=20n=
ot=20set=0D=0A#=20CONFIG_AD4130=20is=20not=20set=0D=0A#=20CONFIG_AD4170_4=
=20is=20not=20set=0D=0A#=20CONFIG_AD4695=20is=20not=20set=0D=0A#=20CONFIG_A=
D7091R5=20is=20not=20set=0D=0A#=20CONFIG_AD7091R8=20is=20not=20set=0D=0A#=
=20CONFIG_AD7124=20is=20not=20set=0D=0A#=20CONFIG_AD7173=20is=20not=20set=
=0D=0A#=20CONFIG_AD7191=20is=20not=20set=0D=0A#=20CONFIG_AD7192=20is=20not=
=20set=0D=0A#=20CONFIG_AD7266=20is=20not=20set=0D=0A#=20CONFIG_AD7280=20is=
=20not=20set=0D=0A#=20CONFIG_AD7291=20is=20not=20set=0D=0A#=20CONFIG_AD7292=
=20is=20not=20set=0D=0A#=20CONFIG_AD7298=20is=20not=20set=0D=0A#=20CONFIG_A=
D7380=20is=20not=20set=0D=0A#=20CONFIG_AD7476=20is=20not=20set=0D=0A#=20CON=
FIG_AD7606_IFACE_PARALLEL=20is=20not=20set=0D=0A#=20CONFIG_AD7606_IFACE_SPI=
=20is=20not=20set=0D=0A#=20CONFIG_AD7766=20is=20not=20set=0D=0A#=20CONFIG_A=
D7768_1=20is=20not=20set=0D=0A#=20CONFIG_AD7779=20is=20not=20set=0D=0A#=20C=
ONFIG_AD7780=20is=20not=20set=0D=0A#=20CONFIG_AD7791=20is=20not=20set=0D=0A=
#=20CONFIG_AD7793=20is=20not=20set=0D=0A#=20CONFIG_AD7887=20is=20not=20set=
=0D=0A#=20CONFIG_AD7923=20is=20not=20set=0D=0A#=20CONFIG_AD7944=20is=20not=
=20set=0D=0A#=20CONFIG_AD7949=20is=20not=20set=0D=0A#=20CONFIG_AD799X=20is=
=20not=20set=0D=0A#=20CONFIG_AD9467=20is=20not=20set=0D=0A#=20CONFIG_ADE900=
0=20is=20not=20set=0D=0A#=20CONFIG_CC10001_ADC=20is=20not=20set=0D=0ACONFIG=
_DLN2_ADC=3Dy=0D=0A#=20CONFIG_ENVELOPE_DETECTOR=20is=20not=20set=0D=0A#=20C=
ONFIG_GEHC_PMC_ADC=20is=20not=20set=0D=0A#=20CONFIG_HI8435=20is=20not=20set=
=0D=0A#=20CONFIG_HX711=20is=20not=20set=0D=0A#=20CONFIG_INA2XX_ADC=20is=20n=
ot=20set=0D=0A#=20CONFIG_LTC2309=20is=20not=20set=0D=0A#=20CONFIG_LTC2471=
=20is=20not=20set=0D=0A#=20CONFIG_LTC2485=20is=20not=20set=0D=0A#=20CONFIG_=
LTC2496=20is=20not=20set=0D=0A#=20CONFIG_LTC2497=20is=20not=20set=0D=0A#=20=
CONFIG_MAX1027=20is=20not=20set=0D=0A#=20CONFIG_MAX11100=20is=20not=20set=
=0D=0A#=20CONFIG_MAX1118=20is=20not=20set=0D=0A#=20CONFIG_MAX11205=20is=20n=
ot=20set=0D=0A#=20CONFIG_MAX11410=20is=20not=20set=0D=0A#=20CONFIG_MAX1241=
=20is=20not=20set=0D=0A#=20CONFIG_MAX1363=20is=20not=20set=0D=0A#=20CONFIG_=
MAX34408=20is=20not=20set=0D=0A#=20CONFIG_MAX9611=20is=20not=20set=0D=0A#=
=20CONFIG_MCP320X=20is=20not=20set=0D=0A#=20CONFIG_MCP3422=20is=20not=20set=
=0D=0A#=20CONFIG_MCP3564=20is=20not=20set=0D=0A#=20CONFIG_MCP3911=20is=20no=
t=20set=0D=0A#=20CONFIG_MEDIATEK_MT6360_ADC=20is=20not=20set=0D=0A#=20CONFI=
G_MEDIATEK_MT6370_ADC=20is=20not=20set=0D=0A#=20CONFIG_NAU7802=20is=20not=
=20set=0D=0A#=20CONFIG_NCT7201=20is=20not=20set=0D=0A#=20CONFIG_PAC1921=20i=
s=20not=20set=0D=0A#=20CONFIG_PAC1934=20is=20not=20set=0D=0A#=20CONFIG_ROHM=
_BD79112=20is=20not=20set=0D=0A#=20CONFIG_ROHM_BD79124=20is=20not=20set=0D=
=0A#=20CONFIG_RICHTEK_RTQ6056=20is=20not=20set=0D=0A#=20CONFIG_SD_ADC_MODUL=
ATOR=20is=20not=20set=0D=0A#=20CONFIG_TI_ADC081C=20is=20not=20set=0D=0A#=20=
CONFIG_TI_ADC0832=20is=20not=20set=0D=0A#=20CONFIG_TI_ADC084S021=20is=20not=
=20set=0D=0A#=20CONFIG_TI_ADC108S102=20is=20not=20set=0D=0A#=20CONFIG_TI_AD=
C12138=20is=20not=20set=0D=0A#=20CONFIG_TI_ADC128S052=20is=20not=20set=0D=
=0A#=20CONFIG_TI_ADC161S626=20is=20not=20set=0D=0A#=20CONFIG_TI_ADS1015=20i=
s=20not=20set=0D=0A#=20CONFIG_TI_ADS1100=20is=20not=20set=0D=0A#=20CONFIG_T=
I_ADS1119=20is=20not=20set=0D=0A#=20CONFIG_TI_ADS124S08=20is=20not=20set=0D=
=0A#=20CONFIG_TI_ADS1298=20is=20not=20set=0D=0A#=20CONFIG_TI_ADS131E08=20is=
=20not=20set=0D=0A#=20CONFIG_TI_ADS7138=20is=20not=20set=0D=0A#=20CONFIG_TI=
_ADS7924=20is=20not=20set=0D=0A#=20CONFIG_TI_ADS7950=20is=20not=20set=0D=0A=
#=20CONFIG_TI_ADS8344=20is=20not=20set=0D=0A#=20CONFIG_TI_ADS8688=20is=20no=
t=20set=0D=0A#=20CONFIG_TI_LMP92064=20is=20not=20set=0D=0A#=20CONFIG_TI_TLC=
4541=20is=20not=20set=0D=0A#=20CONFIG_TI_TSC2046=20is=20not=20set=0D=0A#=20=
CONFIG_TWL4030_MADC=20is=20not=20set=0D=0A#=20CONFIG_TWL6030_GPADC=20is=20n=
ot=20set=0D=0A#=20CONFIG_VF610_ADC=20is=20not=20set=0D=0ACONFIG_VIPERBOARD_=
ADC=3Dy=0D=0A#=20CONFIG_XILINX_XADC=20is=20not=20set=0D=0A#=20end=20of=20An=
alog=20to=20digital=20converters=0D=0A=0D=0A#=0D=0A#=20Analog=20to=20digita=
l=20and=20digital=20to=20analog=20converters=0D=0A#=0D=0A#=20CONFIG_AD74115=
=20is=20not=20set=0D=0A#=20CONFIG_AD74413R=20is=20not=20set=0D=0A#=20end=20=
of=20Analog=20to=20digital=20and=20digital=20to=20analog=20converters=0D=0A=
=0D=0A#=0D=0A#=20Analog=20Front=20Ends=0D=0A#=0D=0A#=20CONFIG_IIO_RESCALE=
=20is=20not=20set=0D=0A#=20end=20of=20Analog=20Front=20Ends=0D=0A=0D=0A#=0D=
=0A#=20Amplifiers=0D=0A#=0D=0A#=20CONFIG_AD8366=20is=20not=20set=0D=0A#=20C=
ONFIG_ADA4250=20is=20not=20set=0D=0A#=20CONFIG_HMC425=20is=20not=20set=0D=
=0A#=20end=20of=20Amplifiers=0D=0A=0D=0A#=0D=0A#=20Capacitance=20to=20digit=
al=20converters=0D=0A#=0D=0A#=20CONFIG_AD7150=20is=20not=20set=0D=0A#=20CON=
FIG_AD7746=20is=20not=20set=0D=0A#=20end=20of=20Capacitance=20to=20digital=
=20converters=0D=0A=0D=0A#=0D=0A#=20Chemical=20Sensors=0D=0A#=0D=0A#=20CONF=
IG_AOSONG_AGS02MA=20is=20not=20set=0D=0A#=20CONFIG_ATLAS_PH_SENSOR=20is=20n=
ot=20set=0D=0A#=20CONFIG_ATLAS_EZO_SENSOR=20is=20not=20set=0D=0A#=20CONFIG_=
BME680=20is=20not=20set=0D=0A#=20CONFIG_CCS811=20is=20not=20set=0D=0A#=20CO=
NFIG_ENS160=20is=20not=20set=0D=0A#=20CONFIG_IAQCORE=20is=20not=20set=0D=0A=
#=20CONFIG_MHZ19B=20is=20not=20set=0D=0A#=20CONFIG_PMS7003=20is=20not=20set=
=0D=0A#=20CONFIG_SCD30_CORE=20is=20not=20set=0D=0A#=20CONFIG_SCD4X=20is=20n=
ot=20set=0D=0A#=20CONFIG_SEN0322=20is=20not=20set=0D=0A#=20CONFIG_SENSIRION=
_SGP30=20is=20not=20set=0D=0A#=20CONFIG_SENSIRION_SGP40=20is=20not=20set=0D=
=0A#=20CONFIG_SPS30_I2C=20is=20not=20set=0D=0A#=20CONFIG_SPS30_SERIAL=20is=
=20not=20set=0D=0A#=20CONFIG_SENSEAIR_SUNRISE_CO2=20is=20not=20set=0D=0A#=
=20CONFIG_VZ89X=20is=20not=20set=0D=0A#=20end=20of=20Chemical=20Sensors=0D=
=0A=0D=0A#=0D=0A#=20Hid=20Sensor=20IIO=20Common=0D=0A#=0D=0ACONFIG_HID_SENS=
OR_IIO_COMMON=3Dy=0D=0ACONFIG_HID_SENSOR_IIO_TRIGGER=3Dy=0D=0A#=20end=20of=
=20Hid=20Sensor=20IIO=20Common=0D=0A=0D=0A#=0D=0A#=20IIO=20SCMI=20Sensors=
=0D=0A#=0D=0A#=20end=20of=20IIO=20SCMI=20Sensors=0D=0A=0D=0A#=0D=0A#=20SSP=
=20Sensor=20Common=0D=0A#=0D=0A#=20CONFIG_IIO_SSP_SENSORHUB=20is=20not=20se=
t=0D=0A#=20end=20of=20SSP=20Sensor=20Common=0D=0A=0D=0A#=0D=0A#=20Digital=
=20to=20analog=20converters=0D=0A#=0D=0A#=20CONFIG_AD3530R=20is=20not=20set=
=0D=0A#=20CONFIG_AD3552R_HS=20is=20not=20set=0D=0A#=20CONFIG_AD3552R=20is=
=20not=20set=0D=0A#=20CONFIG_AD5064=20is=20not=20set=0D=0A#=20CONFIG_AD5360=
=20is=20not=20set=0D=0A#=20CONFIG_AD5380=20is=20not=20set=0D=0A#=20CONFIG_A=
D5421=20is=20not=20set=0D=0A#=20CONFIG_AD5446=20is=20not=20set=0D=0A#=20CON=
FIG_AD5449=20is=20not=20set=0D=0A#=20CONFIG_AD5592R=20is=20not=20set=0D=0A#=
=20CONFIG_AD5593R=20is=20not=20set=0D=0A#=20CONFIG_AD5504=20is=20not=20set=
=0D=0A#=20CONFIG_AD5624R_SPI=20is=20not=20set=0D=0A#=20CONFIG_AD9739A=20is=
=20not=20set=0D=0A#=20CONFIG_LTC2688=20is=20not=20set=0D=0A#=20CONFIG_AD568=
6_SPI=20is=20not=20set=0D=0A#=20CONFIG_AD5696_I2C=20is=20not=20set=0D=0A#=
=20CONFIG_AD5755=20is=20not=20set=0D=0A#=20CONFIG_AD5758=20is=20not=20set=
=0D=0A#=20CONFIG_AD5761=20is=20not=20set=0D=0A#=20CONFIG_AD5764=20is=20not=
=20set=0D=0A#=20CONFIG_AD5766=20is=20not=20set=0D=0A#=20CONFIG_AD5770R=20is=
=20not=20set=0D=0A#=20CONFIG_AD5791=20is=20not=20set=0D=0A#=20CONFIG_AD7293=
=20is=20not=20set=0D=0A#=20CONFIG_AD7303=20is=20not=20set=0D=0A#=20CONFIG_A=
D8460=20is=20not=20set=0D=0A#=20CONFIG_AD8801=20is=20not=20set=0D=0A#=20CON=
FIG_BD79703=20is=20not=20set=0D=0A#=20CONFIG_DPOT_DAC=20is=20not=20set=0D=
=0A#=20CONFIG_DS4424=20is=20not=20set=0D=0A#=20CONFIG_LTC1660=20is=20not=20=
set=0D=0A#=20CONFIG_LTC2632=20is=20not=20set=0D=0A#=20CONFIG_LTC2664=20is=
=20not=20set=0D=0A#=20CONFIG_M62332=20is=20not=20set=0D=0A#=20CONFIG_MAX517=
=20is=20not=20set=0D=0A#=20CONFIG_MAX5522=20is=20not=20set=0D=0A#=20CONFIG_=
MAX5821=20is=20not=20set=0D=0A#=20CONFIG_MCP4725=20is=20not=20set=0D=0A#=20=
CONFIG_MCP4728=20is=20not=20set=0D=0A#=20CONFIG_MCP4821=20is=20not=20set=0D=
=0A#=20CONFIG_MCP4922=20is=20not=20set=0D=0A#=20CONFIG_TI_DAC082S085=20is=
=20not=20set=0D=0A#=20CONFIG_TI_DAC5571=20is=20not=20set=0D=0A#=20CONFIG_TI=
_DAC7311=20is=20not=20set=0D=0A#=20CONFIG_TI_DAC7612=20is=20not=20set=0D=0A=
#=20CONFIG_VF610_DAC=20is=20not=20set=0D=0A#=20end=20of=20Digital=20to=20an=
alog=20converters=0D=0A=0D=0A#=0D=0A#=20IIO=20dummy=20driver=0D=0A#=0D=0A#=
=20end=20of=20IIO=20dummy=20driver=0D=0A=0D=0A#=0D=0A#=20Filters=0D=0A#=0D=
=0A#=20CONFIG_ADMV8818=20is=20not=20set=0D=0A#=20end=20of=20Filters=0D=0A=
=0D=0A#=0D=0A#=20Frequency=20Synthesizers=20DDS/PLL=0D=0A#=0D=0A=0D=0A#=0D=
=0A#=20Clock=20Generator/Distribution=0D=0A#=0D=0A#=20CONFIG_AD9523=20is=20=
not=20set=0D=0A#=20end=20of=20Clock=20Generator/Distribution=0D=0A=0D=0A#=
=0D=0A#=20Phase-Locked=20Loop=20(PLL)=20frequency=20synthesizers=0D=0A#=0D=
=0A#=20CONFIG_ADF4350=20is=20not=20set=0D=0A#=20CONFIG_ADF4371=20is=20not=
=20set=0D=0A#=20CONFIG_ADF4377=20is=20not=20set=0D=0A#=20CONFIG_ADMFM2000=
=20is=20not=20set=0D=0A#=20CONFIG_ADMV1013=20is=20not=20set=0D=0A#=20CONFIG=
_ADMV1014=20is=20not=20set=0D=0A#=20CONFIG_ADMV4420=20is=20not=20set=0D=0A#=
=20CONFIG_ADRF6780=20is=20not=20set=0D=0A#=20end=20of=20Phase-Locked=20Loop=
=20(PLL)=20frequency=20synthesizers=0D=0A#=20end=20of=20Frequency=20Synthes=
izers=20DDS/PLL=0D=0A=0D=0A#=0D=0A#=20Digital=20gyroscope=20sensors=0D=0A#=
=0D=0A#=20CONFIG_ADIS16080=20is=20not=20set=0D=0A#=20CONFIG_ADIS16130=20is=
=20not=20set=0D=0A#=20CONFIG_ADIS16136=20is=20not=20set=0D=0A#=20CONFIG_ADI=
S16260=20is=20not=20set=0D=0A#=20CONFIG_ADXRS290=20is=20not=20set=0D=0A#=20=
CONFIG_ADXRS450=20is=20not=20set=0D=0A#=20CONFIG_BMG160=20is=20not=20set=0D=
=0A#=20CONFIG_FXAS21002C=20is=20not=20set=0D=0ACONFIG_HID_SENSOR_GYRO_3D=3D=
y=0D=0A#=20CONFIG_MPU3050_I2C=20is=20not=20set=0D=0A#=20CONFIG_IIO_ST_GYRO_=
3AXIS=20is=20not=20set=0D=0A#=20CONFIG_ITG3200=20is=20not=20set=0D=0A#=20en=
d=20of=20Digital=20gyroscope=20sensors=0D=0A=0D=0A#=0D=0A#=20Health=20Senso=
rs=0D=0A#=0D=0A=0D=0A#=0D=0A#=20Heart=20Rate=20Monitors=0D=0A#=0D=0A#=20CON=
FIG_AFE4403=20is=20not=20set=0D=0A#=20CONFIG_AFE4404=20is=20not=20set=0D=0A=
#=20CONFIG_MAX30100=20is=20not=20set=0D=0A#=20CONFIG_MAX30102=20is=20not=20=
set=0D=0A#=20end=20of=20Heart=20Rate=20Monitors=0D=0A#=20end=20of=20Health=
=20Sensors=0D=0A=0D=0A#=0D=0A#=20Humidity=20sensors=0D=0A#=0D=0A#=20CONFIG_=
AM2315=20is=20not=20set=0D=0A#=20CONFIG_DHT11=20is=20not=20set=0D=0A#=20CON=
FIG_ENS210=20is=20not=20set=0D=0A#=20CONFIG_HDC100X=20is=20not=20set=0D=0A#=
=20CONFIG_HDC2010=20is=20not=20set=0D=0A#=20CONFIG_HDC3020=20is=20not=20set=
=0D=0ACONFIG_HID_SENSOR_HUMIDITY=3Dy=0D=0A#=20CONFIG_HTS221=20is=20not=20se=
t=0D=0A#=20CONFIG_HTU21=20is=20not=20set=0D=0A#=20CONFIG_SI7005=20is=20not=
=20set=0D=0A#=20CONFIG_SI7020=20is=20not=20set=0D=0A#=20end=20of=20Humidity=
=20sensors=0D=0A=0D=0A#=0D=0A#=20Inertial=20measurement=20units=0D=0A#=0D=
=0A#=20CONFIG_ADIS16400=20is=20not=20set=0D=0A#=20CONFIG_ADIS16460=20is=20n=
ot=20set=0D=0A#=20CONFIG_ADIS16475=20is=20not=20set=0D=0A#=20CONFIG_ADIS164=
80=20is=20not=20set=0D=0A#=20CONFIG_ADIS16550=20is=20not=20set=0D=0A#=20CON=
FIG_BMI160_I2C=20is=20not=20set=0D=0A#=20CONFIG_BMI160_SPI=20is=20not=20set=
=0D=0A#=20CONFIG_BMI270_I2C=20is=20not=20set=0D=0A#=20CONFIG_BMI270_SPI=20i=
s=20not=20set=0D=0A#=20CONFIG_BMI323_I2C=20is=20not=20set=0D=0A#=20CONFIG_B=
MI323_SPI=20is=20not=20set=0D=0A#=20CONFIG_BOSCH_BNO055_SERIAL=20is=20not=
=20set=0D=0A#=20CONFIG_BOSCH_BNO055_I2C=20is=20not=20set=0D=0A#=20CONFIG_FX=
OS8700_I2C=20is=20not=20set=0D=0A#=20CONFIG_FXOS8700_SPI=20is=20not=20set=
=0D=0A#=20CONFIG_KMX61=20is=20not=20set=0D=0A#=20CONFIG_INV_ICM42600_I2C=20=
is=20not=20set=0D=0A#=20CONFIG_INV_ICM42600_SPI=20is=20not=20set=0D=0A#=20C=
ONFIG_INV_MPU6050_I2C=20is=20not=20set=0D=0A#=20CONFIG_INV_MPU6050_SPI=20is=
=20not=20set=0D=0A#=20CONFIG_SMI240=20is=20not=20set=0D=0A#=20CONFIG_IIO_ST=
_LSM6DSX=20is=20not=20set=0D=0A#=20CONFIG_IIO_ST_LSM9DS0=20is=20not=20set=
=0D=0A#=20end=20of=20Inertial=20measurement=20units=0D=0A=0D=0A#=0D=0A#=20L=
ight=20sensors=0D=0A#=0D=0A#=20CONFIG_ACPI_ALS=20is=20not=20set=0D=0A#=20CO=
NFIG_ADJD_S311=20is=20not=20set=0D=0A#=20CONFIG_ADUX1020=20is=20not=20set=
=0D=0A#=20CONFIG_AL3000A=20is=20not=20set=0D=0A#=20CONFIG_AL3010=20is=20not=
=20set=0D=0A#=20CONFIG_AL3320A=20is=20not=20set=0D=0A#=20CONFIG_APDS9160=20=
is=20not=20set=0D=0A#=20CONFIG_APDS9300=20is=20not=20set=0D=0A#=20CONFIG_AP=
DS9306=20is=20not=20set=0D=0A#=20CONFIG_APDS9960=20is=20not=20set=0D=0A#=20=
CONFIG_AS73211=20is=20not=20set=0D=0A#=20CONFIG_BH1745=20is=20not=20set=0D=
=0A#=20CONFIG_BH1750=20is=20not=20set=0D=0A#=20CONFIG_BH1780=20is=20not=20s=
et=0D=0A#=20CONFIG_CM32181=20is=20not=20set=0D=0A#=20CONFIG_CM3232=20is=20n=
ot=20set=0D=0A#=20CONFIG_CM3323=20is=20not=20set=0D=0A#=20CONFIG_CM3605=20i=
s=20not=20set=0D=0A#=20CONFIG_CM36651=20is=20not=20set=0D=0A#=20CONFIG_GP2A=
P002=20is=20not=20set=0D=0A#=20CONFIG_GP2AP020A00F=20is=20not=20set=0D=0A#=
=20CONFIG_SENSORS_ISL29018=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_ISL2902=
8=20is=20not=20set=0D=0A#=20CONFIG_ISL29125=20is=20not=20set=0D=0A#=20CONFI=
G_ISL76682=20is=20not=20set=0D=0ACONFIG_HID_SENSOR_ALS=3Dy=0D=0ACONFIG_HID_=
SENSOR_PROX=3Dy=0D=0A#=20CONFIG_JSA1212=20is=20not=20set=0D=0A#=20CONFIG_RO=
HM_BU27034=20is=20not=20set=0D=0A#=20CONFIG_RPR0521=20is=20not=20set=0D=0A#=
=20CONFIG_LTR390=20is=20not=20set=0D=0A#=20CONFIG_LTR501=20is=20not=20set=
=0D=0A#=20CONFIG_LTRF216A=20is=20not=20set=0D=0A#=20CONFIG_LV0104CS=20is=20=
not=20set=0D=0A#=20CONFIG_MAX44000=20is=20not=20set=0D=0A#=20CONFIG_MAX4400=
9=20is=20not=20set=0D=0A#=20CONFIG_NOA1305=20is=20not=20set=0D=0A#=20CONFIG=
_OPT3001=20is=20not=20set=0D=0A#=20CONFIG_OPT4001=20is=20not=20set=0D=0A#=
=20CONFIG_OPT4060=20is=20not=20set=0D=0A#=20CONFIG_PA12203001=20is=20not=20=
set=0D=0A#=20CONFIG_SI1133=20is=20not=20set=0D=0A#=20CONFIG_SI1145=20is=20n=
ot=20set=0D=0A#=20CONFIG_STK3310=20is=20not=20set=0D=0A#=20CONFIG_ST_UVIS25=
=20is=20not=20set=0D=0A#=20CONFIG_TCS3414=20is=20not=20set=0D=0A#=20CONFIG_=
TCS3472=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_TSL2563=20is=20not=20set=
=0D=0A#=20CONFIG_TSL2583=20is=20not=20set=0D=0A#=20CONFIG_TSL2591=20is=20no=
t=20set=0D=0A#=20CONFIG_TSL2772=20is=20not=20set=0D=0A#=20CONFIG_TSL4531=20=
is=20not=20set=0D=0A#=20CONFIG_US5182D=20is=20not=20set=0D=0A#=20CONFIG_VCN=
L4000=20is=20not=20set=0D=0A#=20CONFIG_VCNL4035=20is=20not=20set=0D=0A#=20C=
ONFIG_VEML3235=20is=20not=20set=0D=0A#=20CONFIG_VEML6030=20is=20not=20set=
=0D=0A#=20CONFIG_VEML6040=20is=20not=20set=0D=0A#=20CONFIG_VEML6046X00=20is=
=20not=20set=0D=0A#=20CONFIG_VEML6070=20is=20not=20set=0D=0A#=20CONFIG_VEML=
6075=20is=20not=20set=0D=0A#=20CONFIG_VL6180=20is=20not=20set=0D=0A#=20CONF=
IG_ZOPT2201=20is=20not=20set=0D=0A#=20end=20of=20Light=20sensors=0D=0A=0D=
=0A#=0D=0A#=20Magnetometer=20sensors=0D=0A#=0D=0A#=20CONFIG_AF8133J=20is=20=
not=20set=0D=0A#=20CONFIG_AK8974=20is=20not=20set=0D=0A#=20CONFIG_AK8975=20=
is=20not=20set=0D=0A#=20CONFIG_AK09911=20is=20not=20set=0D=0A#=20CONFIG_ALS=
31300=20is=20not=20set=0D=0A#=20CONFIG_BMC150_MAGN_I2C=20is=20not=20set=0D=
=0A#=20CONFIG_BMC150_MAGN_SPI=20is=20not=20set=0D=0A#=20CONFIG_MAG3110=20is=
=20not=20set=0D=0ACONFIG_HID_SENSOR_MAGNETOMETER_3D=3Dy=0D=0A#=20CONFIG_MMC=
35240=20is=20not=20set=0D=0A#=20CONFIG_IIO_ST_MAGN_3AXIS=20is=20not=20set=
=0D=0A#=20CONFIG_INFINEON_TLV493D=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_=
HMC5843_I2C=20is=20not=20set=0D=0A#=20CONFIG_SENSORS_HMC5843_SPI=20is=20not=
=20set=0D=0A#=20CONFIG_SENSORS_RM3100_I2C=20is=20not=20set=0D=0A#=20CONFIG_=
SENSORS_RM3100_SPI=20is=20not=20set=0D=0A#=20CONFIG_SI7210=20is=20not=20set=
=0D=0A#=20CONFIG_TI_TMAG5273=20is=20not=20set=0D=0A#=20CONFIG_YAMAHA_YAS530=
=20is=20not=20set=0D=0A#=20end=20of=20Magnetometer=20sensors=0D=0A=0D=0A#=
=0D=0A#=20Multiplexers=0D=0A#=0D=0A#=20CONFIG_IIO_MUX=20is=20not=20set=0D=
=0A#=20end=20of=20Multiplexers=0D=0A=0D=0A#=0D=0A#=20Inclinometer=20sensors=
=0D=0A#=0D=0ACONFIG_HID_SENSOR_INCLINOMETER_3D=3Dy=0D=0ACONFIG_HID_SENSOR_D=
EVICE_ROTATION=3Dy=0D=0A#=20end=20of=20Inclinometer=20sensors=0D=0A=0D=0A#=
=0D=0A#=20Triggers=20-=20standalone=0D=0A#=0D=0A#=20CONFIG_IIO_INTERRUPT_TR=
IGGER=20is=20not=20set=0D=0A#=20CONFIG_IIO_SYSFS_TRIGGER=20is=20not=20set=
=0D=0A#=20end=20of=20Triggers=20-=20standalone=0D=0A=0D=0A#=0D=0A#=20Linear=
=20and=20angular=20position=20sensors=0D=0A#=0D=0ACONFIG_HID_SENSOR_CUSTOM_=
INTEL_HINGE=3Dy=0D=0A#=20end=20of=20Linear=20and=20angular=20position=20sen=
sors=0D=0A=0D=0A#=0D=0A#=20Digital=20potentiometers=0D=0A#=0D=0A#=20CONFIG_=
AD5110=20is=20not=20set=0D=0A#=20CONFIG_AD5272=20is=20not=20set=0D=0A#=20CO=
NFIG_DS1803=20is=20not=20set=0D=0A#=20CONFIG_MAX5432=20is=20not=20set=0D=0A=
#=20CONFIG_MAX5481=20is=20not=20set=0D=0A#=20CONFIG_MAX5487=20is=20not=20se=
t=0D=0A#=20CONFIG_MCP4018=20is=20not=20set=0D=0A#=20CONFIG_MCP4131=20is=20n=
ot=20set=0D=0A#=20CONFIG_MCP4531=20is=20not=20set=0D=0A#=20CONFIG_MCP41010=
=20is=20not=20set=0D=0A#=20CONFIG_TPL0102=20is=20not=20set=0D=0A#=20CONFIG_=
X9250=20is=20not=20set=0D=0A#=20end=20of=20Digital=20potentiometers=0D=0A=
=0D=0A#=0D=0A#=20Digital=20potentiostats=0D=0A#=0D=0A#=20CONFIG_LMP91000=20=
is=20not=20set=0D=0A#=20end=20of=20Digital=20potentiostats=0D=0A=0D=0A#=0D=
=0A#=20Pressure=20sensors=0D=0A#=0D=0A#=20CONFIG_ABP060MG=20is=20not=20set=
=0D=0A#=20CONFIG_ROHM_BM1390=20is=20not=20set=0D=0A#=20CONFIG_BMP280=20is=
=20not=20set=0D=0A#=20CONFIG_DLHL60D=20is=20not=20set=0D=0A#=20CONFIG_DPS31=
0=20is=20not=20set=0D=0ACONFIG_HID_SENSOR_PRESS=3Dy=0D=0A#=20CONFIG_HP03=20=
is=20not=20set=0D=0A#=20CONFIG_HSC030PA=20is=20not=20set=0D=0A#=20CONFIG_IC=
P10100=20is=20not=20set=0D=0A#=20CONFIG_MPL115_I2C=20is=20not=20set=0D=0A#=
=20CONFIG_MPL115_SPI=20is=20not=20set=0D=0A#=20CONFIG_MPL3115=20is=20not=20=
set=0D=0A#=20CONFIG_MPRLS0025PA=20is=20not=20set=0D=0A#=20CONFIG_MS5611=20i=
s=20not=20set=0D=0A#=20CONFIG_MS5637=20is=20not=20set=0D=0A#=20CONFIG_SDP50=
0=20is=20not=20set=0D=0A#=20CONFIG_IIO_ST_PRESS=20is=20not=20set=0D=0A#=20C=
ONFIG_T5403=20is=20not=20set=0D=0A#=20CONFIG_HP206C=20is=20not=20set=0D=0A#=
=20CONFIG_ZPA2326=20is=20not=20set=0D=0A#=20end=20of=20Pressure=20sensors=
=0D=0A=0D=0A#=0D=0A#=20Lightning=20sensors=0D=0A#=0D=0A#=20CONFIG_AS3935=20=
is=20not=20set=0D=0A#=20end=20of=20Lightning=20sensors=0D=0A=0D=0A#=0D=0A#=
=20Proximity=20and=20distance=20sensors=0D=0A#=0D=0A#=20CONFIG_CROS_EC_MKBP=
_PROXIMITY=20is=20not=20set=0D=0A#=20CONFIG_D3323AA=20is=20not=20set=0D=0A#=
=20CONFIG_HX9023S=20is=20not=20set=0D=0A#=20CONFIG_IRSD200=20is=20not=20set=
=0D=0A#=20CONFIG_ISL29501=20is=20not=20set=0D=0A#=20CONFIG_LIDAR_LITE_V2=20=
is=20not=20set=0D=0A#=20CONFIG_MB1232=20is=20not=20set=0D=0A#=20CONFIG_PING=
=20is=20not=20set=0D=0A#=20CONFIG_RFD77402=20is=20not=20set=0D=0A#=20CONFIG=
_SRF04=20is=20not=20set=0D=0A#=20CONFIG_SX9310=20is=20not=20set=0D=0A#=20CO=
NFIG_SX9324=20is=20not=20set=0D=0A#=20CONFIG_SX9360=20is=20not=20set=0D=0A#=
=20CONFIG_SX9500=20is=20not=20set=0D=0A#=20CONFIG_SRF08=20is=20not=20set=0D=
=0A#=20CONFIG_VCNL3020=20is=20not=20set=0D=0A#=20CONFIG_VL53L0X_I2C=20is=20=
not=20set=0D=0A#=20CONFIG_AW96103=20is=20not=20set=0D=0A#=20end=20of=20Prox=
imity=20and=20distance=20sensors=0D=0A=0D=0A#=0D=0A#=20Resolver=20to=20digi=
tal=20converters=0D=0A#=0D=0A#=20CONFIG_AD2S90=20is=20not=20set=0D=0A#=20CO=
NFIG_AD2S1200=20is=20not=20set=0D=0A#=20CONFIG_AD2S1210=20is=20not=20set=0D=
=0A#=20end=20of=20Resolver=20to=20digital=20converters=0D=0A=0D=0A#=0D=0A#=
=20Temperature=20sensors=0D=0A#=0D=0A#=20CONFIG_LTC2983=20is=20not=20set=0D=
=0A#=20CONFIG_MAXIM_THERMOCOUPLE=20is=20not=20set=0D=0ACONFIG_HID_SENSOR_TE=
MP=3Dy=0D=0A#=20CONFIG_MLX90614=20is=20not=20set=0D=0A#=20CONFIG_MLX90632=
=20is=20not=20set=0D=0A#=20CONFIG_MLX90635=20is=20not=20set=0D=0A#=20CONFIG=
_TMP006=20is=20not=20set=0D=0A#=20CONFIG_TMP007=20is=20not=20set=0D=0A#=20C=
ONFIG_TMP117=20is=20not=20set=0D=0A#=20CONFIG_TSYS01=20is=20not=20set=0D=0A=
#=20CONFIG_TSYS02D=20is=20not=20set=0D=0A#=20CONFIG_MAX30208=20is=20not=20s=
et=0D=0A#=20CONFIG_MAX31856=20is=20not=20set=0D=0A#=20CONFIG_MAX31865=20is=
=20not=20set=0D=0A#=20CONFIG_MCP9600=20is=20not=20set=0D=0A#=20end=20of=20T=
emperature=20sensors=0D=0A=0D=0A#=20CONFIG_NTB=20is=20not=20set=0D=0A#=20CO=
NFIG_PWM=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20IRQ=20chip=20support=0D=0A#=
=0D=0ACONFIG_IRQCHIP=3Dy=0D=0ACONFIG_IRQ_MSI_LIB=3Dy=0D=0A#=20CONFIG_AL_FIC=
=20is=20not=20set=0D=0A#=20CONFIG_XILINX_INTC=20is=20not=20set=0D=0A#=20end=
=20of=20IRQ=20chip=20support=0D=0A=0D=0A#=20CONFIG_IPACK_BUS=20is=20not=20s=
et=0D=0ACONFIG_RESET_CONTROLLER=3Dy=0D=0A#=20CONFIG_RESET_GPIO=20is=20not=
=20set=0D=0A#=20CONFIG_RESET_INTEL_GW=20is=20not=20set=0D=0A#=20CONFIG_RESE=
T_SIMPLE=20is=20not=20set=0D=0A#=20CONFIG_RESET_TI_SYSCON=20is=20not=20set=
=0D=0A#=20CONFIG_RESET_TI_TPS380X=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20PH=
Y=20Subsystem=0D=0A#=0D=0ACONFIG_GENERIC_PHY=3Dy=0D=0ACONFIG_USB_LGM_PHY=3D=
y=0D=0A#=20CONFIG_PHY_CAN_TRANSCEIVER=20is=20not=20set=0D=0A#=20CONFIG_PHY_=
NXP_PTN3222=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20PHY=20drivers=20for=20Br=
oadcom=20platforms=0D=0A#=0D=0A#=20CONFIG_BCM_KONA_USB2_PHY=20is=20not=20se=
t=0D=0A#=20end=20of=20PHY=20drivers=20for=20Broadcom=20platforms=0D=0A=0D=
=0A#=20CONFIG_PHY_CADENCE_TORRENT=20is=20not=20set=0D=0A#=20CONFIG_PHY_CADE=
NCE_DPHY=20is=20not=20set=0D=0A#=20CONFIG_PHY_CADENCE_DPHY_RX=20is=20not=20=
set=0D=0A#=20CONFIG_PHY_CADENCE_SIERRA=20is=20not=20set=0D=0A#=20CONFIG_PHY=
_CADENCE_SALVO=20is=20not=20set=0D=0A#=20CONFIG_PHY_PXA_28NM_HSIC=20is=20no=
t=20set=0D=0A#=20CONFIG_PHY_PXA_28NM_USB2=20is=20not=20set=0D=0ACONFIG_PHY_=
CPCAP_USB=3Dy=0D=0A#=20CONFIG_PHY_MAPPHONE_MDM6600=20is=20not=20set=0D=0A#=
=20CONFIG_PHY_OCELOT_SERDES=20is=20not=20set=0D=0ACONFIG_PHY_QCOM_USB_HS=3D=
y=0D=0ACONFIG_PHY_QCOM_USB_HSIC=3Dy=0D=0ACONFIG_PHY_SAMSUNG_USB2=3Dy=0D=0AC=
ONFIG_PHY_TUSB1210=3Dy=0D=0A#=20CONFIG_PHY_INTEL_LGM_COMBO=20is=20not=20set=
=0D=0A#=20CONFIG_PHY_INTEL_LGM_EMMC=20is=20not=20set=0D=0A#=20end=20of=20PH=
Y=20Subsystem=0D=0A=0D=0A#=20CONFIG_POWERCAP=20is=20not=20set=0D=0A#=20CONF=
IG_MCB=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Performance=20monitor=20suppo=
rt=0D=0A#=0D=0A#=20CONFIG_DWC_PCIE_PMU=20is=20not=20set=0D=0A#=20end=20of=
=20Performance=20monitor=20support=0D=0A=0D=0ACONFIG_RAS=3Dy=0D=0A#=20CONFI=
G_USB4=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Android=0D=0A#=0D=0A#=20CONFI=
G_ANDROID_BINDER_IPC=20is=20not=20set=0D=0A#=20end=20of=20Android=0D=0A=0D=
=0A#=20CONFIG_LIBNVDIMM=20is=20not=20set=0D=0A#=20CONFIG_DAX=20is=20not=20s=
et=0D=0ACONFIG_NVMEM=3Dy=0D=0ACONFIG_NVMEM_SYSFS=3Dy=0D=0ACONFIG_NVMEM_LAYO=
UTS=3Dy=0D=0A=0D=0A#=0D=0A#=20Layout=20Types=0D=0A#=0D=0A#=20CONFIG_NVMEM_L=
AYOUT_SL28_VPD=20is=20not=20set=0D=0A#=20CONFIG_NVMEM_LAYOUT_ONIE_TLV=20is=
=20not=20set=0D=0A#=20CONFIG_NVMEM_LAYOUT_U_BOOT_ENV=20is=20not=20set=0D=0A=
#=20end=20of=20Layout=20Types=0D=0A=0D=0A#=20CONFIG_NVMEM_RMEM=20is=20not=
=20set=0D=0A=0D=0A#=0D=0A#=20HW=20tracing=20support=0D=0A#=0D=0A#=20CONFIG_=
STM=20is=20not=20set=0D=0A#=20CONFIG_INTEL_TH=20is=20not=20set=0D=0A#=20end=
=20of=20HW=20tracing=20support=0D=0A=0D=0A#=20CONFIG_FPGA=20is=20not=20set=
=0D=0A#=20CONFIG_FSI=20is=20not=20set=0D=0ACONFIG_TEE=3Dy=0D=0ACONFIG_AMDTE=
E=3Dy=0D=0A#=20CONFIG_SIOX=20is=20not=20set=0D=0A#=20CONFIG_SLIMBUS=20is=20=
not=20set=0D=0A#=20CONFIG_INTERCONNECT=20is=20not=20set=0D=0A#=20CONFIG_COU=
NTER=20is=20not=20set=0D=0ACONFIG_MOST=3Dy=0D=0ACONFIG_MOST_USB_HDM=3Dy=0D=
=0A#=20CONFIG_MOST_CDEV=20is=20not=20set=0D=0A#=20CONFIG_MOST_SND=20is=20no=
t=20set=0D=0A#=20CONFIG_PECI=20is=20not=20set=0D=0A#=20CONFIG_HTE=20is=20no=
t=20set=0D=0A#=20end=20of=20Device=20Drivers=0D=0A=0D=0A#=0D=0A#=20File=20s=
ystems=0D=0A#=0D=0ACONFIG_DCACHE_WORD_ACCESS=3Dy=0D=0A#=20CONFIG_VALIDATE_F=
S_PARSER=20is=20not=20set=0D=0ACONFIG_FS_IOMAP=3Dy=0D=0ACONFIG_BUFFER_HEAD=
=3Dy=0D=0ACONFIG_LEGACY_DIRECT_IO=3Dy=0D=0A#=20CONFIG_EXT2_FS=20is=20not=20=
set=0D=0ACONFIG_EXT4_FS=3Dy=0D=0ACONFIG_EXT4_USE_FOR_EXT2=3Dy=0D=0ACONFIG_E=
XT4_FS_POSIX_ACL=3Dy=0D=0ACONFIG_EXT4_FS_SECURITY=3Dy=0D=0A#=20CONFIG_EXT4_=
DEBUG=20is=20not=20set=0D=0ACONFIG_JBD2=3Dy=0D=0A#=20CONFIG_JBD2_DEBUG=20is=
=20not=20set=0D=0ACONFIG_FS_MBCACHE=3Dy=0D=0A#=20CONFIG_JFS_FS=20is=20not=
=20set=0D=0A#=20CONFIG_XFS_FS=20is=20not=20set=0D=0A#=20CONFIG_GFS2_FS=20is=
=20not=20set=0D=0A#=20CONFIG_OCFS2_FS=20is=20not=20set=0D=0A#=20CONFIG_BTRF=
S_FS=20is=20not=20set=0D=0A#=20CONFIG_NILFS2_FS=20is=20not=20set=0D=0A#=20C=
ONFIG_F2FS_FS=20is=20not=20set=0D=0ACONFIG_FS_POSIX_ACL=3Dy=0D=0ACONFIG_EXP=
ORTFS=3Dy=0D=0A#=20CONFIG_EXPORTFS_BLOCK_OPS=20is=20not=20set=0D=0ACONFIG_F=
ILE_LOCKING=3Dy=0D=0A#=20CONFIG_FS_ENCRYPTION=20is=20not=20set=0D=0A#=20CON=
FIG_FS_VERITY=20is=20not=20set=0D=0ACONFIG_FSNOTIFY=3Dy=0D=0ACONFIG_DNOTIFY=
=3Dy=0D=0ACONFIG_INOTIFY_USER=3Dy=0D=0A#=20CONFIG_FANOTIFY=20is=20not=20set=
=0D=0ACONFIG_QUOTA=3Dy=0D=0ACONFIG_QUOTA_NETLINK_INTERFACE=3Dy=0D=0A#=20CON=
FIG_QUOTA_DEBUG=20is=20not=20set=0D=0ACONFIG_QUOTA_TREE=3Dy=0D=0A#=20CONFIG=
_QFMT_V1=20is=20not=20set=0D=0ACONFIG_QFMT_V2=3Dy=0D=0ACONFIG_QUOTACTL=3Dy=
=0D=0ACONFIG_AUTOFS_FS=3Dy=0D=0A#=20CONFIG_FUSE_FS=20is=20not=20set=0D=0A#=
=20CONFIG_OVERLAY_FS=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Caches=0D=0A#=
=0D=0ACONFIG_NETFS_SUPPORT=3Dy=0D=0A#=20CONFIG_NETFS_STATS=20is=20not=20set=
=0D=0A#=20CONFIG_NETFS_DEBUG=20is=20not=20set=0D=0A#=20CONFIG_FSCACHE=20is=
=20not=20set=0D=0A#=20end=20of=20Caches=0D=0A=0D=0A#=0D=0A#=20CD-ROM/DVD=20=
Filesystems=0D=0A#=0D=0ACONFIG_ISO9660_FS=3Dy=0D=0ACONFIG_JOLIET=3Dy=0D=0AC=
ONFIG_ZISOFS=3Dy=0D=0A#=20CONFIG_UDF_FS=20is=20not=20set=0D=0A#=20end=20of=
=20CD-ROM/DVD=20Filesystems=0D=0A=0D=0A#=0D=0A#=20DOS/FAT/EXFAT/NT=20Filesy=
stems=0D=0A#=0D=0ACONFIG_FAT_FS=3Dy=0D=0ACONFIG_MSDOS_FS=3Dy=0D=0ACONFIG_VF=
AT_FS=3Dy=0D=0ACONFIG_FAT_DEFAULT_CODEPAGE=3D437=0D=0ACONFIG_FAT_DEFAULT_IO=
CHARSET=3D"iso8859-1"=0D=0A#=20CONFIG_FAT_DEFAULT_UTF8=20is=20not=20set=0D=
=0A#=20CONFIG_EXFAT_FS=20is=20not=20set=0D=0A#=20CONFIG_NTFS3_FS=20is=20not=
=20set=0D=0A#=20CONFIG_NTFS_FS=20is=20not=20set=0D=0A#=20end=20of=20DOS/FAT=
/EXFAT/NT=20Filesystems=0D=0A=0D=0A#=0D=0A#=20Pseudo=20filesystems=0D=0A#=
=0D=0ACONFIG_PROC_FS=3Dy=0D=0ACONFIG_PROC_KCORE=3Dy=0D=0ACONFIG_PROC_VMCORE=
=3Dy=0D=0A#=20CONFIG_PROC_VMCORE_DEVICE_DUMP=20is=20not=20set=0D=0ACONFIG_P=
ROC_SYSCTL=3Dy=0D=0ACONFIG_PROC_PAGE_MONITOR=3Dy=0D=0A#=20CONFIG_PROC_CHILD=
REN=20is=20not=20set=0D=0ACONFIG_PROC_PID_ARCH_STATUS=3Dy=0D=0ACONFIG_KERNF=
S=3Dy=0D=0ACONFIG_SYSFS=3Dy=0D=0ACONFIG_TMPFS=3Dy=0D=0ACONFIG_TMPFS_POSIX_A=
CL=3Dy=0D=0ACONFIG_TMPFS_XATTR=3Dy=0D=0A#=20CONFIG_TMPFS_INODE64=20is=20not=
=20set=0D=0A#=20CONFIG_TMPFS_QUOTA=20is=20not=20set=0D=0ACONFIG_ARCH_SUPPOR=
TS_HUGETLBFS=3Dy=0D=0ACONFIG_HUGETLBFS=3Dy=0D=0A#=20CONFIG_HUGETLB_PAGE_OPT=
IMIZE_VMEMMAP_DEFAULT_ON=20is=20not=20set=0D=0ACONFIG_HUGETLB_PAGE=3Dy=0D=
=0ACONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=3Dy=0D=0ACONFIG_HUGETLB_PMD_PAGE_TA=
BLE_SHARING=3Dy=0D=0ACONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy=0D=0ACONFIG_CONFIGFS=
_FS=3Dy=0D=0A#=20end=20of=20Pseudo=20filesystems=0D=0A=0D=0ACONFIG_MISC_FIL=
ESYSTEMS=3Dy=0D=0A#=20CONFIG_ORANGEFS_FS=20is=20not=20set=0D=0A#=20CONFIG_A=
DFS_FS=20is=20not=20set=0D=0A#=20CONFIG_AFFS_FS=20is=20not=20set=0D=0A#=20C=
ONFIG_ECRYPT_FS=20is=20not=20set=0D=0A#=20CONFIG_HFS_FS=20is=20not=20set=0D=
=0A#=20CONFIG_HFSPLUS_FS=20is=20not=20set=0D=0A#=20CONFIG_BEFS_FS=20is=20no=
t=20set=0D=0A#=20CONFIG_BFS_FS=20is=20not=20set=0D=0A#=20CONFIG_EFS_FS=20is=
=20not=20set=0D=0A#=20CONFIG_CRAMFS=20is=20not=20set=0D=0A#=20CONFIG_SQUASH=
FS=20is=20not=20set=0D=0A#=20CONFIG_VXFS_FS=20is=20not=20set=0D=0A#=20CONFI=
G_MINIX_FS=20is=20not=20set=0D=0A#=20CONFIG_OMFS_FS=20is=20not=20set=0D=0A#=
=20CONFIG_HPFS_FS=20is=20not=20set=0D=0A#=20CONFIG_QNX4FS_FS=20is=20not=20s=
et=0D=0A#=20CONFIG_QNX6FS_FS=20is=20not=20set=0D=0A#=20CONFIG_ROMFS_FS=20is=
=20not=20set=0D=0A#=20CONFIG_PSTORE=20is=20not=20set=0D=0A#=20CONFIG_UFS_FS=
=20is=20not=20set=0D=0A#=20CONFIG_EROFS_FS=20is=20not=20set=0D=0ACONFIG_NET=
WORK_FILESYSTEMS=3Dy=0D=0ACONFIG_NFS_FS=3Dy=0D=0A#=20CONFIG_NFS_V2=20is=20n=
ot=20set=0D=0ACONFIG_NFS_V3=3Dy=0D=0ACONFIG_NFS_V3_ACL=3Dy=0D=0ACONFIG_NFS_=
V4=3Dy=0D=0A#=20CONFIG_NFS_SWAP=20is=20not=20set=0D=0A#=20CONFIG_NFS_V4_1=
=20is=20not=20set=0D=0ACONFIG_ROOT_NFS=3Dy=0D=0A#=20CONFIG_NFS_FSCACHE=20is=
=20not=20set=0D=0A#=20CONFIG_NFS_USE_LEGACY_DNS=20is=20not=20set=0D=0ACONFI=
G_NFS_USE_KERNEL_DNS=3Dy=0D=0ACONFIG_NFS_DISABLE_UDP_SUPPORT=3Dy=0D=0A#=20C=
ONFIG_NFSD=20is=20not=20set=0D=0ACONFIG_GRACE_PERIOD=3Dy=0D=0ACONFIG_LOCKD=
=3Dy=0D=0ACONFIG_LOCKD_V4=3Dy=0D=0ACONFIG_NFS_ACL_SUPPORT=3Dy=0D=0ACONFIG_N=
FS_COMMON=3Dy=0D=0ACONFIG_SUNRPC=3Dy=0D=0ACONFIG_SUNRPC_GSS=3Dy=0D=0ACONFIG=
_RPCSEC_GSS_KRB5=3Dy=0D=0A#=20CONFIG_SUNRPC_DEBUG=20is=20not=20set=0D=0A#=
=20CONFIG_CEPH_FS=20is=20not=20set=0D=0A#=20CONFIG_CIFS=20is=20not=20set=0D=
=0A#=20CONFIG_SMB_SERVER=20is=20not=20set=0D=0A#=20CONFIG_CODA_FS=20is=20no=
t=20set=0D=0A#=20CONFIG_AFS_FS=20is=20not=20set=0D=0ACONFIG_9P_FS=3Dy=0D=0A=
#=20CONFIG_9P_FS_POSIX_ACL=20is=20not=20set=0D=0A#=20CONFIG_9P_FS_SECURITY=
=20is=20not=20set=0D=0ACONFIG_NLS=3Dy=0D=0ACONFIG_NLS_DEFAULT=3D"utf8"=0D=
=0ACONFIG_NLS_CODEPAGE_437=3Dy=0D=0A#=20CONFIG_NLS_CODEPAGE_737=20is=20not=
=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_775=20is=20not=20set=0D=0A#=20CONFIG_NL=
S_CODEPAGE_850=20is=20not=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_852=20is=20not=
=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_855=20is=20not=20set=0D=0A#=20CONFIG_NL=
S_CODEPAGE_857=20is=20not=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_860=20is=20not=
=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_861=20is=20not=20set=0D=0A#=20CONFIG_NL=
S_CODEPAGE_862=20is=20not=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_863=20is=20not=
=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_864=20is=20not=20set=0D=0A#=20CONFIG_NL=
S_CODEPAGE_865=20is=20not=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_866=20is=20not=
=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_869=20is=20not=20set=0D=0A#=20CONFIG_NL=
S_CODEPAGE_936=20is=20not=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_950=20is=20not=
=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_932=20is=20not=20set=0D=0A#=20CONFIG_NL=
S_CODEPAGE_949=20is=20not=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_874=20is=20not=
=20set=0D=0A#=20CONFIG_NLS_ISO8859_8=20is=20not=20set=0D=0A#=20CONFIG_NLS_C=
ODEPAGE_1250=20is=20not=20set=0D=0A#=20CONFIG_NLS_CODEPAGE_1251=20is=20not=
=20set=0D=0ACONFIG_NLS_ASCII=3Dy=0D=0ACONFIG_NLS_ISO8859_1=3Dy=0D=0A#=20CON=
FIG_NLS_ISO8859_2=20is=20not=20set=0D=0A#=20CONFIG_NLS_ISO8859_3=20is=20not=
=20set=0D=0A#=20CONFIG_NLS_ISO8859_4=20is=20not=20set=0D=0A#=20CONFIG_NLS_I=
SO8859_5=20is=20not=20set=0D=0A#=20CONFIG_NLS_ISO8859_6=20is=20not=20set=0D=
=0A#=20CONFIG_NLS_ISO8859_7=20is=20not=20set=0D=0A#=20CONFIG_NLS_ISO8859_9=
=20is=20not=20set=0D=0A#=20CONFIG_NLS_ISO8859_13=20is=20not=20set=0D=0A#=20=
CONFIG_NLS_ISO8859_14=20is=20not=20set=0D=0A#=20CONFIG_NLS_ISO8859_15=20is=
=20not=20set=0D=0A#=20CONFIG_NLS_KOI8_R=20is=20not=20set=0D=0A#=20CONFIG_NL=
S_KOI8_U=20is=20not=20set=0D=0A#=20CONFIG_NLS_MAC_ROMAN=20is=20not=20set=0D=
=0A#=20CONFIG_NLS_MAC_CELTIC=20is=20not=20set=0D=0A#=20CONFIG_NLS_MAC_CENTE=
URO=20is=20not=20set=0D=0A#=20CONFIG_NLS_MAC_CROATIAN=20is=20not=20set=0D=
=0A#=20CONFIG_NLS_MAC_CYRILLIC=20is=20not=20set=0D=0A#=20CONFIG_NLS_MAC_GAE=
LIC=20is=20not=20set=0D=0A#=20CONFIG_NLS_MAC_GREEK=20is=20not=20set=0D=0A#=
=20CONFIG_NLS_MAC_ICELAND=20is=20not=20set=0D=0A#=20CONFIG_NLS_MAC_INUIT=20=
is=20not=20set=0D=0A#=20CONFIG_NLS_MAC_ROMANIAN=20is=20not=20set=0D=0A#=20C=
ONFIG_NLS_MAC_TURKISH=20is=20not=20set=0D=0ACONFIG_NLS_UTF8=3Dy=0D=0A#=20CO=
NFIG_DLM=20is=20not=20set=0D=0A#=20CONFIG_UNICODE=20is=20not=20set=0D=0ACON=
FIG_IO_WQ=3Dy=0D=0A#=20end=20of=20File=20systems=0D=0A=0D=0A#=0D=0A#=20Secu=
rity=20options=0D=0A#=0D=0ACONFIG_KEYS=3Dy=0D=0A#=20CONFIG_KEYS_REQUEST_CAC=
HE=20is=20not=20set=0D=0A#=20CONFIG_PERSISTENT_KEYRINGS=20is=20not=20set=0D=
=0A#=20CONFIG_BIG_KEYS=20is=20not=20set=0D=0A#=20CONFIG_TRUSTED_KEYS=20is=
=20not=20set=0D=0A#=20CONFIG_ENCRYPTED_KEYS=20is=20not=20set=0D=0A#=20CONFI=
G_KEY_DH_OPERATIONS=20is=20not=20set=0D=0A#=20CONFIG_SECURITY_DMESG_RESTRIC=
T=20is=20not=20set=0D=0ACONFIG_PROC_MEM_ALWAYS_FORCE=3Dy=0D=0A#=20CONFIG_PR=
OC_MEM_FORCE_PTRACE=20is=20not=20set=0D=0A#=20CONFIG_PROC_MEM_NO_FORCE=20is=
=20not=20set=0D=0A#=20CONFIG_MSEAL_SYSTEM_MAPPINGS=20is=20not=20set=0D=0ACO=
NFIG_SECURITY=3Dy=0D=0ACONFIG_HAS_SECURITY_AUDIT=3Dy=0D=0ACONFIG_SECURITYFS=
=3Dy=0D=0ACONFIG_SECURITY_NETWORK=3Dy=0D=0A#=20CONFIG_SECURITY_NETWORK_XFRM=
=20is=20not=20set=0D=0A#=20CONFIG_SECURITY_PATH=20is=20not=20set=0D=0A#=20C=
ONFIG_INTEL_TXT=20is=20not=20set=0D=0ACONFIG_LSM_MMAP_MIN_ADDR=3D65536=0D=
=0A#=20CONFIG_STATIC_USERMODEHELPER=20is=20not=20set=0D=0ACONFIG_SECURITY_S=
ELINUX=3Dy=0D=0ACONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy=0D=0ACONFIG_SECURITY_=
SELINUX_DEVELOP=3Dy=0D=0ACONFIG_SECURITY_SELINUX_AVC_STATS=3Dy=0D=0ACONFIG_=
SECURITY_SELINUX_SIDTAB_HASH_BITS=3D9=0D=0ACONFIG_SECURITY_SELINUX_SID2STR_=
CACHE_SIZE=3D256=0D=0A#=20CONFIG_SECURITY_SELINUX_DEBUG=20is=20not=20set=0D=
=0A#=20CONFIG_SECURITY_SMACK=20is=20not=20set=0D=0A#=20CONFIG_SECURITY_TOMO=
YO=20is=20not=20set=0D=0A#=20CONFIG_SECURITY_APPARMOR=20is=20not=20set=0D=
=0A#=20CONFIG_SECURITY_LOADPIN=20is=20not=20set=0D=0A#=20CONFIG_SECURITY_YA=
MA=20is=20not=20set=0D=0A#=20CONFIG_SECURITY_SAFESETID=20is=20not=20set=0D=
=0A#=20CONFIG_SECURITY_LOCKDOWN_LSM=20is=20not=20set=0D=0A#=20CONFIG_SECURI=
TY_LANDLOCK=20is=20not=20set=0D=0A#=20CONFIG_SECURITY_IPE=20is=20not=20set=
=0D=0ACONFIG_INTEGRITY=3Dy=0D=0A#=20CONFIG_INTEGRITY_SIGNATURE=20is=20not=
=20set=0D=0ACONFIG_INTEGRITY_AUDIT=3Dy=0D=0A#=20CONFIG_IMA=20is=20not=20set=
=0D=0A#=20CONFIG_EVM=20is=20not=20set=0D=0ACONFIG_DEFAULT_SECURITY_SELINUX=
=3Dy=0D=0A#=20CONFIG_DEFAULT_SECURITY_DAC=20is=20not=20set=0D=0ACONFIG_LSM=
=3D"landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,=
ipe,bpf"=0D=0A=0D=0A#=0D=0A#=20Kernel=20hardening=20options=0D=0A#=0D=0A=0D=
=0A#=0D=0A#=20Memory=20initialization=0D=0A#=0D=0ACONFIG_INIT_STACK_NONE=3D=
y=0D=0ACONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy=0D=0A#=20CONFIG_INIT_ON_FREE_DEF=
AULT_ON=20is=20not=20set=0D=0ACONFIG_CC_HAS_ZERO_CALL_USED_REGS=3Dy=0D=0A#=
=20CONFIG_ZERO_CALL_USED_REGS=20is=20not=20set=0D=0A#=20end=20of=20Memory=
=20initialization=0D=0A=0D=0A#=0D=0A#=20Bounds=20checking=0D=0A#=0D=0ACONFI=
G_FORTIFY_SOURCE=3Dy=0D=0ACONFIG_HARDENED_USERCOPY=3Dy=0D=0A#=20CONFIG_HARD=
ENED_USERCOPY_DEFAULT_ON=20is=20not=20set=0D=0A#=20end=20of=20Bounds=20chec=
king=0D=0A=0D=0A#=0D=0A#=20Hardening=20of=20kernel=20data=20structures=0D=
=0A#=0D=0ACONFIG_LIST_HARDENED=3Dy=0D=0ACONFIG_BUG_ON_DATA_CORRUPTION=3Dy=
=0D=0A#=20end=20of=20Hardening=20of=20kernel=20data=20structures=0D=0A=0D=
=0ACONFIG_RANDSTRUCT_NONE=3Dy=0D=0A#=20end=20of=20Kernel=20hardening=20opti=
ons=0D=0A#=20end=20of=20Security=20options=0D=0A=0D=0ACONFIG_CRYPTO=3Dy=0D=
=0A=0D=0A#=0D=0A#=20Crypto=20core=20or=20helper=0D=0A#=0D=0ACONFIG_CRYPTO_A=
LGAPI=3Dy=0D=0ACONFIG_CRYPTO_ALGAPI2=3Dy=0D=0ACONFIG_CRYPTO_AEAD=3Dy=0D=0AC=
ONFIG_CRYPTO_AEAD2=3Dy=0D=0ACONFIG_CRYPTO_SIG=3Dy=0D=0ACONFIG_CRYPTO_SIG2=
=3Dy=0D=0ACONFIG_CRYPTO_SKCIPHER=3Dy=0D=0ACONFIG_CRYPTO_SKCIPHER2=3Dy=0D=0A=
CONFIG_CRYPTO_HASH=3Dy=0D=0ACONFIG_CRYPTO_HASH2=3Dy=0D=0ACONFIG_CRYPTO_RNG=
=3Dy=0D=0ACONFIG_CRYPTO_RNG2=3Dy=0D=0ACONFIG_CRYPTO_RNG_DEFAULT=3Dy=0D=0ACO=
NFIG_CRYPTO_AKCIPHER2=3Dy=0D=0ACONFIG_CRYPTO_AKCIPHER=3Dy=0D=0ACONFIG_CRYPT=
O_KPP2=3Dy=0D=0ACONFIG_CRYPTO_KPP=3Dy=0D=0ACONFIG_CRYPTO_ACOMP2=3Dy=0D=0ACO=
NFIG_CRYPTO_MANAGER=3Dy=0D=0ACONFIG_CRYPTO_MANAGER2=3Dy=0D=0A#=20CONFIG_CRY=
PTO_USER=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_SELFTESTS=20is=20not=20set=
=0D=0A#=20CONFIG_CRYPTO_NULL=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_PCRYPT=
=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_CRYPTD=20is=20not=20set=0D=0ACONFI=
G_CRYPTO_AUTHENC=3Dy=0D=0A#=20CONFIG_CRYPTO_KRB5ENC=20is=20not=20set=0D=0A#=
=20CONFIG_CRYPTO_BENCHMARK=20is=20not=20set=0D=0A#=20end=20of=20Crypto=20co=
re=20or=20helper=0D=0A=0D=0A#=0D=0A#=20Public-key=20cryptography=0D=0A#=0D=
=0ACONFIG_CRYPTO_RSA=3Dy=0D=0A#=20CONFIG_CRYPTO_DH=20is=20not=20set=0D=0ACO=
NFIG_CRYPTO_ECC=3Dy=0D=0ACONFIG_CRYPTO_ECDH=3Dy=0D=0A#=20CONFIG_CRYPTO_ECDS=
A=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_ECRDSA=20is=20not=20set=0D=0A#=20=
end=20of=20Public-key=20cryptography=0D=0A=0D=0A#=0D=0A#=20Block=20ciphers=
=0D=0A#=0D=0ACONFIG_CRYPTO_AES=3Dy=0D=0A#=20CONFIG_CRYPTO_AES_TI=20is=20not=
=20set=0D=0A#=20CONFIG_CRYPTO_ARIA=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_=
BLOWFISH=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_CAMELLIA=20is=20not=20set=
=0D=0A#=20CONFIG_CRYPTO_CAST5=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_CAST6=
=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_DES=20is=20not=20set=0D=0A#=20CONF=
IG_CRYPTO_FCRYPT=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_SERPENT=20is=20not=
=20set=0D=0A#=20CONFIG_CRYPTO_SM4_GENERIC=20is=20not=20set=0D=0A#=20CONFIG_=
CRYPTO_TWOFISH=20is=20not=20set=0D=0A#=20end=20of=20Block=20ciphers=0D=0A=
=0D=0A#=0D=0A#=20Length-preserving=20ciphers=20and=20modes=0D=0A#=0D=0A#=20=
CONFIG_CRYPTO_ADIANTUM=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_CHACHA20=20i=
s=20not=20set=0D=0ACONFIG_CRYPTO_CBC=3Dy=0D=0ACONFIG_CRYPTO_CTR=3Dy=0D=0A#=
=20CONFIG_CRYPTO_CTS=20is=20not=20set=0D=0ACONFIG_CRYPTO_ECB=3Dy=0D=0A#=20C=
ONFIG_CRYPTO_HCTR2=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_LRW=20is=20not=
=20set=0D=0A#=20CONFIG_CRYPTO_PCBC=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_=
XTS=20is=20not=20set=0D=0A#=20end=20of=20Length-preserving=20ciphers=20and=
=20modes=0D=0A=0D=0A#=0D=0A#=20AEAD=20(authenticated=20encryption=20with=20=
associated=20data)=20ciphers=0D=0A#=0D=0A#=20CONFIG_CRYPTO_AEGIS128=20is=20=
not=20set=0D=0A#=20CONFIG_CRYPTO_CHACHA20POLY1305=20is=20not=20set=0D=0ACON=
FIG_CRYPTO_CCM=3Dy=0D=0ACONFIG_CRYPTO_GCM=3Dy=0D=0ACONFIG_CRYPTO_GENIV=3Dy=
=0D=0ACONFIG_CRYPTO_SEQIV=3Dy=0D=0ACONFIG_CRYPTO_ECHAINIV=3Dy=0D=0A#=20CONF=
IG_CRYPTO_ESSIV=20is=20not=20set=0D=0A#=20end=20of=20AEAD=20(authenticated=
=20encryption=20with=20associated=20data)=20ciphers=0D=0A=0D=0A#=0D=0A#=20H=
ashes,=20digests,=20and=20MACs=0D=0A#=0D=0A#=20CONFIG_CRYPTO_BLAKE2B=20is=
=20not=20set=0D=0ACONFIG_CRYPTO_CMAC=3Dy=0D=0ACONFIG_CRYPTO_GHASH=3Dy=0D=0A=
CONFIG_CRYPTO_HMAC=3Dy=0D=0A#=20CONFIG_CRYPTO_MD4=20is=20not=20set=0D=0ACON=
FIG_CRYPTO_MD5=3Dy=0D=0A#=20CONFIG_CRYPTO_MICHAEL_MIC=20is=20not=20set=0D=
=0A#=20CONFIG_CRYPTO_RMD160=20is=20not=20set=0D=0ACONFIG_CRYPTO_SHA1=3Dy=0D=
=0ACONFIG_CRYPTO_SHA256=3Dy=0D=0ACONFIG_CRYPTO_SHA512=3Dy=0D=0ACONFIG_CRYPT=
O_SHA3=3Dy=0D=0A#=20CONFIG_CRYPTO_SM3_GENERIC=20is=20not=20set=0D=0A#=20CON=
FIG_CRYPTO_STREEBOG=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_WP512=20is=20no=
t=20set=0D=0A#=20CONFIG_CRYPTO_XCBC=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO=
_XXHASH=20is=20not=20set=0D=0A#=20end=20of=20Hashes,=20digests,=20and=20MAC=
s=0D=0A=0D=0A#=0D=0A#=20CRCs=20(cyclic=20redundancy=20checks)=0D=0A#=0D=0A#=
=20CONFIG_CRYPTO_CRC32C=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_CRC32=20is=
=20not=20set=0D=0A#=20end=20of=20CRCs=20(cyclic=20redundancy=20checks)=0D=
=0A=0D=0A#=0D=0A#=20Compression=0D=0A#=0D=0A#=20CONFIG_CRYPTO_DEFLATE=20is=
=20not=20set=0D=0ACONFIG_CRYPTO_LZO=3Dy=0D=0A#=20CONFIG_CRYPTO_842=20is=20n=
ot=20set=0D=0A#=20CONFIG_CRYPTO_LZ4=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO=
_LZ4HC=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_ZSTD=20is=20not=20set=0D=0A#=
=20end=20of=20Compression=0D=0A=0D=0A#=0D=0A#=20Random=20number=20generatio=
n=0D=0A#=0D=0A#=20CONFIG_CRYPTO_ANSI_CPRNG=20is=20not=20set=0D=0ACONFIG_CRY=
PTO_DRBG_MENU=3Dy=0D=0ACONFIG_CRYPTO_DRBG_HMAC=3Dy=0D=0A#=20CONFIG_CRYPTO_D=
RBG_HASH=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_DRBG_CTR=20is=20not=20set=
=0D=0ACONFIG_CRYPTO_DRBG=3Dy=0D=0ACONFIG_CRYPTO_JITTERENTROPY=3Dy=0D=0ACONF=
IG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=3D64=0D=0ACONFIG_CRYPTO_JITTERENTROPY=
_MEMORY_BLOCKSIZE=3D32=0D=0ACONFIG_CRYPTO_JITTERENTROPY_OSR=3D1=0D=0A#=20en=
d=20of=20Random=20number=20generation=0D=0A=0D=0A#=0D=0A#=20Userspace=20int=
erface=0D=0A#=0D=0A#=20CONFIG_CRYPTO_USER_API_HASH=20is=20not=20set=0D=0A#=
=20CONFIG_CRYPTO_USER_API_SKCIPHER=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_=
USER_API_RNG=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_USER_API_AEAD=20is=20n=
ot=20set=0D=0A#=20end=20of=20Userspace=20interface=0D=0A=0D=0A#=0D=0A#=20Ac=
celerated=20Cryptographic=20Algorithms=20for=20CPU=20(x86)=0D=0A#=0D=0A#=20=
CONFIG_CRYPTO_AES_NI_INTEL=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_BLOWFISH=
_X86_64=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_CAMELLIA_X86_64=20is=20not=
=20set=0D=0A#=20CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=20is=20not=20set=0D=
=0A#=20CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=20is=20not=20set=0D=0A#=20C=
ONFIG_CRYPTO_CAST5_AVX_X86_64=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_CAST6=
_AVX_X86_64=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_DES3_EDE_X86_64=20is=20=
not=20set=0D=0A#=20CONFIG_CRYPTO_SERPENT_SSE2_X86_64=20is=20not=20set=0D=0A=
#=20CONFIG_CRYPTO_SERPENT_AVX_X86_64=20is=20not=20set=0D=0A#=20CONFIG_CRYPT=
O_SERPENT_AVX2_X86_64=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_SM4_AESNI_AVX=
_X86_64=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=20is=
=20not=20set=0D=0A#=20CONFIG_CRYPTO_TWOFISH_X86_64=20is=20not=20set=0D=0A#=
=20CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=20is=20not=20set=0D=0A#=20CONFIG_CRYPT=
O_TWOFISH_AVX_X86_64=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_ARIA_AESNI_AVX=
_X86_64=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64=20is=
=20not=20set=0D=0A#=20CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64=20is=20not=20se=
t=0D=0A#=20CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=20is=20not=20set=0D=0A#=20CONF=
IG_CRYPTO_NHPOLY1305_SSE2=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_NHPOLY130=
5_AVX2=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_POLYVAL_CLMUL_NI=20is=20not=
=20set=0D=0A#=20CONFIG_CRYPTO_SM3_AVX_X86_64=20is=20not=20set=0D=0A#=20CONF=
IG_CRYPTO_GHASH_CLMUL_NI_INTEL=20is=20not=20set=0D=0A#=20end=20of=20Acceler=
ated=20Cryptographic=20Algorithms=20for=20CPU=20(x86)=0D=0A=0D=0ACONFIG_CRY=
PTO_HW=3Dy=0D=0A#=20CONFIG_CRYPTO_DEV_PADLOCK=20is=20not=20set=0D=0A#=20CON=
FIG_CRYPTO_DEV_ATMEL_ECC=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_DEV_ATMEL_=
SHA204A=20is=20not=20set=0D=0ACONFIG_CRYPTO_DEV_CCP=3Dy=0D=0ACONFIG_CRYPTO_=
DEV_CCP_DD=3Dy=0D=0A#=20CONFIG_CRYPTO_DEV_SP_CCP=20is=20not=20set=0D=0ACONF=
IG_CRYPTO_DEV_SP_PSP=3Dy=0D=0A#=20CONFIG_CRYPTO_DEV_NITROX_CNN55XX=20is=20n=
ot=20set=0D=0A#=20CONFIG_CRYPTO_DEV_QAT_DH895xCC=20is=20not=20set=0D=0A#=20=
CONFIG_CRYPTO_DEV_QAT_C3XXX=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_DEV_QAT=
_C62X=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_DEV_QAT_4XXX=20is=20not=20set=
=0D=0A#=20CONFIG_CRYPTO_DEV_QAT_420XX=20is=20not=20set=0D=0A#=20CONFIG_CRYP=
TO_DEV_QAT_6XXX=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=
=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_DEV_QAT_C3XXXVF=20is=20not=20set=
=0D=0A#=20CONFIG_CRYPTO_DEV_QAT_C62XVF=20is=20not=20set=0D=0A#=20CONFIG_CRY=
PTO_DEV_VIRTIO=20is=20not=20set=0D=0A#=20CONFIG_CRYPTO_DEV_SAFEXCEL=20is=20=
not=20set=0D=0A#=20CONFIG_CRYPTO_DEV_CCREE=20is=20not=20set=0D=0A#=20CONFIG=
_CRYPTO_DEV_AMLOGIC_GXL=20is=20not=20set=0D=0ACONFIG_ASYMMETRIC_KEY_TYPE=3D=
y=0D=0ACONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy=0D=0ACONFIG_X509_CERTIFICAT=
E_PARSER=3Dy=0D=0A#=20CONFIG_PKCS8_PRIVATE_KEY_PARSER=20is=20not=20set=0D=
=0ACONFIG_PKCS7_MESSAGE_PARSER=3Dy=0D=0A#=20CONFIG_PKCS7_TEST_KEY=20is=20no=
t=20set=0D=0A#=20CONFIG_SIGNED_PE_FILE_VERIFICATION=20is=20not=20set=0D=0A#=
=20CONFIG_FIPS_SIGNATURE_SELFTEST=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20Ce=
rtificates=20for=20signature=20checking=0D=0A#=0D=0ACONFIG_SYSTEM_TRUSTED_K=
EYRING=3Dy=0D=0ACONFIG_SYSTEM_TRUSTED_KEYS=3D""=0D=0A#=20CONFIG_SYSTEM_EXTR=
A_CERTIFICATE=20is=20not=20set=0D=0A#=20CONFIG_SECONDARY_TRUSTED_KEYRING=20=
is=20not=20set=0D=0A#=20CONFIG_SYSTEM_BLACKLIST_KEYRING=20is=20not=20set=0D=
=0A#=20end=20of=20Certificates=20for=20signature=20checking=0D=0A=0D=0A#=20=
CONFIG_CRYPTO_KRB5=20is=20not=20set=0D=0ACONFIG_BINARY_PRINTF=3Dy=0D=0A=0D=
=0A#=0D=0A#=20Library=20routines=0D=0A#=0D=0ACONFIG_LINEAR_RANGES=3Dy=0D=0A=
#=20CONFIG_PACKING=20is=20not=20set=0D=0ACONFIG_BITREVERSE=3Dy=0D=0ACONFIG_=
GENERIC_STRNCPY_FROM_USER=3Dy=0D=0ACONFIG_GENERIC_STRNLEN_USER=3Dy=0D=0ACON=
FIG_GENERIC_NET_UTILS=3Dy=0D=0A#=20CONFIG_CORDIC=20is=20not=20set=0D=0A#=20=
CONFIG_PRIME_NUMBERS=20is=20not=20set=0D=0ACONFIG_RATIONAL=3Dy=0D=0ACONFIG_=
GENERIC_IOMAP=3Dy=0D=0ACONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy=0D=0ACONFIG_ARCH=
_HAS_FAST_MULTIPLIER=3Dy=0D=0ACONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy=0D=0ACONF=
IG_CRC8=3Dy=0D=0ACONFIG_CRC16=3Dy=0D=0ACONFIG_CRC_CCITT=3Dy=0D=0ACONFIG_CRC=
_ITU_T=3Dy=0D=0ACONFIG_CRC_T10DIF=3Dy=0D=0ACONFIG_CRC_T10DIF_ARCH=3Dy=0D=0A=
CONFIG_CRC32=3Dy=0D=0ACONFIG_CRC32_ARCH=3Dy=0D=0ACONFIG_CRC_OPTIMIZATIONS=
=3Dy=0D=0A=0D=0A#=0D=0A#=20Crypto=20library=20routines=0D=0A#=0D=0ACONFIG_C=
RYPTO_HASH_INFO=3Dy=0D=0ACONFIG_CRYPTO_LIB_UTILS=3Dy=0D=0ACONFIG_CRYPTO_LIB=
_AES=3Dy=0D=0ACONFIG_CRYPTO_LIB_ARC4=3Dy=0D=0ACONFIG_CRYPTO_LIB_GF128MUL=3D=
y=0D=0ACONFIG_CRYPTO_LIB_BLAKE2S_ARCH=3Dy=0D=0ACONFIG_CRYPTO_LIB_MD5=3Dy=0D=
=0ACONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D11=0D=0ACONFIG_CRYPTO_LIB_SHA1=3Dy=0D=
=0ACONFIG_CRYPTO_LIB_SHA1_ARCH=3Dy=0D=0ACONFIG_CRYPTO_LIB_SHA256=3Dy=0D=0AC=
ONFIG_CRYPTO_LIB_SHA256_ARCH=3Dy=0D=0ACONFIG_CRYPTO_LIB_SHA512=3Dy=0D=0ACON=
FIG_CRYPTO_LIB_SHA512_ARCH=3Dy=0D=0A#=20end=20of=20Crypto=20library=20routi=
nes=0D=0A=0D=0ACONFIG_XXHASH=3Dy=0D=0A#=20CONFIG_RANDOM32_SELFTEST=20is=20n=
ot=20set=0D=0ACONFIG_ZLIB_INFLATE=3Dy=0D=0ACONFIG_ZLIB_DEFLATE=3Dy=0D=0ACON=
FIG_LZO_COMPRESS=3Dy=0D=0ACONFIG_LZO_DECOMPRESS=3Dy=0D=0ACONFIG_LZ4_COMPRES=
S=3Dy=0D=0ACONFIG_LZ4_DECOMPRESS=3Dy=0D=0ACONFIG_ZSTD_COMMON=3Dy=0D=0ACONFI=
G_ZSTD_DECOMPRESS=3Dy=0D=0ACONFIG_XZ_DEC=3Dy=0D=0ACONFIG_XZ_DEC_X86=3Dy=0D=
=0ACONFIG_XZ_DEC_POWERPC=3Dy=0D=0ACONFIG_XZ_DEC_ARM=3Dy=0D=0ACONFIG_XZ_DEC_=
ARMTHUMB=3Dy=0D=0ACONFIG_XZ_DEC_ARM64=3Dy=0D=0ACONFIG_XZ_DEC_SPARC=3Dy=0D=
=0ACONFIG_XZ_DEC_RISCV=3Dy=0D=0A#=20CONFIG_XZ_DEC_MICROLZMA=20is=20not=20se=
t=0D=0ACONFIG_XZ_DEC_BCJ=3Dy=0D=0A#=20CONFIG_XZ_DEC_TEST=20is=20not=20set=
=0D=0ACONFIG_DECOMPRESS_GZIP=3Dy=0D=0ACONFIG_DECOMPRESS_BZIP2=3Dy=0D=0ACONF=
IG_DECOMPRESS_LZMA=3Dy=0D=0ACONFIG_DECOMPRESS_XZ=3Dy=0D=0ACONFIG_DECOMPRESS=
_LZO=3Dy=0D=0ACONFIG_DECOMPRESS_LZ4=3Dy=0D=0ACONFIG_DECOMPRESS_ZSTD=3Dy=0D=
=0ACONFIG_GENERIC_ALLOCATOR=3Dy=0D=0ACONFIG_INTERVAL_TREE=3Dy=0D=0ACONFIG_X=
ARRAY_MULTI=3Dy=0D=0ACONFIG_ASSOCIATIVE_ARRAY=3Dy=0D=0ACONFIG_HAS_IOMEM=3Dy=
=0D=0ACONFIG_HAS_IOPORT=3Dy=0D=0ACONFIG_HAS_IOPORT_MAP=3Dy=0D=0ACONFIG_HAS_=
DMA=3Dy=0D=0ACONFIG_DMA_OPS_HELPERS=3Dy=0D=0ACONFIG_NEED_SG_DMA_FLAGS=3Dy=
=0D=0ACONFIG_NEED_SG_DMA_LENGTH=3Dy=0D=0ACONFIG_NEED_DMA_MAP_STATE=3Dy=0D=
=0ACONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy=0D=0ACONFIG_DMA_DECLARE_COHERENT=3Dy=0D=
=0ACONFIG_SWIOTLB=3Dy=0D=0A#=20CONFIG_SWIOTLB_DYNAMIC=20is=20not=20set=0D=
=0ACONFIG_DMA_NEED_SYNC=3Dy=0D=0A#=20CONFIG_DMA_RESTRICTED_POOL=20is=20not=
=20set=0D=0A#=20CONFIG_DMA_API_DEBUG=20is=20not=20set=0D=0A#=20CONFIG_DMA_M=
AP_BENCHMARK=20is=20not=20set=0D=0ACONFIG_SGL_ALLOC=3Dy=0D=0ACONFIG_CHECK_S=
IGNATURE=3Dy=0D=0A#=20CONFIG_CPUMASK_OFFSTACK=20is=20not=20set=0D=0ACONFIG_=
CPU_RMAP=3Dy=0D=0ACONFIG_DQL=3Dy=0D=0ACONFIG_GLOB=3Dy=0D=0A#=20CONFIG_GLOB_=
SELFTEST=20is=20not=20set=0D=0ACONFIG_NLATTR=3Dy=0D=0ACONFIG_CLZ_TAB=3Dy=0D=
=0A#=20CONFIG_IRQ_POLL=20is=20not=20set=0D=0ACONFIG_MPILIB=3Dy=0D=0ACONFIG_=
DIMLIB=3Dy=0D=0ACONFIG_LIBFDT=3Dy=0D=0ACONFIG_OID_REGISTRY=3Dy=0D=0ACONFIG_=
HAVE_GENERIC_VDSO=3Dy=0D=0ACONFIG_GENERIC_GETTIMEOFDAY=3Dy=0D=0ACONFIG_GENE=
RIC_VDSO_OVERFLOW_PROTECT=3Dy=0D=0ACONFIG_VDSO_GETRANDOM=3Dy=0D=0ACONFIG_SG=
_POOL=3Dy=0D=0ACONFIG_ARCH_HAS_PMEM_API=3Dy=0D=0ACONFIG_ARCH_HAS_CPU_CACHE_=
INVALIDATE_MEMREGION=3Dy=0D=0ACONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy=0D=0AC=
ONFIG_ARCH_HAS_COPY_MC=3Dy=0D=0ACONFIG_ARCH_STACKWALK=3Dy=0D=0ACONFIG_STACK=
DEPOT=3Dy=0D=0ACONFIG_STACKDEPOT_ALWAYS_INIT=3Dy=0D=0ACONFIG_STACKDEPOT_MAX=
_FRAMES=3D64=0D=0ACONFIG_REF_TRACKER=3Dy=0D=0ACONFIG_SBITMAP=3Dy=0D=0A#=20C=
ONFIG_LWQ_TEST=20is=20not=20set=0D=0A#=20end=20of=20Library=20routines=0D=
=0A=0D=0ACONFIG_FIRMWARE_TABLE=3Dy=0D=0ACONFIG_UNION_FIND=3Dy=0D=0A=0D=0A#=
=0D=0A#=20Kernel=20hacking=0D=0A#=0D=0A=0D=0A#=0D=0A#=20printk=20and=20dmes=
g=20options=0D=0A#=0D=0ACONFIG_PRINTK_TIME=3Dy=0D=0ACONFIG_PRINTK_CALLER=3D=
y=0D=0A#=20CONFIG_STACKTRACE_BUILD_ID=20is=20not=20set=0D=0ACONFIG_CONSOLE_=
LOGLEVEL_DEFAULT=3D7=0D=0ACONFIG_CONSOLE_LOGLEVEL_QUIET=3D4=0D=0ACONFIG_MES=
SAGE_LOGLEVEL_DEFAULT=3D4=0D=0A#=20CONFIG_BOOT_PRINTK_DELAY=20is=20not=20se=
t=0D=0ACONFIG_DYNAMIC_DEBUG=3Dy=0D=0ACONFIG_DYNAMIC_DEBUG_CORE=3Dy=0D=0ACON=
FIG_SYMBOLIC_ERRNAME=3Dy=0D=0ACONFIG_DEBUG_BUGVERBOSE=3Dy=0D=0A#=20end=20of=
=20printk=20and=20dmesg=20options=0D=0A=0D=0ACONFIG_DEBUG_KERNEL=3Dy=0D=0AC=
ONFIG_DEBUG_MISC=3Dy=0D=0A=0D=0A#=0D=0A#=20Compile-time=20checks=20and=20co=
mpiler=20options=0D=0A#=0D=0ACONFIG_DEBUG_INFO=3Dy=0D=0ACONFIG_AS_HAS_NON_C=
ONST_ULEB128=3Dy=0D=0A#=20CONFIG_DEBUG_INFO_NONE=20is=20not=20set=0D=0A#=20=
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=20is=20not=20set=0D=0ACONFIG_DEBU=
G_INFO_DWARF4=3Dy=0D=0A#=20CONFIG_DEBUG_INFO_DWARF5=20is=20not=20set=0D=0A#=
=20CONFIG_DEBUG_INFO_REDUCED=20is=20not=20set=0D=0ACONFIG_DEBUG_INFO_COMPRE=
SSED_NONE=3Dy=0D=0A#=20CONFIG_DEBUG_INFO_COMPRESSED_ZLIB=20is=20not=20set=
=0D=0A#=20CONFIG_DEBUG_INFO_SPLIT=20is=20not=20set=0D=0A#=20CONFIG_DEBUG_IN=
FO_BTF=20is=20not=20set=0D=0ACONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy=0D=0ACONFIG_PA=
HOLE_HAS_LANG_EXCLUDE=3Dy=0D=0A#=20CONFIG_GDB_SCRIPTS=20is=20not=20set=0D=
=0ACONFIG_FRAME_WARN=3D2048=0D=0A#=20CONFIG_STRIP_ASM_SYMS=20is=20not=20set=
=0D=0A#=20CONFIG_READABLE_ASM=20is=20not=20set=0D=0A#=20CONFIG_HEADERS_INST=
ALL=20is=20not=20set=0D=0A#=20CONFIG_DEBUG_SECTION_MISMATCH=20is=20not=20se=
t=0D=0ACONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy=0D=0A#=20CONFIG_DEBUG_FORCE_FU=
NCTION_ALIGN_64B=20is=20not=20set=0D=0ACONFIG_OBJTOOL=3Dy=0D=0A#=20CONFIG_O=
BJTOOL_WERROR=20is=20not=20set=0D=0ACONFIG_NOINSTR_VALIDATION=3Dy=0D=0A#=20=
CONFIG_VMLINUX_MAP=20is=20not=20set=0D=0A#=20CONFIG_DEBUG_FORCE_WEAK_PER_CP=
U=20is=20not=20set=0D=0A#=20end=20of=20Compile-time=20checks=20and=20compil=
er=20options=0D=0A=0D=0A#=0D=0A#=20Generic=20Kernel=20Debugging=20Instrumen=
ts=0D=0A#=0D=0A#=20CONFIG_MAGIC_SYSRQ=20is=20not=20set=0D=0ACONFIG_DEBUG_FS=
=3Dy=0D=0ACONFIG_DEBUG_FS_ALLOW_ALL=3Dy=0D=0A#=20CONFIG_DEBUG_FS_DISALLOW_M=
OUNT=20is=20not=20set=0D=0A#=20CONFIG_DEBUG_FS_ALLOW_NONE=20is=20not=20set=
=0D=0ACONFIG_HAVE_ARCH_KGDB=3Dy=0D=0A#=20CONFIG_KGDB=20is=20not=20set=0D=0A=
CONFIG_ARCH_HAS_UBSAN=3Dy=0D=0ACONFIG_UBSAN=3Dy=0D=0A#=20CONFIG_UBSAN_TRAP=
=20is=20not=20set=0D=0ACONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=3Dy=0D=0ACONFIG_UB=
SAN_BOUNDS=3Dy=0D=0ACONFIG_UBSAN_BOUNDS_STRICT=3Dy=0D=0ACONFIG_UBSAN_SHIFT=
=3Dy=0D=0A#=20CONFIG_UBSAN_DIV_ZERO=20is=20not=20set=0D=0A#=20CONFIG_UBSAN_=
BOOL=20is=20not=20set=0D=0A#=20CONFIG_UBSAN_ENUM=20is=20not=20set=0D=0A#=20=
CONFIG_UBSAN_ALIGNMENT=20is=20not=20set=0D=0A#=20CONFIG_TEST_UBSAN=20is=20n=
ot=20set=0D=0ACONFIG_HAVE_ARCH_KCSAN=3Dy=0D=0ACONFIG_HAVE_KCSAN_COMPILER=3D=
y=0D=0A#=20end=20of=20Generic=20Kernel=20Debugging=20Instruments=0D=0A=0D=
=0A#=0D=0A#=20Networking=20Debugging=0D=0A#=0D=0ACONFIG_NET_DEV_REFCNT_TRAC=
KER=3Dy=0D=0ACONFIG_NET_NS_REFCNT_TRACKER=3Dy=0D=0ACONFIG_DEBUG_NET=3Dy=0D=
=0A#=20CONFIG_DEBUG_NET_SMALL_RTNL=20is=20not=20set=0D=0A#=20end=20of=20Net=
working=20Debugging=0D=0A=0D=0A#=0D=0A#=20Memory=20Debugging=0D=0A#=0D=0ACO=
NFIG_PAGE_EXTENSION=3Dy=0D=0A#=20CONFIG_DEBUG_PAGEALLOC=20is=20not=20set=0D=
=0ACONFIG_SLUB_DEBUG=3Dy=0D=0A#=20CONFIG_SLUB_DEBUG_ON=20is=20not=20set=0D=
=0ACONFIG_SLUB_RCU_DEBUG=3Dy=0D=0ACONFIG_PAGE_OWNER=3Dy=0D=0ACONFIG_PAGE_TA=
BLE_CHECK=3Dy=0D=0ACONFIG_PAGE_TABLE_CHECK_ENFORCED=3Dy=0D=0ACONFIG_PAGE_PO=
ISONING=3Dy=0D=0A#=20CONFIG_DEBUG_PAGE_REF=20is=20not=20set=0D=0A#=20CONFIG=
_DEBUG_RODATA_TEST=20is=20not=20set=0D=0ACONFIG_ARCH_HAS_DEBUG_WX=3Dy=0D=0A=
CONFIG_DEBUG_WX=3Dy=0D=0ACONFIG_ARCH_HAS_PTDUMP=3Dy=0D=0ACONFIG_PTDUMP=3Dy=
=0D=0ACONFIG_PTDUMP_DEBUGFS=3Dy=0D=0ACONFIG_HAVE_DEBUG_KMEMLEAK=3Dy=0D=0A#=
=20CONFIG_DEBUG_KMEMLEAK=20is=20not=20set=0D=0A#=20CONFIG_PER_VMA_LOCK_STAT=
S=20is=20not=20set=0D=0ACONFIG_DEBUG_OBJECTS=3Dy=0D=0A#=20CONFIG_DEBUG_OBJE=
CTS_SELFTEST=20is=20not=20set=0D=0ACONFIG_DEBUG_OBJECTS_FREE=3Dy=0D=0ACONFI=
G_DEBUG_OBJECTS_TIMERS=3Dy=0D=0ACONFIG_DEBUG_OBJECTS_WORK=3Dy=0D=0ACONFIG_D=
EBUG_OBJECTS_RCU_HEAD=3Dy=0D=0ACONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=3Dy=0D=
=0ACONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=3D1=0D=0A#=20CONFIG_SHRINKER_DEBUG=
=20is=20not=20set=0D=0ACONFIG_DEBUG_STACK_USAGE=3Dy=0D=0ACONFIG_SCHED_STACK=
_END_CHECK=3Dy=0D=0ACONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy=0D=0A#=20CONFIG_DE=
BUG_VFS=20is=20not=20set=0D=0ACONFIG_DEBUG_VM_IRQSOFF=3Dy=0D=0ACONFIG_DEBUG=
_VM=3Dy=0D=0ACONFIG_DEBUG_VM_MAPLE_TREE=3Dy=0D=0ACONFIG_DEBUG_VM_RB=3Dy=0D=
=0ACONFIG_DEBUG_VM_PGFLAGS=3Dy=0D=0ACONFIG_DEBUG_VM_PGTABLE=3Dy=0D=0ACONFIG=
_ARCH_HAS_DEBUG_VIRTUAL=3Dy=0D=0ACONFIG_DEBUG_VIRTUAL=3Dy=0D=0ACONFIG_DEBUG=
_MEMORY_INIT=3Dy=0D=0ACONFIG_DEBUG_PER_CPU_MAPS=3Dy=0D=0ACONFIG_DEBUG_KMAP_=
LOCAL=3Dy=0D=0ACONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=3Dy=0D=0ACONFIG_DE=
BUG_KMAP_LOCAL_FORCE_MAP=3Dy=0D=0A#=20CONFIG_MEM_ALLOC_PROFILING=20is=20not=
=20set=0D=0ACONFIG_HAVE_ARCH_KASAN=3Dy=0D=0ACONFIG_HAVE_ARCH_KASAN_VMALLOC=
=3Dy=0D=0ACONFIG_CC_HAS_KASAN_GENERIC=3Dy=0D=0ACONFIG_CC_HAS_WORKING_NOSANI=
TIZE_ADDRESS=3Dy=0D=0ACONFIG_KASAN=3Dy=0D=0ACONFIG_KASAN_GENERIC=3Dy=0D=0A#=
=20CONFIG_KASAN_OUTLINE=20is=20not=20set=0D=0ACONFIG_KASAN_INLINE=3Dy=0D=0A=
CONFIG_KASAN_STACK=3Dy=0D=0ACONFIG_KASAN_VMALLOC=3Dy=0D=0A#=20CONFIG_KASAN_=
EXTRA_INFO=20is=20not=20set=0D=0ACONFIG_HAVE_ARCH_KFENCE=3Dy=0D=0A#=20CONFI=
G_KFENCE=20is=20not=20set=0D=0ACONFIG_HAVE_ARCH_KMSAN=3Dy=0D=0A#=20end=20of=
=20Memory=20Debugging=0D=0A=0D=0A#=20CONFIG_DEBUG_SHIRQ=20is=20not=20set=0D=
=0A=0D=0A#=0D=0A#=20Debug=20Oops,=20Lockups=20and=20Hangs=0D=0A#=0D=0ACONFI=
G_PANIC_ON_OOPS=3Dy=0D=0ACONFIG_PANIC_TIMEOUT=3D86400=0D=0ACONFIG_LOCKUP_DE=
TECTOR=3Dy=0D=0ACONFIG_SOFTLOCKUP_DETECTOR=3Dy=0D=0ACONFIG_BOOTPARAM_SOFTLO=
CKUP_PANIC=3Dy=0D=0ACONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy=0D=0ACONFIG_H=
ARDLOCKUP_DETECTOR=3Dy=0D=0A#=20CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY=20i=
s=20not=20set=0D=0ACONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy=0D=0A#=20CONFIG_HARD=
LOCKUP_DETECTOR_BUDDY=20is=20not=20set=0D=0A#=20CONFIG_HARDLOCKUP_DETECTOR_=
ARCH=20is=20not=20set=0D=0ACONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=3Dy=0D=
=0ACONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy=0D=0ACONFIG_BOOTPARAM_HARDLOCKUP_P=
ANIC=3Dy=0D=0ACONFIG_DETECT_HUNG_TASK=3Dy=0D=0ACONFIG_DEFAULT_HUNG_TASK_TIM=
EOUT=3D140=0D=0ACONFIG_BOOTPARAM_HUNG_TASK_PANIC=3Dy=0D=0A#=20CONFIG_DETECT=
_HUNG_TASK_BLOCKER=20is=20not=20set=0D=0ACONFIG_WQ_WATCHDOG=3Dy=0D=0A#=20CO=
NFIG_WQ_CPU_INTENSIVE_REPORT=20is=20not=20set=0D=0A#=20CONFIG_TEST_LOCKUP=
=20is=20not=20set=0D=0A#=20end=20of=20Debug=20Oops,=20Lockups=20and=20Hangs=
=0D=0A=0D=0A#=0D=0A#=20Scheduler=20Debugging=0D=0A#=0D=0ACONFIG_SCHED_INFO=
=3Dy=0D=0ACONFIG_SCHEDSTATS=3Dy=0D=0A#=20end=20of=20Scheduler=20Debugging=
=0D=0A=0D=0ACONFIG_DEBUG_PREEMPT=3Dy=0D=0A=0D=0A#=0D=0A#=20Lock=20Debugging=
=20(spinlocks,=20mutexes,=20etc=2E=2E=2E)=0D=0A#=0D=0ACONFIG_LOCK_DEBUGGING=
_SUPPORT=3Dy=0D=0ACONFIG_PROVE_LOCKING=3Dy=0D=0ACONFIG_PROVE_RAW_LOCK_NESTI=
NG=3Dy=0D=0A#=20CONFIG_LOCK_STAT=20is=20not=20set=0D=0ACONFIG_DEBUG_RT_MUTE=
XES=3Dy=0D=0ACONFIG_DEBUG_SPINLOCK=3Dy=0D=0ACONFIG_DEBUG_MUTEXES=3Dy=0D=0AC=
ONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy=0D=0ACONFIG_DEBUG_RWSEMS=3Dy=0D=0ACONFIG_=
DEBUG_LOCK_ALLOC=3Dy=0D=0ACONFIG_LOCKDEP=3Dy=0D=0ACONFIG_LOCKDEP_BITS=3D20=
=0D=0ACONFIG_LOCKDEP_CHAINS_BITS=3D20=0D=0ACONFIG_LOCKDEP_STACK_TRACE_BITS=
=3D20=0D=0ACONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=3D14=0D=0ACONFIG_LOCKDEP_CI=
RCULAR_QUEUE_BITS=3D12=0D=0A#=20CONFIG_DEBUG_LOCKDEP=20is=20not=20set=0D=0A=
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy=0D=0A#=20CONFIG_DEBUG_LOCKING_API_SELFTESTS=
=20is=20not=20set=0D=0A#=20CONFIG_LOCK_TORTURE_TEST=20is=20not=20set=0D=0A#=
=20CONFIG_WW_MUTEX_SELFTEST=20is=20not=20set=0D=0A#=20CONFIG_SCF_TORTURE_TE=
ST=20is=20not=20set=0D=0ACONFIG_CSD_LOCK_WAIT_DEBUG=3Dy=0D=0A#=20CONFIG_CSD=
_LOCK_WAIT_DEBUG_DEFAULT=20is=20not=20set=0D=0A#=20end=20of=20Lock=20Debugg=
ing=20(spinlocks,=20mutexes,=20etc=2E=2E=2E)=0D=0A=0D=0ACONFIG_TRACE_IRQFLA=
GS=3Dy=0D=0ACONFIG_TRACE_IRQFLAGS_NMI=3Dy=0D=0ACONFIG_NMI_CHECK_CPU=3Dy=0D=
=0ACONFIG_DEBUG_IRQFLAGS=3Dy=0D=0ACONFIG_STACKTRACE=3Dy=0D=0A#=20CONFIG_WAR=
N_ALL_UNSEEDED_RANDOM=20is=20not=20set=0D=0A#=20CONFIG_DEBUG_KOBJECT=20is=
=20not=20set=0D=0A#=20CONFIG_DEBUG_KOBJECT_RELEASE=20is=20not=20set=0D=0A=
=0D=0A#=0D=0A#=20Debug=20kernel=20data=20structures=0D=0A#=0D=0ACONFIG_DEBU=
G_LIST=3Dy=0D=0ACONFIG_DEBUG_PLIST=3Dy=0D=0ACONFIG_DEBUG_SG=3Dy=0D=0ACONFIG=
_DEBUG_NOTIFIERS=3Dy=0D=0ACONFIG_DEBUG_MAPLE_TREE=3Dy=0D=0A#=20end=20of=20D=
ebug=20kernel=20data=20structures=0D=0A=0D=0A#=0D=0A#=20RCU=20Debugging=0D=
=0A#=0D=0ACONFIG_PROVE_RCU=3Dy=0D=0A#=20CONFIG_RCU_SCALE_TEST=20is=20not=20=
set=0D=0A#=20CONFIG_RCU_TORTURE_TEST=20is=20not=20set=0D=0A#=20CONFIG_RCU_R=
EF_SCALE_TEST=20is=20not=20set=0D=0ACONFIG_RCU_CPU_STALL_TIMEOUT=3D100=0D=
=0ACONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0=0D=0A#=20CONFIG_RCU_CPU_STALL_CPUTI=
ME=20is=20not=20set=0D=0A#=20CONFIG_RCU_TRACE=20is=20not=20set=0D=0ACONFIG_=
RCU_EQS_DEBUG=3Dy=0D=0A#=20end=20of=20RCU=20Debugging=0D=0A=0D=0A#=20CONFIG=
_DEBUG_WQ_FORCE_RR_CPU=20is=20not=20set=0D=0A#=20CONFIG_CPU_HOTPLUG_STATE_C=
ONTROL=20is=20not=20set=0D=0A#=20CONFIG_LATENCYTOP=20is=20not=20set=0D=0ACO=
NFIG_USER_STACKTRACE_SUPPORT=3Dy=0D=0ACONFIG_NOP_TRACER=3Dy=0D=0ACONFIG_HAV=
E_RETHOOK=3Dy=0D=0ACONFIG_HAVE_FUNCTION_TRACER=3Dy=0D=0ACONFIG_HAVE_DYNAMIC=
_FTRACE=3Dy=0D=0ACONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy=0D=0ACONFIG_HAVE_=
DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy=0D=0ACONFIG_HAVE_DYNAMIC_FTRACE_WITH_A=
RGS=3Dy=0D=0ACONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS=3Dy=0D=0ACONFIG_HAVE_DY=
NAMIC_FTRACE_NO_PATCHABLE=3Dy=0D=0ACONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy=0D=
=0ACONFIG_HAVE_FENTRY=3Dy=0D=0ACONFIG_HAVE_OBJTOOL_MCOUNT=3Dy=0D=0ACONFIG_H=
AVE_OBJTOOL_NOP_MCOUNT=3Dy=0D=0ACONFIG_HAVE_C_RECORDMCOUNT=3Dy=0D=0ACONFIG_=
HAVE_BUILDTIME_MCOUNT_SORT=3Dy=0D=0ACONFIG_TRACE_CLOCK=3Dy=0D=0ACONFIG_RING=
_BUFFER=3Dy=0D=0ACONFIG_EVENT_TRACING=3Dy=0D=0ACONFIG_CONTEXT_SWITCH_TRACER=
=3Dy=0D=0ACONFIG_PREEMPTIRQ_TRACEPOINTS=3Dy=0D=0ACONFIG_TRACING=3Dy=0D=0ACO=
NFIG_GENERIC_TRACER=3Dy=0D=0ACONFIG_TRACING_SUPPORT=3Dy=0D=0ACONFIG_FTRACE=
=3Dy=0D=0ACONFIG_TRACEFS_AUTOMOUNT_DEPRECATED=3Dy=0D=0A#=20CONFIG_BOOTTIME_=
TRACING=20is=20not=20set=0D=0A#=20CONFIG_FUNCTION_TRACER=20is=20not=20set=
=0D=0A#=20CONFIG_STACK_TRACER=20is=20not=20set=0D=0A#=20CONFIG_IRQSOFF_TRAC=
ER=20is=20not=20set=0D=0A#=20CONFIG_PREEMPT_TRACER=20is=20not=20set=0D=0A#=
=20CONFIG_SCHED_TRACER=20is=20not=20set=0D=0A#=20CONFIG_HWLAT_TRACER=20is=
=20not=20set=0D=0A#=20CONFIG_OSNOISE_TRACER=20is=20not=20set=0D=0A#=20CONFI=
G_TIMERLAT_TRACER=20is=20not=20set=0D=0A#=20CONFIG_MMIOTRACE=20is=20not=20s=
et=0D=0A#=20CONFIG_FTRACE_SYSCALLS=20is=20not=20set=0D=0A#=20CONFIG_TRACER_=
SNAPSHOT=20is=20not=20set=0D=0ACONFIG_BRANCH_PROFILE_NONE=3Dy=0D=0A#=20CONF=
IG_PROFILE_ANNOTATED_BRANCHES=20is=20not=20set=0D=0ACONFIG_BLK_DEV_IO_TRACE=
=3Dy=0D=0ACONFIG_UPROBE_EVENTS=3Dy=0D=0ACONFIG_EPROBE_EVENTS=3Dy=0D=0ACONFI=
G_BPF_EVENTS=3Dy=0D=0ACONFIG_DYNAMIC_EVENTS=3Dy=0D=0ACONFIG_PROBE_EVENTS=3D=
y=0D=0A#=20CONFIG_SYNTH_EVENTS=20is=20not=20set=0D=0A#=20CONFIG_USER_EVENTS=
=20is=20not=20set=0D=0A#=20CONFIG_HIST_TRIGGERS=20is=20not=20set=0D=0ACONFI=
G_TRACE_EVENT_INJECT=3Dy=0D=0A#=20CONFIG_TRACEPOINT_BENCHMARK=20is=20not=20=
set=0D=0A#=20CONFIG_RING_BUFFER_BENCHMARK=20is=20not=20set=0D=0A#=20CONFIG_=
TRACE_EVAL_MAP_FILE=20is=20not=20set=0D=0A#=20CONFIG_FTRACE_STARTUP_TEST=20=
is=20not=20set=0D=0A#=20CONFIG_RING_BUFFER_STARTUP_TEST=20is=20not=20set=0D=
=0ACONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=3Dy=0D=0A#=20CONFIG_PREEMPTIRQ_D=
ELAY_TEST=20is=20not=20set=0D=0A#=20CONFIG_RV=20is=20not=20set=0D=0ACONFIG_=
PROVIDE_OHCI1394_DMA_INIT=3Dy=0D=0A#=20CONFIG_SAMPLES=20is=20not=20set=0D=
=0ACONFIG_HAVE_SAMPLE_FTRACE_DIRECT=3Dy=0D=0ACONFIG_HAVE_SAMPLE_FTRACE_DIRE=
CT_MULTI=3Dy=0D=0ACONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy=0D=0A#=20CONFIG_STR=
ICT_DEVMEM=20is=20not=20set=0D=0A=0D=0A#=0D=0A#=20x86=20Debugging=0D=0A#=0D=
=0ACONFIG_EARLY_PRINTK_USB=3Dy=0D=0ACONFIG_X86_VERBOSE_BOOTUP=3Dy=0D=0ACONF=
IG_EARLY_PRINTK=3Dy=0D=0ACONFIG_EARLY_PRINTK_DBGP=3Dy=0D=0A#=20CONFIG_EARLY=
_PRINTK_USB_XDBC=20is=20not=20set=0D=0A#=20CONFIG_DEBUG_TLBFLUSH=20is=20not=
=20set=0D=0ACONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy=0D=0A#=20CONFIG_X86_DECODER_S=
ELFTEST=20is=20not=20set=0D=0ACONFIG_IO_DELAY_0X80=3Dy=0D=0A#=20CONFIG_IO_D=
ELAY_0XED=20is=20not=20set=0D=0A#=20CONFIG_IO_DELAY_UDELAY=20is=20not=20set=
=0D=0A#=20CONFIG_IO_DELAY_NONE=20is=20not=20set=0D=0ACONFIG_DEBUG_BOOT_PARA=
MS=3Dy=0D=0A#=20CONFIG_CPA_DEBUG=20is=20not=20set=0D=0ACONFIG_DEBUG_ENTRY=
=3Dy=0D=0A#=20CONFIG_DEBUG_NMI_SELFTEST=20is=20not=20set=0D=0ACONFIG_X86_DE=
BUG_FPU=3Dy=0D=0A#=20CONFIG_PUNIT_ATOM_DEBUG=20is=20not=20set=0D=0ACONFIG_U=
NWINDER_ORC=3Dy=0D=0A#=20CONFIG_UNWINDER_FRAME_POINTER=20is=20not=20set=0D=
=0A#=20end=20of=20x86=20Debugging=0D=0A=0D=0A#=0D=0A#=20Kernel=20Testing=20=
and=20Coverage=0D=0A#=0D=0A#=20CONFIG_KUNIT=20is=20not=20set=0D=0A#=20CONFI=
G_NOTIFIER_ERROR_INJECTION=20is=20not=20set=0D=0ACONFIG_FAULT_INJECTION=3Dy=
=0D=0ACONFIG_FAILSLAB=3Dy=0D=0ACONFIG_FAIL_PAGE_ALLOC=3Dy=0D=0ACONFIG_FAULT=
_INJECTION_USERCOPY=3Dy=0D=0ACONFIG_FAIL_MAKE_REQUEST=3Dy=0D=0ACONFIG_FAIL_=
IO_TIMEOUT=3Dy=0D=0ACONFIG_FAIL_FUTEX=3Dy=0D=0ACONFIG_FAULT_INJECTION_DEBUG=
_FS=3Dy=0D=0A#=20CONFIG_FAIL_MMC_REQUEST=20is=20not=20set=0D=0A#=20CONFIG_F=
AIL_SKB_REALLOC=20is=20not=20set=0D=0ACONFIG_FAULT_INJECTION_CONFIGFS=3Dy=
=0D=0A#=20CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=20is=20not=20set=0D=0ACO=
NFIG_ARCH_HAS_KCOV=3Dy=0D=0ACONFIG_KCOV=3Dy=0D=0ACONFIG_KCOV_ENABLE_COMPARI=
SONS=3Dy=0D=0ACONFIG_KCOV_INSTRUMENT_ALL=3Dy=0D=0ACONFIG_KCOV_IRQ_AREA_SIZE=
=3D0x40000=0D=0A#=20CONFIG_KCOV_SELFTEST=20is=20not=20set=0D=0ACONFIG_RUNTI=
ME_TESTING_MENU=3Dy=0D=0A#=20CONFIG_TEST_DHRY=20is=20not=20set=0D=0A#=20CON=
FIG_LKDTM=20is=20not=20set=0D=0A#=20CONFIG_TEST_MIN_HEAP=20is=20not=20set=
=0D=0A#=20CONFIG_TEST_DIV64=20is=20not=20set=0D=0A#=20CONFIG_TEST_MULDIV64=
=20is=20not=20set=0D=0A#=20CONFIG_BACKTRACE_SELF_TEST=20is=20not=20set=0D=
=0A#=20CONFIG_TEST_REF_TRACKER=20is=20not=20set=0D=0A#=20CONFIG_RBTREE_TEST=
=20is=20not=20set=0D=0A#=20CONFIG_REED_SOLOMON_TEST=20is=20not=20set=0D=0A#=
=20CONFIG_INTERVAL_TREE_TEST=20is=20not=20set=0D=0A#=20CONFIG_PERCPU_TEST=
=20is=20not=20set=0D=0A#=20CONFIG_ATOMIC64_SELFTEST=20is=20not=20set=0D=0A#=
=20CONFIG_TEST_HEXDUMP=20is=20not=20set=0D=0A#=20CONFIG_TEST_KSTRTOX=20is=
=20not=20set=0D=0A#=20CONFIG_TEST_BITMAP=20is=20not=20set=0D=0A#=20CONFIG_T=
EST_UUID=20is=20not=20set=0D=0A#=20CONFIG_TEST_XARRAY=20is=20not=20set=0D=
=0A#=20CONFIG_TEST_MAPLE_TREE=20is=20not=20set=0D=0A#=20CONFIG_TEST_RHASHTA=
BLE=20is=20not=20set=0D=0A#=20CONFIG_TEST_IDA=20is=20not=20set=0D=0A#=20CON=
FIG_TEST_LKM=20is=20not=20set=0D=0A#=20CONFIG_TEST_BITOPS=20is=20not=20set=
=0D=0A#=20CONFIG_TEST_VMALLOC=20is=20not=20set=0D=0A#=20CONFIG_TEST_BPF=20i=
s=20not=20set=0D=0A#=20CONFIG_FIND_BIT_BENCHMARK=20is=20not=20set=0D=0A#=20=
CONFIG_TEST_FIRMWARE=20is=20not=20set=0D=0A#=20CONFIG_TEST_SYSCTL=20is=20no=
t=20set=0D=0A#=20CONFIG_TEST_UDELAY=20is=20not=20set=0D=0A#=20CONFIG_TEST_S=
TATIC_KEYS=20is=20not=20set=0D=0A#=20CONFIG_TEST_DYNAMIC_DEBUG=20is=20not=
=20set=0D=0A#=20CONFIG_TEST_KMOD=20is=20not=20set=0D=0A#=20CONFIG_TEST_KALL=
SYMS=20is=20not=20set=0D=0A#=20CONFIG_TEST_DEBUG_VIRTUAL=20is=20not=20set=
=0D=0A#=20CONFIG_TEST_MEMCAT_P=20is=20not=20set=0D=0A#=20CONFIG_TEST_MEMINI=
T=20is=20not=20set=0D=0A#=20CONFIG_TEST_FREE_PAGES=20is=20not=20set=0D=0A#=
=20CONFIG_TEST_CLOCKSOURCE_WATCHDOG=20is=20not=20set=0D=0A#=20CONFIG_TEST_O=
BJPOOL=20is=20not=20set=0D=0ACONFIG_ARCH_USE_MEMTEST=3Dy=0D=0A#=20CONFIG_ME=
MTEST=20is=20not=20set=0D=0A#=20end=20of=20Kernel=20Testing=20and=20Coverag=
e=0D=0A=0D=0A#=0D=0A#=20Rust=20hacking=0D=0A#=0D=0A#=20end=20of=20Rust=20ha=
cking=0D=0A#=20end=20of=20Kernel=20hacking=0D=0A=0D=0ACONFIG_IO_URING_ZCRX=
=3Dy=0D=0A
------=_Part_94736_393766498.1762866861171--


