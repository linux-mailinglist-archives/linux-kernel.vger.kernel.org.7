Return-Path: <linux-kernel+bounces-809206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3842B50A03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0597188911D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B201C84CB;
	Wed, 10 Sep 2025 00:53:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9913AD1C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465587; cv=none; b=Wc4o8qmQHqtSXj8b1Qoqs2yHfRBeLPeZPoiyo8Eadi+zB2pMDYXNKd/fb5cg+1ahv1HpG5661ytlW/Q2m9AIS9y0j9sKxmtQbEYTorSiOdjw46RrxOVz9Spq/RUEy7XbVeZI6zv0gARc8Q3tNt2QMxJG+iiBVxcVzWUjkUXDhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465587; c=relaxed/simple;
	bh=2U9n+JAOnYS5Q+iSqMPgNOYgE/riwips5sMtXm16Cu8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KtEdobTLa2QoIWlDJfyJ2CQOGfOq2k/CaL8SXfDvEIYe4GC2J+96LBwCU5r5TjA6QcOTNq83jkoK986WCOhlRlasurnZYYutyT/aJl5aX2PaRbLN3kb/mUREcQ7ZWCsH19A6gE2lEu1QE2ApOxpZV7JhZT8zOyX7VK5Qzy8cOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-404746a9c67so37252835ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757465585; x=1758070385;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHQjMJ6GuFNucKgYSkrR1EeUATOBgrglA3Nkc94nxI8=;
        b=xUNdl71SRYInpL8ezpf6Qcl0PqfEqtGQViZ686FBofZesywUmgk4n9xHw9ZDBUoT6R
         RauOOz+0MVjbNbH0MPUMA8Km0d4eKoQq6mni6fqvtVDqP+5IWBosjKwZtNZdFx4bsPN1
         dKLExkwJ5JvKuKjGjdFc9nQgtSFUClbIl2taomoCCHQdzVQblBTEM/bMRgXmdgL8I6zc
         qkshIVExvAKLMjToSUBrTPVHgAf20Xw/PFIW/Gckxo8hLgtgdIzUYBd4Hn76ErGmMwSS
         C9WLV5OGejg7ORHpB5rJRHsmCZi+s5Pz7gMFCQFsa/EBPZHd/GQVCPAGKeYarN2qeDFC
         n+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW+8E4fmrDcdl526NTl0CGnQOBCe13kBkpHWvGe/BUX0wt/LRGeBzFpYVLVdzvjceMIpRZ3mJDmcbI5jMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWlNtct8AwYkWq6MMAWD2k/B32wV+W5BT8XWSMmvu7proWGRti
	kO+jEYv9iMeZjl8mbwVZqYPM8TeYmN4Y6C8415C6U4qGWH8Vw7TpNSiq2w5hKjpOP7Yc8vFHIUc
	BFkLkpt+Ev8MMk9jrrmoHUwVAOgQG+33rOEzGczc0lszQO0EOG2GQSDw6XzE=
X-Google-Smtp-Source: AGHT+IHkjsV0je4cG4SZ/pellk8DC7otHEP1rFjKtFj0p2amtHqNoI5JuPre4GAjH6nsP8FjFnXJXempWfxa5Jn1b71wFSaD4YbI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a63:b0:414:cb8e:a801 with SMTP id
 e9e14a558f8ab-414cb8ebdffmr44181115ab.29.1757465585468; Tue, 09 Sep 2025
 17:53:05 -0700 (PDT)
Date: Tue, 09 Sep 2025 17:53:05 -0700
In-Reply-To: <20250910000310.6672-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c0cbf1.a70a0220.3543fc.000a.GAE@google.com>
Subject: Re: [syzbot] [kvmarm?] [kvm?] WARNING: locking bug in vgic_put_irq
From: syzbot <syzbot+cef594105ac7e60c6d93@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy binary to VM: failed to run ["scp" "-P" "8142" "-F" "/dev/nu=
ll" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "IdentitiesOnly=3Dyes" "-o" =
"BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o" "ConnectTimeout=3D=
10" "/tmp/syz-executor2510371855" "root@localhost:/syz-executor2510371855"]=
: exit status 255
Connection timed out during banner exchange
Connection to 127.0.0.1 port 8142 timed out
scp: Connection closed




syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOARCH=3D'arm64'
GOARM64=3D'v8.0'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -pthread -Wl,--no-gc-sections -fmessage-length=3D0 -ffi=
le-prefix-map=3D/tmp/go-build2016643261=3D/tmp/go-build -gno-record-gcc-swi=
tches'
GOHOSTARCH=3D'arm64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_arm64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at bf27483f96
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3Dbf27483f963359281b2d9b6d6efd36289f82e282 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20250821-140520"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3Dbf27483f963359281b2d9b6d6efd36289f82e282 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20250821-140520"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Darm64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dbf27483f963359281b2d9b6d6efd36289f82e282 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250821-140520"  -o ./bi=
n/linux_arm64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_arm64
g++ -o ./bin/linux_arm64/syz-executor executor/executor.cc \
	-O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-l=
arger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-ove=
rflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -stati=
c-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH_arm6=
4=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"bf27483f963359281b2d9b6d6efd36289f=
82e282\"
/usr/bin/ld: /tmp/ccD2Uc1q.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0xd8): warning: Using 'gethostbyname' in statically linked applicati=
ons requires at runtime the shared libraries from the glibc version used fo=
r linking



Tested on:

commit:         aae5a983 Merge branch kvm-arm64/misc-6.18 into kvmarm-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm=
.git next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da348a32a552b643=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dcef594105ac7e60c6=
d93
compiler:       Debian clang version 20.1.8 (++20250708123704+0de59a293f7a-=
1~exp1~20250708003721.134), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D11814d625800=
00


